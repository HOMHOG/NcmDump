//
//  NSString+MMFile.h
//  MiracleMessenger
//
//  Created by LamTsanFeng on 15/4/21.
//  Copyright (c) 2015年 GZMiracle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MMFile) 

void import_NSString_MMFile_Compression (void);

/** 判断文件路径或文件名 YES为文件名 */
- (BOOL)mm_isFileOrFilePath;
/** 判断文件是否存在后缀 */
- (BOOL)mm_isFileExtension;

/**
 *  @author lincf, 16-06-02 15:06:13
 *
 *  写入文件［带追加操作］
 *
 *  @param filePath 文件路径
 *
 *  @return 是否写入成功
 */
- (BOOL)mm_writeToFile:(NSString *)filePath;
@end
