//
//  ClientInformation.m
//  NcmDump
//
//  Created by 丁嘉睿 on 2019/4/2.
//  Copyright © 2019 丁嘉睿. All rights reserved.
//

#import "ClientInformation.h"
#import "JRBaseHttp+Download.h"
#import "MMPlistUtility.h"

static NSDictionary *_clientDic;

static BOOL _isFinish = NO;

NSString const * version_key = @"Version";
NSString const * UpdateUrl_key = @"UpdateUrl";

NSString * const ClientInformationNotificationCenterForDownloadUpdateFileKey = @"ClientInformationNotificationCenterForDownloadUpdateFileKey";

@implementation ClientInformation

+ (void)start
{
    [JRBaseHttp downloadAppPlistWithComplete:^(NSError * _Nullable error, NSURL * _Nullable filePath) {
        _isFinish = YES;
        _clientDic = [MMPlistUtility readDicPlistFile:filePath.path isMutable:NO];
        if ([ClientInformation newVersion]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:ClientInformationNotificationCenterForDownloadUpdateFileKey object:nil];
        }
    }];
}

- (BOOL)isReady
{
    return _isFinish;
}

+ (BOOL)newVersion
{
    NSString *version = [_clientDic objectForKey:version_key];
    NSString *name = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    if ([version compare:name] == NSOrderedDescending) {
        return YES;
    }
    return NO;
}

+ (NSString *)updateVersionUrlStrong
{
    return [_clientDic objectForKey:UpdateUrl_key];
}

@end
