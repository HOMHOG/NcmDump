//
//  NSString+MD5Addition.h
//  MiraclePushClient
//
//  Created by li xj on 13-4-8.
//  
//

#import <Foundation/Foundation.h>

@interface NSString (MMAddition)

void import_NSString_MMAddition_Compression (void);

- (NSString *)mm_sha1;
- (NSString *)mm_stringFromMD5;

- (NSString *)mm_base64Encode;
- (NSString *)mm_webSafeBase64Encode;//由于标准base64会有 =
- (NSString*)mm_telephoneWithReformat;

@end
