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

NSString *const jr_pathExtension = @"ncm";

NSString *const jr_dumpPathName = @"NcmDump";

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *files;

@property (copy, nonatomic) NSString *exportPath;
@property (weak) IBOutlet NSTextField *ncmPathLab;
@property (weak) IBOutlet NSTextField *exportPathLab;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    _files = @[].mutableCopy;
    
    NSString *desktopPath = [NSSearchPathForDirectoriesInDomains(NSMusicDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    _exportPath = [desktopPath stringByAppendingPathComponent:jr_dumpPathName];
    if (![MMFileUtility directoryExist:_exportPath]) {
        [MMFileUtility createFolder:_exportPath errStr:nil];
    }
    _exportPathLab.stringValue = _exportPath;
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)selectMusicPathButtonAction:(id)sender {
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
//            NSLog(@"%@", weakSelf.files);
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
            weakSelf.exportPathLab.stringValue = weakSelf.exportPath;
        }
    }];

}

- (IBAction)startNcmDumpButtonAction:(id)sender {
    if (_files.count == 0) {
        NSAlert *alert = [[NSAlert alloc] init];
        
        alert.messageText = @"请选择ncm文件路径";
        alert.informativeText = @"可以是文件或者文件夹";
        [alert setAlertStyle:NSAlertStyleWarning];
        [alert beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse returnCode) {
            
        }];
        return;
    }
    [JRNcmDumpTool dumpNcmFiles:[_files copy] exportPath:_exportPath];
}
@end
