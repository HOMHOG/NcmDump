//
//  NSString+MMURLEncoded.m
//  MMUtilityLayer
//
//  Created by LamTsanFeng on 2017/5/19.
//  Copyright © 2017年 GZMiracle. All rights reserved.
//

#import "NSString+MMURLEncoded.h"
#import "MMHttpUtility.h"

@implementation NSString (MMURLEncoded) 

void import_NSString_MMURLEncoded_Compression (void) { }


-(NSString *)MRL_URLEncodedString
{
    return [MMHttpUtility httpURLEncode:self];
}

-(NSString *)MRL_URLDecodedString
{
    return [MMHttpUtility httpURLDecoded:self];
}

@end
