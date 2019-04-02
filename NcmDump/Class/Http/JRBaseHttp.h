//
//  JRBaseHttp.h
//  NcmDump
//
//  Created by 丁嘉睿 on 2019/4/1.
//  Copyright © 2019 丁嘉睿. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JRBaseHttp : NSObject

+ (instancetype)shareHttp;

- (void)httpDownLoadURL:(NSString *)downloadURLString
               filePath:(NSString *)filePath
               complete:(void(^)(NSError * _Nullable error, NSURL * _Nullable filePath))completeBlock;
@end

NS_ASSUME_NONNULL_END
