//
//  ZSMyFooterView.swift
//  ZDReader
//
//  Created by caonongyun on 2020/3/9.
//  Copyright © 2020 QS. All rights reserved.
//

import UIKit

typealias ZSMyFooterHandler = ()->Void

class ZSMyFooterView: UITableViewHeaderFooterView {
    
    var button:UIButton!
    
    var footerHandler:ZSMyFooterHandler?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        button = UIButton(type: .custom)
        button.setTitle("退出登录", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.red
        button.frame = CGRect(x: 20, y: 25, width: self.bounds.width - 40, height: 50)
        button.addTarget(self, action: #selector(footerAction(btn:)), for: .touchUpInside)
        self.addSubview(button)
    }
    
    @objc
    func footerAction(btn:UIButton) {
        footerHandler?()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame = CGRect(x: 20, y: 25, width: self.bounds.width - 40, height: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
