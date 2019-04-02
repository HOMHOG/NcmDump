//
//  JRBaseHttp.m
//  NcmDump
//
//  Created by 丁嘉睿 on 2019/4/1.
//  Copyright © 2019 丁嘉睿. All rights reserved.
//

#import "JRBaseHttp.h"

@interface JRBaseHttp () <NSURLSessionDelegate>

@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;

@end

@implementation JRBaseHttp

+ (instancetype)shareHttp
{
    static JRBaseHttp *http = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        http = [JRBaseHttp new];
    });
    return http;
}

- (void)httpDownLoadURL:(NSString *)downloadURLString filePath:(NSString *)filePath complete:(void (^)(NSError * _Nullable, NSURL * _Nullable))completeBlock
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSURL *downloadURL = [NSURL URLWithString:downloadURLString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    self.downloadTask = [session downloadTaskWithRequest:[NSURLRequest requestWithURL:downloadURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *a = filePath;
        if (!error) {
            NSString *filename = response.suggestedFilename;
            if (filename.length > 0) {
                NSString *extension = [filePath pathExtension];
                if (extension.length > 0) {
                    if (![extension isEqualToString:[filename pathExtension]]) {
                        NSString *a = [filePath stringByDeletingLastPathComponent];
                        a = [a stringByAppendingPathComponent:filename];
                    }
                } else {
                    a = [a stringByAppendingPathComponent:filename];
                }
            }
            [fm moveItemAtURL:location toURL:[NSURL fileURLWithPath:a] error:nil];
        }
        if (completeBlock) {
            completeBlock(error, [NSURL fileURLWithPath:a]);
        }
    }];

    [self.downloadTask resume];
}

@end
