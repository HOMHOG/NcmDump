//
//  NSString+MMURLEncoded.h
//  MMUtilityLayer
//
//  Created by LamTsanFeng on 2017/5/19.
//  Copyright © 2017年 GZMiracle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MMURLEncoded) 

void import_NSString_MMURLEncoded_Compression (void);


-(NSString *)MRL_URLEncodedString;
-(NSString *)MRL_URLDecodedString;
@end
