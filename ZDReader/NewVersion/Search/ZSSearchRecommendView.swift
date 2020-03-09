//
//  ZSSearchRecommendView.swift
//  zhuishushenqi
//
//  Created by caony on 2019/10/23.
//  Copyright © 2019 QS. All rights reserved.
//

import UIKit

typealias ZSSearchRecHandler = (_ hotword:ZSHotWord)->Void

typealias ZSSearchHistoryHandler = (_ history:ZSSearchHistory)->Void

class ZSSearchRecommendView: UIView {
    
    var cellsFrame:[ZSHotWord] = [] { didSet { reloadData() } }
    
    var clickHandler:ZSSearchClickHandler?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func reloadData() {
        removeAllSubviews()
        for cellModel in cellsFrame {
            let cell = ZSSearchRecommendCell(title: cellModel.word, maxSize: cellModel.frame.size)
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(tap:)))
            cell.addGestureRecognizer(tap)
            cell.frame = cellModel.frame
            addSubview(cell)
        }
    }
    
    @objc
    func tapAction(tap:UITapGestureRecognizer) {
        for cellModel in cellsFrame {
            if cellModel.frame.contains(tap.location(in: self)) {
                clickHandler?(cellModel.word)
                break
            }
        }
    }
    
}

class ZSSearchRecommendCell: UIView {
    
    lazy var titleLabel:UILabel = {
        let lb = UILabel(frame: .zero)
        lb.textColor = UIColor.gray
        lb.font = UIFont.systemFont(ofSize: 13)
        lb.textAlignment = .left
        return lb
    }()
    
    lazy var iconView:UIImageView = {
        let icon = UIImageView(frame: .zero)
        icon.image = UIImage(named: "")
        icon.backgroundColor = UIColor.gray
        return icon
    }()
    
    convenience init(title:String, maxSize:CGSize) {
        self.init()
        addSubview(self.titleLabel)
        addSubview(self.iconView)
        self.titleLabel.text = title
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.iconView.frame = CGRect(x: 0, y: 4, width: 14, height: 14)
        self.titleLabel.frame = CGRect(x: 19, y: 0, width: self.bounds.width - 19, height: 21)
    }
}

