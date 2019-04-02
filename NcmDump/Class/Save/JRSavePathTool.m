//
//  JRSavePathTool.m
//  NcmDump
//
//  Created by 丁嘉睿 on 2019/2/18.
//  Copyright © 2019 丁嘉睿. All rights reserved.
//

#import "JRSavePathTool.h"
#import "MMFileUtility.h"

NSString * _Nonnull const jr_dumpPathName = @"JRNcmDump";

NSString * _Nonnull canSaveNcmFilePathKey = @"canSaveNcmFilePath_Key";

NSString * _Nonnull canSaveExportPathKey = @"canSaveExportPath_Key";

NSString * _Nonnull ncmFilePathKey = @"ncmFilePath_Key";

NSString * _Nonnull exportPathKey = @"exportPath_Key";

NSString * _Nonnull cachetPathKey = @"cachetPath_Key";

NSString * _Nonnull autoUpdateKey = @"autoUpdate_Key";

@implementation JRSavePathTool

+ (instancetype)share
{
    static JRSavePathTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[JRSavePathTool alloc] init];
    });
    return tool;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _getProperty];
    } return self;
}

- (void)_getProperty
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    _saveExportPath = [[userDefaults objectForKey:canSaveExportPathKey] boolValue];
    _saveNcmFilePath = [[userDefaults objectForKey:canSaveNcmFilePathKey] boolValue];
    _ncmFilePath = [userDefaults objectForKey:ncmFilePathKey];
    _exportPath = [userDefaults objectForKey:exportPathKey];
    if([userDefaults objectForKey:autoUpdateKey] == nil) {
        self.autoUpdate = YES;
    } else {
        _autoUpdate = [[userDefaults objectForKey:autoUpdateKey] boolValue];
    }
    if (_exportPath.length == 0) {
        self.exportPath = [[NSSearchPathForDirectoriesInDomains(NSMusicDirectory, NSUserDomainMask, YES)objectAtIndex:0] stringByAppendingPathComponent:@"JRNcmDump"];
    }
    
    _cachePath = [userDefaults objectForKey:cachetPathKey];
    if (_cachePath.length == 0) {
        _cachePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0] stringByAppendingPathComponent:@"JRCache"];
        [self _toolSynchronize];
    }
    
    if (![MMFileUtility directoryExist:_cachePath]) {
        NSString *logStr = nil;
        [MMFileUtility createFolder:_cachePath errStr:&logStr];
        if (logStr.length > 0) {
            NSLog(@"exportPath error %@", logStr);
            _exportPath = nil;
        }
    }

    if (![MMFileUtility directoryExist:_exportPath]) {
        NSString *logStr = nil;
        [MMFileUtility createFolder:_exportPath errStr:&logStr];
        if (logStr.length > 0) {
            NSLog(@"exportPath error %@", logStr);
            _exportPath = nil;
        }
    }
}

- (void)setSaveExportPath:(BOOL)saveExportPath
{
    _saveExportPath = saveExportPath;
    [self _toolSynchronize];
}

- (void)setExportPath:(NSString *)exportPath
{
    _exportPath = exportPath;
    [self _toolSynchronize];
}

- (void)setSaveNcmFilePath:(BOOL)saveNcmFilePath
{
    _saveNcmFilePath = saveNcmFilePath;
    [self _toolSynchronize];
}

- (void)setNcmFilePath:(NSString *)ncmFilePath
{
    _ncmFilePath = ncmFilePath;
    [self _toolSynchronize];
}

- (void)setAutoUpdate:(BOOL)autoUpdate
{
    _autoUpdate = autoUpdate;
    [self _toolSynchronize];
}

- (void)_toolSynchronize
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    [userDefaults setObject:@(self.saveExportPath) forKey:canSaveExportPathKey];
    [userDefaults setObject:@(self.saveNcmFilePath) forKey:canSaveNcmFilePathKey];
    [userDefaults setObject:@(self.autoUpdate) forKey:autoUpdateKey];

    if (self.saveNcmFilePath) {
        if (self.ncmFilePath.length > 0) {
            [userDefaults setObject:self.ncmFilePath forKey:ncmFilePathKey];
        }
    } else {
        [userDefaults removeObjectForKey:ncmFilePathKey];
    }
    if (self.saveExportPath) {
        if (self.exportPath.length > 0) {
            [userDefaults setObject:self.exportPath forKey:exportPathKey];
        }
    } else {
        [userDefaults removeObjectForKey:exportPathKey];
    }
    [userDefaults synchronize];
}

@end
