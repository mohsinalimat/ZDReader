//
//  ZSEncryptorAESUtils.swift
//  ZDReader
//
//  Created by Noah on 2018/11/9.
//  Copyright © 2018年 ZD. All rights reserved.
//

import UIKit

class ZSEncryptorAESUtils {
    
    func getDecryptedStr(key:String, cipherText:String) {
        let keyData = Data(base64Encoded: key, options: Data.Base64DecodingOptions(rawValue: 0))
        let data = Data(base64Encoded: cipherText, options: Data.Base64DecodingOptions(rawValue: 0))
        
        
    }

}
