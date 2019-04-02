//
//  NSString+MMPinYin.h
//  MMBusinessLogicLayer
//
//  Created by 陈琪 on 15/7/8.
//  Copyright (c) 2015年 GZMiracle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MMPinYin) 

void import_NSString_MMPinYin_Compression (void);

- (NSString *)mm_transformToPinyin;

/** 获取中文字符串单个汉字首字符串*/
- (NSString *)mm_getShortPinYinOfChineseString;

@end
