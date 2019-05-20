//
//  JRNcmDumpTool.m
//  NcmDump
//
//  Created by 丁嘉睿 on 2019/1/3.
//  Copyright © 2019 丁嘉睿. All rights reserved.
//

#import "JRNcmDumpTool.h"

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <assert.h>

#include <openssl/bio.h>
#include <openssl/evp.h>

#include "cJSON.h"

#include "mpegfile.h"
#include "flacfile.h"
#include "attachedpictureframe.h"
#include "id3v2tag.h"
#include "tag.h"

#include "ncmcrypt.h"

@implementation JRNcmDumpTool

+ (void)dumpNcmFiles:(NSArray *)ncmFiles exportPath:(NSString *)exportPath
{
    [JRNcmDumpTool dumpNcmFiles:ncmFiles exportPath:exportPath dumpProgressBlock:nil failureBlock:nil];
}

+ (void)dumpNcmFiles:(NSArray *)ncmFiles exportPath:(NSString *)exportPath dumpProgressBlock:(void(^)(CGFloat progress))dumpProgressBlock failureBlock:(void(^)(NSError *error))failureBlock
{
    exportPath = [exportPath stringByAppendingString:@"/"];
    for (NSUInteger i = 0; i < ncmFiles.count; i ++) {
        NSString *path = ncmFiles[i];
        NeteaseCrypt crypt([path cStringUsingEncoding:NSUTF8StringEncoding], [exportPath cStringUsingEncoding:NSUTF8StringEncoding]);
        crypt.Dump();
        crypt.FixMetadata();
        if (dumpProgressBlock) {
            dumpProgressBlock(i+1);
        }

    }
}


+ (instancetype)shareNumpTool
{
    static JRNcmDumpTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[JRNcmDumpTool alloc] init];
    });
    return tool;
}

@end
