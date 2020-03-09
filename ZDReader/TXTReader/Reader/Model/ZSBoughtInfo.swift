//
//  ZSBoughtInfo.swift
//  ZDReader
//
//  Created by Noah on 2018/11/15.
//  Copyright © 2018 ZD. All rights reserved.
//

import UIKit
import HandyJSON

class ZSBoughtItem: NSObject, HandyJSON {
    var order:Int = 0
    var key:String = ""
    
    required override init(){}
}

class ZSBoughtInfo: NSObject, HandyJSON {
    var keys:[ZSBoughtItem] = []
    var ok = false
    required override init(){}

}
