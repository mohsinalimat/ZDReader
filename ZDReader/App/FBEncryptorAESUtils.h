//
//  FBEncryptorAESUtils.h
//  ZDReader
//
//  Created by Noah on 2018/11/9.
//  Copyright © 2018年 ZD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FBEncryptorAESUtils : NSObject

+ (NSString *)getDecryptedStrWithKey:(NSString *)key cipherText:(NSString *)cipherText;

@end

NS_ASSUME_NONNULL_END
