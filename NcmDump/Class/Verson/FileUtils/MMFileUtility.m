//
//  FileUtility.m
//  SocketClientDemo
//
//  Created by AnsonLo on 13-7-26.
//  Copyright (c) 2013年 ansonkid. All rights reserved.
//

#import "MMFileUtility.h"
#import "NSDate+MMCommon.h"

@implementation MMFileUtility


+ (BOOL)createFolder:(NSString *)path errStr:(NSString **)errStr
{
    if (path.length == 0) return FALSE;
    NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error = nil;
	if (![fileManager fileExistsAtPath:path]) {
        
		if (![fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error]) {
            if (errStr) (*errStr) = [error localizedDescription];
			NSLog(@"createFolder error: %@ \n",[error localizedDescription]);
			return FALSE;
		}
	}
    return TRUE;
}

+ (BOOL)createFile:(NSString *)path {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
    
       return [fileManager createFileAtPath:path contents:nil attributes:nil];
    }
    return TRUE;
}

+ (BOOL)fileExist:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return ([fileManager fileExistsAtPath:path]);
}

+ (BOOL)directoryExist:(NSString *)path {
    BOOL isDirectory = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL exist = ([fileManager fileExistsAtPath:path isDirectory:&isDirectory]);
    return (exist && isDirectory);
}

+ (BOOL)moveFileAtPath:(NSString *)atPath toPath:(NSString *)toPath{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (atPath.length > 0 && toPath.length > 0) {/** 如果文件路径为空就不操作 */
        NSError *error = nil;
        BOOL isOK = [fileManager moveItemAtPath:atPath toPath:toPath error:&error];
        if (error) {
            NSLog(@"moveFileAtPath error:%@", error.localizedDescription);
        }
        return isOK;
    } else {
        return NO;
    }
}

+ (BOOL)copyFileAtPath:(NSString *)atPath toPath:(NSString *)toPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (atPath.length > 0 && toPath.length > 0) {/** 如果文件路径为空就不复制 */
        NSString *errorStr;
        [MMFileUtility createFolder:[toPath stringByDeletingLastPathComponent] errStr:&errorStr];
        if(errorStr.length > 0) NSLog(@"createFolderIsError:%@", errorStr);
        NSError *error;
        BOOL success = [fileManager copyItemAtPath:atPath toPath:toPath error:&error];
        if (error) NSLog(@"copyItemAtPathIsError:%@", error.localizedFailureReason);
        return success;
    }else{
        return NO;
    }
}

+ (BOOL)removeFile:(NSString *)path {

    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        return ([fileManager removeItemAtPath:path error:nil]);
    } else {
        return NO;
    }
}

+ (void)writeLogToFile:(NSString *)filePath appendTxt:(NSString *)txt {
    
    @synchronized(self) {
        NSDate *today = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *content = [NSString stringWithFormat:@"%@     _%@\n", [formatter stringFromDate:today], txt];
        NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
        
        NSFileManager *filemgr = [NSFileManager defaultManager];
        if ([filemgr fileExistsAtPath: filePath ] == FALSE)
        {
            NSLog (@"File not found");
            [filemgr createFileAtPath:filePath contents:contentData attributes:nil];
            
        }else {
            
            NSFileHandle *myHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
            if (myHandle == nil) {
                NSLog(@"Failed to open file");
                return;
            }
            [myHandle seekToEndOfFile];
            [myHandle writeData:contentData];
            [myHandle closeFile];
        }
    }
}

+ (u_int64_t)fileSizeForPath:(NSString *)path
{
    signed long long fileSize = 0;
    NSFileManager *fileManager = [NSFileManager new]; // default is not thread safe
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}

+ (NSArray *)findFile:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    return array;
}


+ (void)copyDirectory:(NSString *)atPath toPath:(NSString *)toPath error:(NSError *__autoreleasing *)error
{
    if (atPath.length == 0 || toPath.length == 0) {
        *error = [NSError errorWithDomain:@"file path is null" code:-808 userInfo:@{NSLocalizedDescriptionKey:@"文件目录为空"}];
        return;
    }
    BOOL isDir = YES;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager fileExistsAtPath:atPath isDirectory:&isDir];
    if (!isDir) {
        *error = [NSError errorWithDomain:@"file path is not Directory" code:-809 userInfo:@{NSLocalizedDescriptionKey:@"不是文件夹"}];
        return;
    }
    NSString *atPathTop = [atPath stringByDeletingLastPathComponent];
    NSArray *files = [MMFileUtility ergodicFolder:atPath];
    if (files.count == 0) {
        [MMFileUtility createFolder:[toPath stringByAppendingPathComponent:[atPath lastPathComponent]] errStr:nil];
    } else {
        for (NSString *filePath in files) {
            NSString *aFilePath = [filePath stringByReplacingOccurrencesOfString:atPathTop withString:@""];
            NSString *newFilePath = [NSString stringWithFormat:@"%@/%@", toPath, aFilePath];
            [MMFileUtility copyFileAtPath:filePath toPath:newFilePath];
        }
    }
}


+ (NSArray *)ergodicFolder:(NSString *)path{
    NSMutableArray *dirArray = [NSMutableArray array];
    [MMFileUtility ergodicFolder:path list:&dirArray];
    return [dirArray copy];
}


#pragma mark - 遍历文件夹内的文件，将所有子目录的文件找出
+ (void)ergodicFolder:(NSString *)documentDir list:(NSMutableArray **)dirArray
{
    [self ergodicFolder:documentDir list:dirArray TimeSequence:0];
}
+ (void)ergodicFolder:(NSString *)documentDir list:(NSMutableArray **)dirArray TimeSequence:(NSInteger)day
{
    [self ergodicFolder:documentDir list:dirArray suffixs:nil TimeSequence:day];
}
+ (void)ergodicFolder:(NSString *)documentDir list:(NSMutableArray **)dirArray suffixs:(NSArray<NSString *> *)suffixs TimeSequence:(NSInteger)day{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error = nil;
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    NSArray *fileList = [fm contentsOfDirectoryAtPath:documentDir error:&error];
    if (error == nil) {
        //在上面那段程序中获得的fileList中列出文件夹名
        for (NSString *file in fileList) {
            NSString *path = [documentDir stringByAppendingPathComponent:file];
            
            BOOL isDir,isPath;
            //检查路径是否正确
            isPath = [fm fileExistsAtPath:path isDirectory:&isDir];
            if (isPath) {
                //判断路径是文件夹还是文件
                if (isDir) {
                    //文件夹
                    [self ergodicFolder:path list:dirArray suffixs:suffixs TimeSequence:day];
                } else {
                    if (suffixs.count) {
                        /** 与需求后缀不一致 */
                        if (![suffixs containsObject:[path pathExtension]]) {
                            continue;
                        }
                    }
                    if (day == 0) {
                        [*dirArray addObject:path];
                    }else{
                        /** 小于等于15天文件 */
                        NSDictionary *fileDic = [fm attributesOfItemAtPath:path error:nil];
                        NSDate *fileDate = [fileDic fileModificationDate];
                        NSInteger fileTime = [[NSDate date] mm_daysDifferentFromOtherDate:fileDate];
                        if (day >= fileTime) {
                            [*dirArray addObject:path];
                        }
                    }
                }
            } else {
                NSLog(@"%@不存在",path);
            }
        }
    } else {
        NSLog(@"%@", [error localizedDescription]);
    }

}


/**
 *  根据文件大小返回文件大小字符串
 *
 *  @param aSize 文件大小，单位B
 *
 *  @return 文件大小字符串
 */
+ (NSString *)getFileSizeString:(float)aSize{
    NSArray *unitText = @[@"B",@"K",@"M",@"G",@"T"];
    NSInteger index = 0;
    while (aSize > 999) {
        index++;
        aSize /= 1024;
    }
    NSNumberFormatter *nFormat = [[NSNumberFormatter alloc] init];
    [nFormat setNumberStyle:NSNumberFormatterDecimalStyle];
    [nFormat setMaximumFractionDigits:1];
    return [NSString stringWithFormat:@"%@%@",[nFormat stringFromNumber:[NSNumber numberWithFloat:aSize]],[unitText objectAtIndex:index]];
}

/**  遍历文件夹内的文件，将所有子目录的文件以当前时间点@(day)天之前找出并排序 */
+ (NSArray *)ergodicFolder:(NSString *)path beforeDay:(NSInteger)beforeDay fromBigToSmall:(BOOL)samll {
    if (beforeDay < 0) {
        beforeDay = 0;
    }
    NSMutableArray *allSubFiles = [NSMutableArray arrayWithArray:[MMFileUtility ergodicFolder:path day:beforeDay fromBigToSmall:samll]];
    if (beforeDay != 0) {
        NSArray *dayFiles = [MMFileUtility ergodicFolder:path day:beforeDay fromBigToSmall:samll];
        [allSubFiles removeObjectsInArray:dayFiles];
    }
    return [allSubFiles copy];
}

//遍历文件夹内的文件，将所有子目录的文件day时间内找出并排序
+ (NSArray *)ergodicFolder:(NSString *)path day:(NSInteger)day fromBigToSmall:(BOOL)samll
{
    return [self ergodicFolder:path day:day suffixs:nil fromBigToSmall:samll];
}

//遍历文件夹内的文件，将fileSuffixs后缀的所有文件day时间内找出并排序
+ (NSArray *)ergodicFolder:(NSString *)path day:(NSInteger)day suffixs:(NSArray<NSString *> *)suffixs fromBigToSmall:(BOOL)samll
{
    if (day < 0) {
        day = 0;
    }
    NSMutableArray *dirArray = [NSMutableArray array];
    [MMFileUtility ergodicFolder:path list:&dirArray suffixs:suffixs TimeSequence:day];
    NSArray *array = [MMFileUtility sortFiles:dirArray fromBigToSmall:YES];
    return array;
}
#pragma mark - 排序
+ (NSArray *)sortFiles:(NSArray *)files fromBigToSmall:(BOOL)samll{
    NSFileManager *fm = [NSFileManager defaultManager];
    if (files.count <= 0) return  nil;
    BOOL isYes = YES;
    for (NSString *path in files) {
        BOOL isDir,isPath;
        //检查路径是否正确
        isPath = [fm fileExistsAtPath:path isDirectory:&isDir];
        if (isPath && !isDir) {
            isYes = isPath;
            break;
        }
    }
    if (!isYes) return nil;
    return [files sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSDictionary *dict1 = [fm attributesOfItemAtPath:obj1 error:nil];
        NSDictionary *dict2 = [fm attributesOfItemAtPath:obj2 error:nil];
        NSDate *date1 = [dict1 fileCreationDate];
        NSDate *date2 = [dict2 fileCreationDate];
        if (samll) {/** 从大到小 */
            return [date2 compare:date1];
        }else{/** 从小到大 */
            return [date1 compare:date2];
        }
    }];
}

+ (long long) totalDiskSpace
{
    /// 是否登录  
    NSError *error = nil;  
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];  
    if (fattributes)  
    {          
        return [[fattributes objectForKey:NSFileSystemSize] longLongValue];
    } else  
    {  
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);  
    }  
    return 0;
}

+ (long long) freeDiskSpace
{
    /// 是否登录  
    NSError *error = nil;  
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];  
    if (fattributes)  
    {  
        return [[fattributes objectForKey:NSFileSystemFreeSize] longLongValue];
        
    } else  
    {  
        NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", [error domain], (long)[error code]);  
    }  
    return 0;
}


/** 获取当前APP的沙盒使用大小 */
+ (long long) appSandBoxSize{
    /** 获取APP存储使用情况 */
    long long sandBoxSize = 0;
    NSURL *fileUrl = nil;
    NSURL *sandboxUrl = [NSURL URLWithString:NSHomeDirectory()];
    if (sandboxUrl) {
        /** 计算存储空间 */
        NSDirectoryEnumerator *dirEnumerator = [[NSFileManager defaultManager] enumeratorAtURL:sandboxUrl includingPropertiesForKeys:@[NSURLFileSizeKey] options:0 errorHandler:nil];
        while (fileUrl = [dirEnumerator nextObject]) {
            NSNumber *fileSize = nil;
            BOOL success = [fileUrl getResourceValue:&fileSize forKey:NSURLFileSizeKey error:nil];
            if (success) {
                sandBoxSize += [fileSize unsignedLongLongValue];
            }
        }
    }
    return sandBoxSize;
}


/** 获取Cache路径 */
+ (NSString *)getCachePath{
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    return cachesPath;
}

+ (NSString *)getCachePathSnapshotsPath{
    return [[MMFileUtility getCachePath] stringByAppendingPathComponent:@"Snapshots"];
}
@end
