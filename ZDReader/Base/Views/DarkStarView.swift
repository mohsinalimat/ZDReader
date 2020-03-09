//
//  DarkStarView.swift
//  ZDReader
//
//  Created by Noah on 2017/3/9.
//  Copyright © 2017年 ZD. All rights reserved.
//

import UIKit

class DarkStarView: UIImageView {

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.image = UIImage(named: "bd_star_empty")
////        bd_star_empty
//    }
    
    init(frame: CGRect,image:UIImage?) {
        super.init(frame: frame)
        self.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
