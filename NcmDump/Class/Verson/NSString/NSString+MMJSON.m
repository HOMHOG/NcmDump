//
//  NSString+MMJSON.m
//  MiracleMessenger
//
//  Created by LamTsanFeng on 15/2/15.
//  Copyright (c) 2015年 Anson. All rights reserved.
//

#import "NSString+MMJSON.h"

@implementation NSString (MMJSON) 

void import_NSString_MMJSON_Compression (void) { }


#pragma mark - 截取json部分
- (NSString *)mm_subJSONStringWithString
{
    NSRange rangLeft = [self rangeOfString:@"{"];
    NSRange rangRight = [self rangeOfString:@"}"];
    NSString *json = nil;
    if (rangLeft.location != NSNotFound && rangRight.location != NSNotFound) {
        json = [self substringWithRange:NSMakeRange(rangLeft.location, rangRight.location-rangLeft.location+1)];
    }
    return json;
}

#pragma mark - 移除json部分
- (NSString *)mm_stringByRemovingJSONString
{
    NSString *json = [self mm_subJSONStringWithString];
    if (json) {
        return [self stringByReplacingOccurrencesOfString:json withString:@""];
    }
    return self;
}
@end
