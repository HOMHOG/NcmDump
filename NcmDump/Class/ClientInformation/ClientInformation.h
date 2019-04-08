//
//  ClientInformation.h
//  NcmDump
//
//  Created by 丁嘉睿 on 2019/4/2.
//  Copyright © 2019 丁嘉睿. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 监听是否有新版本 */
extern NSString * const ClientInformationNotificationCenterForDownloadUpdateFileKey;

@interface ClientInformation : NSObject

/** 是否准备完全（只有YES才可以获取） */
@property (nonatomic, assign) BOOL isReady;

/**
  applicationDidFinishLaunching 使用必须第一句
 */
+ (void)start;

+ (NSString *)updateVersionUrlStrong;

@end

NS_ASSUME_NONNULL_END
