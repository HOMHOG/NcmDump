//
//  MMFileUtility.h
//  SocketClientDemo
//
//  Created by AnsonLo on 13-7-26.
//  Copyright (c) 2013年 ansonkid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMFileUtility : NSObject

+ (BOOL)createFile:(NSString *)path;
+ (BOOL)createFolder:(NSString *)path errStr:(NSString **)errStr;
+ (BOOL)fileExist:(NSString *)path;
+ (BOOL)directoryExist:(NSString *)path;
+ (BOOL)moveFileAtPath:(NSString *)atPath toPath:(NSString *)toPath;
+ (BOOL)copyFileAtPath:(NSString *)atPath toPath:(NSString *)toPath;
+ (BOOL)removeFile:(NSString *)path;
+ (void)writeLogToFile:(NSString *)filePath appendTxt:(NSString *)txt;
+ (u_int64_t)fileSizeForPath:(NSString *)path;
+ (NSArray *)findFile:(NSString *)path;
/**
 拷贝文件夹（包含里面所有）到指定目录

 @param atPath 源目录
 @param toPath 目标目录
 @param error 错误信息
 */
+ (void)copyDirectory:(NSString *)atPath toPath:(NSString *)toPath error:(NSError **)error;

/** 遍历文件夹内的文件，将所有子目录的文件找出

 @param path 文件路径
 @return 放回文件路径数组
 */

+ (NSArray *)ergodicFolder:(NSString *)path;

/**
 *  根据文件大小返回文件大小字符串
 *
 *  @param aSize 文件大小，单位B
 *
 *  @return 文件大小字符串
 */
+ (NSString*)getFileSizeString:(float)aSize;


/**
 遍历文件夹内的文件，将所有子目录的文件以当前时间点@(day)天之前找出并排序

 @param path 文件路径
 @param beforeDay 时间（小于等于0时，搜索全部）
 @param samll samll 排序
 @return 数组
 */
+ (NSArray *)ergodicFolder:(NSString *)path beforeDay:(NSInteger)beforeDay fromBigToSmall:(BOOL)samll;

/**
 *  @author djr
 *  
 *  遍历文件夹内的文件，将所有子目录的文件day时间内找出并排序
 *  @param path 文件路径
 *  @param day 时间（小于等于0时，搜索全部）
 *  @param samll 排序
 *  @return 数组
 */
+ (NSArray *)ergodicFolder:(NSString *)path day:(NSInteger)day fromBigToSmall:(BOOL)samll;

/**
 *  @author djr
 *  
 *  遍历文件夹内的文件，将suffixs后缀的所有文件day时间内找出并排序
 *  @param path 文件路径
 *  @param day 时间（小于等于0时，搜索全部）
 *  @param samll 排序
 *  @param suffixs 后缀@[mp4, png]
 *  @return 数组
 */
+ (NSArray *)ergodicFolder:(NSString *)path day:(NSInteger)day suffixs:(NSArray<NSString *> *)suffixs fromBigToSmall:(BOOL)samll;

/** 系统磁盘大小 */
+ (long long) totalDiskSpace;

/** 已用系统磁盘大小 */
+ (long long) freeDiskSpace;

/** 获取当前APP的沙盒使用大小 */
+ (long long) appSandBoxSize;

/** 获取Cache路径 */
+ (NSString *)getCachePath;
/** 获取Cache/Snapshots路径 */
+ (NSString *)getCachePathSnapshotsPath;
@end
