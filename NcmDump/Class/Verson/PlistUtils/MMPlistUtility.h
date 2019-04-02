//
//  MMPlistUtility.h
//  MiracleMessenger
//
//  Created by LamTsanFeng on 15/4/21.
//  Copyright (c) 2015年 GZMiracle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMPlistUtility : NSObject

/** 读取Dictionary plist文件 */
+ (id)readDicPlistFile:(NSString *)fileName isMutable:(BOOL)isMutable;
/** 读取Array plist文件 */
+ (id)readArrayPlistFile:(NSString *)fileName isMutable:(BOOL)isMutable;

/** 写入plist文件 NSDictionary或NSArray */
+ (BOOL)writePlistFile:(id)plist fileName:(NSString *)fileName;
@end
