//
//  NSString+MMJSON.h
//  MiracleMessenger
//
//  Created by LamTsanFeng on 15/2/15.
//  Copyright (c) 2015年 Anson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MMJSON) 

void import_NSString_MMJSON_Compression (void);


/** 截取json部分 */
- (NSString *)mm_subJSONStringWithString;

/** 移除json部分 */
- (NSString *)mm_stringByRemovingJSONString;

@end
