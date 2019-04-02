//
//  NSString+MMPinYin.m
//  MMBusinessLogicLayer
//
//  Created by 陈琪 on 15/7/8.
//  Copyright (c) 2015年 GZMiracle. All rights reserved.
//

#import "NSString+MMPinYin.h"
#import "MMPinYinUtility.h"

@implementation NSString (MMPinYin) 

void import_NSString_MMPinYin_Compression (void) { }


#pragma mark - 汉字转拼音
- (NSString *)mm_transformToPinyin {
    return [MMPinYinUtility getPinYinOfWord:self];
}


/** 获取中文字符串单个汉字首字符串*/
- (NSString *)mm_getShortPinYinOfChineseString
{
    return [MMPinYinUtility getFirstPinYinOfWord:self];
}

@end
