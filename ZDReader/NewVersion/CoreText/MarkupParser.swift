//
//  MarkupParser.swift
//  CoreTextDemo
//
//  Created by caony on 2019/7/11.
//  Copyright © 2019 cj. All rights reserved.
//

import UIKit
import CoreText

enum ZSParseType: String, Codable {
    case none = ""
    case image = "image"
    case link = "link"
    case book = "book"
    case booklist = "booklist"
    case post = "post"
}

struct ZSImageParse:Codable {
    var type:ZSParseType = .image
    var url:String = ""
    var size:CGSize = CGSize.zero
}

struct ZSDisplayConfig {
    var margin:CGFloat = 20
    var width:CGFloat = ZSReader.share.contentFrame.width
    var fontSize:CGFloat = ZSReader.share.theme.fontSize.size
    var textColor = AppStyle.shared.reader.textColor
    var lineSpace:CGFloat = ZSReader.share.theme.lineSpace
    var paragraphSpace = ZSReader.share.theme.paragraphSpace
    var textFont = UIFont.systemFont(ofSize: ZSReader.share.theme.fontSize.size)
}

class MarkupParser: NSObject {
    // MARK: - Properties
    var attrString: NSMutableAttributedString!
    var config:ZSDisplayConfig!
    var data:ZSTextData?
    
    // MARK: - Initializers
    private override init() {
        super.init()
    }
    
    convenience init(config:ZSDisplayConfig) {
        self.init()
        self.config = config
    }
    
    private let kBookNamePattern = "(《.*?》)" // 《❤温馨小贴士》
    private let kTextLinkPattern = "(\\[\\[.*?\\]\\])" // [[post:5b50550d6f788aef59667822 【传送门】告别燥热？这样玩转书单还有惊喜大礼！]]
    private let kBookJumpPattern = "(\\{\\{.*?\\}\\})" // {{type:image,url:http%3A%2F%2Fstatics.zhuishushenqi.com%2Fpost%2F151678369762541,size:420-422}}
    
    // MARK: - zssq parse
    func parse(_ content: String) {
        attrString = NSMutableAttributedString(string: "")
        let pattern = "\(kBookNamePattern)|\(kBookJumpPattern)|\(kTextLinkPattern)"
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [.caseInsensitive,.dotMatchesLineSeparators])
            let chunks = regex.matches(in: content, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSRange(location: 0, length: content.count))
            var images:[ZSImageData] = []
            var links:[ZSLinkData] = []
            var books:[ZSBookData] = []
            var lastRange:NSRange = NSMakeRange(0, 0)
            for chunk in chunks {
                guard let markupRange = content.range(from: chunk.range) else {
                    lastRange = chunk.range
                    continue
                }
                let chunkSubStr = content[markupRange]
                let chunkStr = String(chunkSubStr)
                if let preTextRange = content.range(from: NSMakeRange(lastRange.location + lastRange.length, chunk.range.location - lastRange.location - lastRange.length)) {
                    let preText = String(content[preTextRange])
                    let text = NSMutableAttributedString(string: preText, attributes: textAttribute())
                    attrString.append(text)
                }
                // image
                if chunkStr.contains("{{") {
                    let imageModel = parse(imageStr: chunkStr)
                    if imageModel.type == .image {
                        var imageData = ZSImageData()
                        imageData.position = attrString.length
                        imageData.parse = imageModel
                        images.append(imageData)
                        var width: CGFloat = imageData.parse?.size.width ?? 0
                        var height: CGFloat = imageData.parse?.size.height ?? 0
                        if width > config.width {
                            height = height/width * config.width
                            width = config.width
                        }
                        let attr = imageAttribute(width: width, height: height)
                        attrString.append(attr)
                    }
                } else if chunkStr.contains("[[") { // link(post/booklist)
                    if var linkData = linkData(str: chunkStr) {
                        linkData.range = NSMakeRange(attrString.length, linkData.title.count)
                        links.append(linkData)
                        let text = NSMutableAttributedString(string: linkData.title, attributes: linkAttribute())
                        attrString.append(text)
                    }
                } else if chunkStr.contains("《") {
                    let text = NSMutableAttributedString(string: chunkStr, attributes: linkAttribute())
                    let book = parse(book: chunkStr)
                    books.append(book)
                    attrString.append(text)
                }
                lastRange = chunk.range
            }
            if lastRange.location + lastRange.length < content.count {
                if let remainContentRange = content.range(from: NSMakeRange(lastRange.location + lastRange.length, content.count - lastRange.location - lastRange.length)) {
                    let remainContent = String(content[remainContentRange])
                    let text = NSMutableAttributedString(string: remainContent, attributes: textAttribute())
                    attrString.append(text)
                }
            }
            let framesetter = CTFramesetterCreateWithAttributedString(attrString as CFAttributedString)
            let textSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, CGSize(width: config.width, height: CGFloat.greatestFiniteMagnitude), nil)
            
            var coreData = ZSTextData()
            coreData.books = books
            coreData.images = images
            coreData.links = links
            coreData.height = textSize.height
            self.data = coreData
        } catch _ {}
    }
    
    
    /// 解析富文本中书籍数据,一般用《》括起
    /// - Parameter book:返回书籍的model
    private func parse(book:String) ->ZSBookData {
        var bookModel = ZSBookData()
        bookModel.content = book
        bookModel.type = .book
        return bookModel
    }
    
    /// 解析富文本中的图片
    /// - Parameter imageStr: 图片原字符串
    private func parse(imageStr: String) ->ZSImageParse {
        var chunkStr = imageStr.replacingOccurrences(of: "{{", with: "")
        chunkStr = chunkStr.replacingOccurrences(of: "}}", with: "")
        var imageDic:[String:Any] = [:]
        let keyValueString = chunkStr.components(separatedBy: ",")
        for item in keyValueString {
            let keyValues = item.components(separatedBy: ":")
            if keyValues.count != 2 {
                continue
            }
            if keyValues.first! != "size" {
                imageDic[keyValues.first!] = keyValues.last!.removingPercentEncoding ?? ""
                continue
            }
            let sizes = keyValues.last!.components(separatedBy: "-")
            if sizes.count != 2 {
                continue
            }
            let size = CGSize(width: Double(sizes.first!) ?? 0, height: Double(sizes.last!) ?? 0)
            imageDic[keyValues.first!] = size
        }
        var imageParse = ZSImageParse()
        imageParse.type = ZSParseType.init(rawValue: imageDic["type"] as? String ?? "") ?? .none
        imageParse.size = imageDic["size"] as? CGSize ?? CGSize.zero
        imageParse.url = imageDic["url"] as? String ?? ""
        return imageParse
    }
    
    
    /// 获取链接的model数据
    /// - Parameter str: 连接的原字符
    private func linkData(str:String) ->ZSLinkData? {
        var linkStr = str.replacingOccurrences(of: "[[", with: "")
        linkStr = linkStr.replacingOccurrences(of: "]]", with: "")
        let links = linkStr.components(separatedBy: ":")
        if links.count == 2 {
            // 这里有三种情况，post/link/booklist
            // 先取key 判断类型
            let key = links.first!
            guard let type = ZSParseType.init(rawValue: key) else {
                return nil
            }
            switch type{
            case .post, .booklist, .link, .book:
                let postValue = links.last!
                // 第一个空格进行分割
                guard let range = postValue.range(of: " ") else {
                    return nil
                }
                let startPos = String.Index.init(utf16Offset: 0, in: postValue)
                let link = String(postValue[startPos..<range.lowerBound])
                let endPos = String.Index.init(utf16Offset: link.count, in: postValue)
                let title = String(postValue[endPos...])
                var linkData = ZSLinkData()
                linkData.key = links.first!
                linkData.linkTo = link
                linkData.url = link
                linkData.title = title
                linkData.type = type
                return linkData
            default:
                break
            }
        }
        return nil
    }
    
    /// 获取文字的attr配置
    private func textAttribute() ->[NSAttributedString.Key:Any] {
        let attrs = ZSReader.share.attributes()
        return attrs
    }
    
    
    /// 获取链接的attr配置
    private func linkAttribute() ->[NSAttributedString.Key:Any] {
        
        let linkColor = UIColor.orange
        var attrs = ZSReader.share.attributes()
        attrs[NSAttributedString.Key.foregroundColor] = linkColor
        return attrs
    }
    
    /// 获取图片的占位符AttributedString
    /// - Parameters:
    ///   - width: 图片宽度
    ///   - height: 图片高度
    private func imageAttribute(width:CGFloat, height:CGFloat) ->NSAttributedString {
        struct RunStruct {
            let ascent: CGFloat
            let descent: CGFloat
            let width: CGFloat
        }
        
        let extentBuffer = UnsafeMutablePointer<RunStruct>.allocate(capacity: 1)
        extentBuffer.initialize(to: RunStruct(ascent: height, descent: 0, width: width))
        //3
        var callbacks = CTRunDelegateCallbacks(version: kCTRunDelegateVersion1, dealloc: { (pointer) in
        }, getAscent: { (pointer) -> CGFloat in
            let d = pointer.assumingMemoryBound(to: RunStruct.self)
            return d.pointee.ascent
        }, getDescent: { (pointer) -> CGFloat in
            let d = pointer.assumingMemoryBound(to: RunStruct.self)
            return d.pointee.descent
        }, getWidth: { (pointer) -> CGFloat in
            let d = pointer.assumingMemoryBound(to: RunStruct.self)
            return d.pointee.width
        })
        //4
        let delegate = CTRunDelegateCreate(&callbacks, extentBuffer)
        //5
        let attrDictionaryDelegate = [(kCTRunDelegateAttributeName as NSAttributedString.Key): (delegate as Any)]
        var objectReplacementChar:unichar = 0xFFFC
        let content = NSString(characters: &objectReplacementChar, length: 1)
        let attrStr = NSMutableAttributedString(string: String(content), attributes: attrDictionaryDelegate)
        attrStr.addAttributes(textAttribute(), range: NSMakeRange(0, attrStr.length))
        return attrStr
    }
    
    /// 检测点击位置是都在链接上
    /// - Parameters:
    ///   - view: 点击view
    ///   - point: 点击坐标
    ///   - data: 所有的data
    static func link(in view:UIView, point:CGPoint, data:ZSTextData) ->ZSLinkData? {
        let idx = touchOffset(in: view, point: point, data: data)
        if idx == -1 {
            return nil
        }
        if let link = link(at: idx, links: data.links) {
            return link
        }
        return nil
    }
    
    
    /// 将点击的位置转换成字符串的偏移量
    /// - Parameters:
    ///   - view: 点击view
    ///   - point: 点击坐标
    ///   - data: 所有的data
    static func touchOffset(in view:UIView, point:CGPoint, data:ZSTextData) ->Int {
        var idx = -1
        if let ctFrame = data.ctFrame {
            let lines = CTFrameGetLines(ctFrame) as NSArray
            let count = lines.count
            if count == 0 {
                return -1
            }
            var origins = [CGPoint](repeating: CGPoint.zero, count: lines.count)
            CTFrameGetLineOrigins(ctFrame, CFRange(location: 0, length: 0), &origins)
            for index in 0..<lines.count {
                let line = lines[index] as! CTLine
                let origin = origins[index]
                var ascent: CGFloat = 0
                var descent: CGFloat = 0
                let width:CGFloat = CGFloat(CTLineGetTypographicBounds(line, &ascent, &descent, nil))
                let height = ascent + descent
                let lineRect = CGRect(x: origin.x, y: view.bounds.height - origin.y - (ascent + descent), width: width, height: height)
                if lineRect.contains(point) {
                    let relativePoint = CGPoint(x: point.x - lineRect.origin.x, y: point.y - lineRect.origin.y)
                    idx = CTLineGetStringIndexForPosition(line, relativePoint)
                }
            }
        }
        return idx
    }
    
    static func link(at index:Int, links:[ZSLinkData]) ->ZSLinkData? {
        var linkData:ZSLinkData? = nil
        for link in links {
            if link.range.contains(index) {
                linkData = link
                break
            }
        }
        return linkData
    }
}

extension String {
    func range(from range: NSRange) -> Range<String.Index>? {
        guard let from16 = utf16.index(utf16.startIndex,
                                       offsetBy: range.location,
                                       limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: range.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self) else {
                return nil
        }
        
        return from ..< to
    }
}
