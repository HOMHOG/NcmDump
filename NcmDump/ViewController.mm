//
//  ViewController.m
//  NcmDump
//
//  Created by 丁嘉睿 on 2019/1/3.
//  Copyright © 2019 丁嘉睿. All rights reserved.
//

#import "ViewController.h"
#import "MMFileUtility.h"
#import "JRNcmDumpTool.h"
#import "JRSavePathTool.h"

NSString *const jr_pathExtension = @"ncm";


@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *files;

@property (copy, nonatomic) NSString *exportPath;
@property (weak) IBOutlet NSTextField *ncmPathLab;
@property (weak) IBOutlet NSTextField *exportPathLab;
@property (weak) IBOutlet NSButton *numFilePathBtn;
@property (weak) IBOutlet NSButton *exportPathBtn;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.numFilePathBtn.state = [JRSavePathTool share].saveNcmFilePath;
    self.exportPathBtn.state = [JRSavePathTool share].saveExportPath;
    
    // Do any additional setup after loading the view.
    _files = @[].mutableCopy;
    
    
    NSString *ncmFilePath = [JRSavePathTool share].ncmFilePath;
    if (ncmFilePath.length == 0) {
        ncmFilePath = @"请选择ncm文件路径(当多选文件夹的时候，只会保存第一个路径)";
    } else {
        [_files addObject:ncmFilePath];
    }
    _ncmPathLab.stringValue = ncmFilePath;
    
    _exportPath = [JRSavePathTool share].exportPath;
    if (_exportPath.length == 0) {
        _exportPathLab.stringValue = @"请选择转换文件路径";
        } else {
        _exportPathLab.stringValue = _exportPath;
    }
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
- (IBAction)exportFilesButtonAction:(id)sender {
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    [openPanel setAllowsMultipleSelection:NO];
    [openPanel setCanChooseDirectories:YES];
    [openPanel setCanChooseFiles:NO];
    [openPanel setAllowsOtherFileTypes:NO];
    __weak typeof(self) weakSelf = self;
    [openPanel beginWithCompletionHandler:^(NSModalResponse result) {
        if (result == NSModalResponseOK) {
            NSString *path = [[openPanel.URLs firstObject] path];
            if (![[path lastPathComponent] isEqualToString:jr_dumpPathName]) {
                path = [path stringByAppendingPathComponent:jr_dumpPathName];
            }
            if (![MMFileUtility directoryExist:path]) {
                [MMFileUtility createFolder:path errStr:nil];
            }
            weakSelf.exportPath = path;
            weakSelf.exportPathLab.stringValue = path;
            [JRSavePathTool share].exportPath = path;
        }
    }];

}

- (IBAction)startNcmDumpButtonAction:(id)sender {
    BOOL isError = NO;
    NSString *errorStr = @"ncm";
    if (self.files.count == 0) {
        isError = YES;
    }
    if (self.exportPath.length == 0) {
        if (isError) {
            errorStr = [errorStr stringByAppendingString:@"和exprot"];
        } else {
            errorStr = @"export";
        }
        isError = YES;
    }
    
    if (isError) {
        NSAlert *alert = [[NSAlert alloc] init];
        alert.messageText = [NSString stringWithFormat:@"请选择%@文件路径", errorStr];
        alert.informativeText = @"ncm可以是文件或者文件夹, exprot只能是文件夹";
        [alert setAlertStyle:NSAlertStyleWarning];
        [alert beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse returnCode) {
        }];
        return;
    }
    
    /** 执行转换操作 */
    [JRNcmDumpTool dumpNcmFiles:[_files copy] exportPath:_exportPath];
}

- (IBAction)isSaveTheNcmFilePathAction:(id)sender {
    [JRSavePathTool share].saveNcmFilePath = self.numFilePathBtn.state;
}

- (IBAction)isSaveExportPathAction:(id)sender {
    [JRSavePathTool share].saveExportPath = self.exportPathBtn.state;
}
@end
