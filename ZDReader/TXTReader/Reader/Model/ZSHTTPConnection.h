//
//  ZSHTTPConnection.h
//  ZDReader
//
//  Created by Noah on 2018/7/30.
//  Copyright © 2018年 ZD. All rights reserved.
//

#import "HTTPConnection.h"

@class MultipartFormDataParser;


@interface ZSHTTPConnection : HTTPConnection{
    MultipartFormDataParser *parser;
    NSFileHandle *storeFile;
    NSMutableArray *uploadedFiles;
    
}

@end

FOUNDATION_EXTERN NSString *const ZSHTTPConnectionUploadFileFinished;
