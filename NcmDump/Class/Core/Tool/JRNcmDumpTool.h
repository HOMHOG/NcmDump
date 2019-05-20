//
//  JRNcmDumpTool.h
//  NcmDump
//
//  Created by 丁嘉睿 on 2019/1/3.
//  Copyright © 2019 丁嘉睿. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JRNcmDumpTool : NSObject

+ (instancetype)shareNumpTool;

@property (nonatomic, readonly) NSString *exportPath;

+ (void)dumpNcmFiles:(nullable NSArray *)ncmFiles exportPath:(nullable NSString *)exportPath;

+ (void)dumpNcmFiles:(nullable NSArray *)ncmFiles exportPath:(nullable NSString *)exportPath dumpProgressBlock:(nullable void(^)(CGFloat progress))dumpProgressBlock failureBlock:(nullable void(^)(NSError *error))failureBlock;

@end

NS_ASSUME_NONNULL_END
