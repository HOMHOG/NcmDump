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

NSString *const jr_pathExtension = @"ncm";


@interface MainViewController ()

@property (strong, nonatomic) NSMutableArray *files;

@property (weak) IBOutlet NSTextField *ncmPathLab;
@property (weak) IBOutlet NSButton *numFilePathBtn;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.numFilePathBtn.state = [JRSavePathTool share].saveNcmFilePath;
    
    // Do any additional setup after loading the view.
    _files = @[].mutableCopy;
    
    
    NSString *ncmFilePath = [JRSavePathTool share].ncmFilePath;
    if (ncmFilePath.length == 0) {
        ncmFilePath = @"请选择ncm文件路径(当多选文件夹的时候，只会保存第一个路径)";
    } else {
        [_files addObject:ncmFilePath];
    }
    _ncmPathLab.stringValue = ncmFilePath;
    
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
            self.ncmPathLab.stringValue = [self.files firstObject];
            [JRSavePathTool share].ncmFilePath = [self.files firstObject];
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
    /** 执行转换操作 */
    [JRNcmDumpTool dumpNcmFiles:[_files copy] exportPath:[JRSavePathTool share].exportPath];
}

- (IBAction)isSaveTheNcmFilePathAction:(id)sender {
    [JRSavePathTool share].saveNcmFilePath = self.numFilePathBtn.state;
}

@end
