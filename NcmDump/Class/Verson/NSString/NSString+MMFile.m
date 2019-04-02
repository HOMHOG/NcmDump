//
//  NSString+MMFile.m
//  MiracleMessenger
//
//  Created by LamTsanFeng on 15/4/21.
//  Copyright (c) 2015年 GZMiracle. All rights reserved.
//

#import "NSString+MMFile.h"

@implementation NSString (MMFile) 

void import_NSString_MMFile_Compression (void) { }


#pragma mark - 判断文件路径或文件名 YES为文件名
- (BOOL)mm_isFileOrFilePath
{
    NSRange range = [self rangeOfString:@"/"];
    /** 文件名 */
    if (range.location == NSNotFound)
    {
        return YES;
    } else { /** 文件路径 */
        return NO;
    }
}

#pragma mark - 判断文件是否存在后缀
- (BOOL)mm_isFileExtension
{
    NSString *extension = [self pathExtension];
    if (extension.length>0) {
        return YES;
    }
    return NO;
}

- (BOOL)mm_writeToFile:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if(![fileManager fileExistsAtPath:filePath]) //如果不存在
    {
        return [self writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
    } else {
        
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
        
        [fileHandle seekToEndOfFile];  //将节点跳到文件的末尾
        
        NSData* stringData  = [self dataUsingEncoding:NSUTF8StringEncoding];
        
        [fileHandle writeData:stringData]; //追加写入数据
        
        [fileHandle closeFile];
        
        return YES;
    }
    return NO;
}

@end
