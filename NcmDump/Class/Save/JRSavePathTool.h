//
//  JRSavePathTool.h
//  NcmDump
//
//  Created by 丁嘉睿 on 2019/2/18.
//  Copyright © 2019 丁嘉睿. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

extern NSString * _Nonnull const  jr_dumpPathName;

@interface JRSavePathTool : NSObject

@property (assign, nonatomic) BOOL saveExportPath;

@property (assign, nonatomic) BOOL saveNcmFilePath;

@property (copy, nonatomic) NSString *exportPath;

@property (copy, nonatomic) NSString *ncmFilePath;

@property (readonly, nonatomic) NSString *cachePath;

@property (assign, nonatomic) BOOL autoUpdate;

+ (instancetype)share;

@end

NS_ASSUME_NONNULL_END
