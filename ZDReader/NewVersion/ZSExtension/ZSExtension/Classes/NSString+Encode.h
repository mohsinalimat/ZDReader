//
//  NSString+Encode.h
//  zhuishushenqi
//
//  Created by Noah on 2017/4/26.
//  Copyright © 2017年 ZD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encode)

- (NSString*)urlEncode;
- (NSString *)urlDecode;
- (NSString *)zs_urlDecode;

@end
