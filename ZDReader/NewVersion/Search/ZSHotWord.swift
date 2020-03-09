//
//  ZSHotWord.swift
//  zhuishushenqi
//
//  Created by caony on 2019/10/22.
//  Copyright © 2019 QS. All rights reserved.
//

import UIKit
import HandyJSON

struct ZSHotWord:HandyJSON,Equatable {

    var word:String = ""
    var book:String = ""
    var frame:CGRect = CGRect.zero
    init() {
        
    }
}
