//
//  JRBaseHttp+Download.m
//  NcmDump
//
//  Created by 丁嘉睿 on 2019/4/2.
//  Copyright © 2019 丁嘉睿. All rights reserved.
//

#import "JRBaseHttp+Download.h"
#import "MMFileUtility.h"

@implementation JRBaseHttp (Download)

+ (void)downloadAppPlistWithComplete:(void (^)(NSError * _Nullable, NSURL * _Nullable))completeBlock
{
    NSString *cachePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0] stringByAppendingPathComponent:@"JRCache"];
    if ([MMFileUtility directoryExist:cachePath]) {
        [MMFileUtility createFolder:cachePath errStr:nil];
    }
    [[JRBaseHttp shareHttp] httpDownLoadURL:@"http://ppbj1cq4j.bkt.clouddn.com/JRNcm.plist" filePath:cachePath complete:^(NSError * _Nullable error, NSURL * _Nullable filePath) {
        if (completeBlock) {
            completeBlock(error, filePath);
        }
    }];
}

@end
