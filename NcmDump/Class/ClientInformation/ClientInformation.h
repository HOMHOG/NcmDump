//
//  ClientInformation.h
//  NcmDump
//
//  Created by 丁嘉睿 on 2019/4/2.
//  Copyright © 2019 丁嘉睿. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const ClientInformationNotificationCenterForDownloadUpdateFileKey;

@interface ClientInformation : NSObject


/**
  applicationDidFinishLaunching 使用必须第一句
 */
+ (void)start;

+ (BOOL)newVersion;

+ (NSString *)updateVersionUrlStrong;
@end

NS_ASSUME_NONNULL_END
