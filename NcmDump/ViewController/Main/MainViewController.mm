//
//  MainViewController.m
//  NcmDump
//
//  Created by 丁嘉睿 on 2019/1/3.
//  Copyright © 2019 丁嘉睿. All rights reserved.
//

#import "MainViewController.h"
#import "MMFileUtility.h"
#import "JRNcmDumpTool.h"
#import "JRSavePathTool.h"
#import "ClientInformation.h"
#import "JRBaseHttp.h"
#import "JRProgressIndicatorViewController.h"

NSString *const jr_pathExtension = @"ncm";


@interface MainViewController ()

@property (strong, nonatomic) NSMutableArray *files;
/** 是否保存输入路径 */
@property (weak) IBOutlet NSButton *numFilePathBtn;
/** 选择ncm文件路径按钮 */
@property (weak) IBOutlet NSButton *selectNcmFileBtn;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.

    self.numFilePathBtn.state = [JRSavePathTool share].saveNcmFilePath;
    
    _files = @[].mutableCopy;
    
    NSString *ncmFilePath = [JRSavePathTool share].ncmFilePath;
    if (ncmFilePath.length == 0) {
        ncmFilePath = @"请选择ncm文件路径(当多选文件夹的时候，只会保存第一个路径)";
    } else {
        [_files addObject:ncmFilePath];
    }
    [self.selectNcmFileBtn setTitle:ncmFilePath];
    
    if ([JRSavePathTool share].autoUpdate) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readyToReadPlist) name:ClientInformationNotificationCenterForDownloadUpdateFileKey object:nil];
    }
    
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)readyToReadPlist
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"取消"];
        [alert addButtonWithTitle:@"更新"];
        alert.messageText = @"有新版本更新，安装包会放在转换目录（懒了不做下载界面了）";
        [alert setAlertStyle:NSAlertStyleWarning];
        [alert beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse returnCode) {
            if (returnCode == 1001) {
                [[JRBaseHttp shareHttp] httpDownLoadURL:[ClientInformation updateVersionUrlStrong] filePath:[[JRSavePathTool share] exportPath] complete:^(NSError * _Nullable error, NSURL * _Nullable filePath) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self _showUpdateError:error filePtah:filePath.path];
                    });
                }];
            }
        }];
    });
}

- (void)_showUpdateError:(NSError *)error filePtah:(NSString *)filePath
{
    NSAlert *alert = [[NSAlert alloc] init];
    NSString *str = @"下载成功";
    if (error) {
        str = @"下载失败";
    } else {
        alert.informativeText = [NSString stringWithFormat:@"安装包路径:%@", filePath];
    }
    alert.messageText = str;
    [alert setAlertStyle:NSAlertStyleWarning];
    [alert beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse returnCode) {
    }];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)selectMusicPathButtonAction:(id)sender {
    [_files removeAllObjects];
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    [openPanel setAllowsMultipleSelection:NO];
    [openPanel setCanChooseDirectories:YES];
    [openPanel setAllowedFileTypes:@[@"ncm"]];
    [openPanel setCanChooseFiles:YES];
    [openPanel setAllowsOtherFileTypes:NO];
    __weak typeof(self) weakSelf = self;
    [openPanel beginWithCompletionHandler:^(NSModalResponse result) {
        if (result == NSModalResponseOK) {
            for (NSURL *url in openPanel.URLs) {
                NSString *path = [url path];
                if ([MMFileUtility directoryExist:path]) {
                    NSArray *array = [MMFileUtility ergodicFolder:path day:0 suffixs:@[jr_pathExtension] fromBigToSmall:NO];
                    if (array) {
                        [weakSelf.files addObjectsFromArray:array];
                    }
                } else {
                    NSString *extension = [path pathExtension];
                    if ([extension isEqualToString:jr_pathExtension]) {
                        [weakSelf.files addObject:path];
                    }
                }
            }
            if (self.files.count > 0) {
                [self.selectNcmFileBtn setTitle:[self.files firstObject]];
                [JRSavePathTool share].ncmFilePath = [self.files firstObject];
            } else {
                [self.selectNcmFileBtn setTitle:@"检索不到后缀为ncm文件，请重新选择"];
            }
        }
    }];
}

- (IBAction)startNcmDumpButtonAction:(id)sender {
    
    BOOL isError = NO;
    NSString *errorStr = @"请选择需要转换文件的路径";
    if (self.files.count == 0) {
        isError = YES;
    }
    
    if (![MMFileUtility directoryExist:[JRSavePathTool share].exportPath]) {
        isError = YES;
        errorStr = @"输出路径有问题，请去设置重新选择";
    }
    
    if (isError) {
        NSAlert *alert = [[NSAlert alloc] init];
        alert.informativeText = [NSString stringWithFormat:@"error : %@", errorStr];
        alert.messageText = @"注意:ncm可以是文件或者文件夹, exprot只能是文件夹";
        [alert setAlertStyle:NSAlertStyleWarning];
        [alert beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse returnCode) {
        }];
        return;
    }
    
    NSArray *reslut = [_files copy];
    NSStoryboard * storyBoard = nil;
    if (@available(macOS 10.13, *)) {
        storyBoard = [NSStoryboard mainStoryboard];
    } else {
        // Fallback on earlier versions
        storyBoard = [NSStoryboard storyboardWithName:@"Main" bundle:nil]; //获取故事板的引用
    }
    __block JRProgressIndicatorViewController *vc = [storyBoard instantiateControllerWithIdentifier:@"ProgressViewController"];
    vc.minValue = 0;
    vc.maxValue = reslut.count;
    [self presentViewControllerAsSheet:vc];
    
    /** 执行转换操作 */
    [JRNcmDumpTool dumpNcmFiles:reslut exportPath:[JRSavePathTool share].exportPath dumpProgressBlock:^(CGFloat progress) {
        [vc setProgress:progress];
    } failureBlock:^(NSError * _Nonnull error) {
        
    }];
}

- (IBAction)isSaveTheNcmFilePathAction:(id)sender {
    [JRSavePathTool share].saveNcmFilePath = self.numFilePathBtn.state;
}

@end
