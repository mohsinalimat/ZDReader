//
//  ZSReaderCache.swift
//  zhuishushenqi
//
//  Created by caony on 2019/9/20.
//  Copyright © 2019 QS. All rights reserved.
//

import UIKit

class ZSReaderCache {
    
    fileprivate var book:BookDetail!
    
    fileprivate var sourceIndex = 1
    
    fileprivate var cachedChapter:[String:QSChapter] = [:]

    static let shared = ZSReaderCache()
    private init() {
        
    }
    
    // 将新获取的章节信息存入chapterDict中
    @discardableResult
    private func storeChapter(body:ZSChapterBody,index:Int)->QSChapter? {
        let chapterModel = self.book?.chaptersInfo?[safe: index]
        let qsChapter = QSChapter()
        if let link = chapterModel?.link {
            qsChapter.link = link
            // 如果使用追书正版书源，取的字段应该是cpContent，需要根据当前选择的源进行判断
            qsChapter.isVip = chapterModel?.isVip ?? false
            qsChapter.order = chapterModel?.order ?? 0
            qsChapter.currency = chapterModel?.currency ?? 0
            qsChapter.cpContent = body.cpContent
            qsChapter.id = body.id
            qsChapter.content = body.body
            if let title = chapterModel?.title {
                qsChapter.title = title
            }
            qsChapter.curChapter = index
            qsChapter.getPages() // 直接计算page
            cachedChapter[link] = qsChapter
            return qsChapter
        }
        return nil
    }
}
