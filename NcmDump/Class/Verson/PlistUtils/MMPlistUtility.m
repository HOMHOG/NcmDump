//
//  PlistUtility.m
//  MiracleMessenger
//
//  Created by LamTsanFeng on 15/4/21.
//  Copyright (c) 2015年 GZMiracle. All rights reserved.
//

#import "MMPlistUtility.h"
#import "NSString+MMFile.h"

@implementation MMPlistUtility

+ (id)readDicPlistFile:(NSString *)fileName isMutable:(BOOL)isMutable
{
    if (isMutable) {
        return [self readBasePlistFile:fileName aClass:NSMutableDictionary.class];
    } else {
        return [self readBasePlistFile:fileName aClass:NSDictionary.class];
    }
}

+ (id)readArrayPlistFile:(NSString *)fileName isMutable:(BOOL)isMutable
{
    if (isMutable) {
        return [self readBasePlistFile:fileName aClass:NSMutableArray.class];
    } else {
        return [self readBasePlistFile:fileName aClass:NSArray.class];
    }
}

+ (id)readBasePlistFile:(NSString *)fileName aClass:(Class)aClass
{
    id object = nil;
    NSString *plistPath = nil;
    /** 文件名 */
    if ([fileName mm_isFileOrFilePath])
    {
        //读本地bundle
        if ([fileName mm_isFileExtension]) {
            plistPath = [[NSBundle bundleForClass:self.class] pathForResource:fileName ofType:nil];
        } else {
            plistPath = [[NSBundle bundleForClass:self.class] pathForResource:fileName ofType:@"plist"];
        }
    } else { /** 文件路径 */
        plistPath = fileName;
    }
    if ([aClass isSubclassOfClass:NSDictionary.class]) {
        object = [aClass dictionaryWithContentsOfFile:plistPath];
    } else if ([aClass isSubclassOfClass:NSArray.class]) {
        object = [aClass arrayWithContentsOfFile:plistPath];
    }
    return object;
}

+ (BOOL)writePlistFile:(id)plist fileName:(NSString *)fileName
{
    BOOL result = NO;
    if ([plist isKindOfClass:NSArray.class] || [plist isKindOfClass:NSDictionary.class]) {
        /** 文件名 */
        if ([fileName mm_isFileOrFilePath])
        {
            NSString *plistPath = nil;
            /** 沙盒路径 */
            NSString *Document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
            //读本地bundle
            if ([fileName mm_isFileExtension]) {
                plistPath = [Document stringByAppendingPathComponent:fileName];
            } else {
                plistPath = [Document stringByAppendingPathComponent:[fileName stringByAppendingString:@".plist"]];
            }
            result = [plist writeToFile:plistPath atomically:YES];
        } else { /** 文件路径 */
            result = [plist writeToFile:fileName atomically:YES];
        }
    }
    return result;
}

@end
