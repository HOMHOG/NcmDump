//
//  JRBaseHttp+Download.h
//  NcmDump
//
//  Created by 丁嘉睿 on 2019/4/2.
//  Copyright © 2019 丁嘉睿. All rights reserved.
//

#import "JRBaseHttp.h"

NS_ASSUME_NONNULL_BEGIN

@interface JRBaseHttp (Download)

+ (void)downloadAppPlistWithComplete:(void(^)(NSError * _Nullable error, NSURL * _Nullable filePath))completeBlock;

@end

NS_ASSUME_NONNULL_END
