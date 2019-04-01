//
//  JRSettingViewController.m
//  NcmDump
//
//  Created by 丁嘉睿 on 2019/4/1.
//  Copyright © 2019 丁嘉睿. All rights reserved.
//

#import "JRSettingViewController.h"
#import "JRSavePathTool.h"

@interface JRSettingViewController ()

@property (weak) IBOutlet NSButton *exportPathBtn;

@end

@implementation JRSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    [_exportPathBtn setTitle:[JRSavePathTool share].exportPath];
}


- (IBAction)_selectExportPathAction:(id)sender {
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    [openPanel setAllowsMultipleSelection:NO];
    [openPanel setCanCreateDirectories:YES];
    [openPanel setCanChooseDirectories:YES];
    [openPanel setCanChooseFiles:NO];
    [openPanel setAllowsOtherFileTypes:NO];
    __weak typeof(self) weakSelf = self;
    [openPanel beginWithCompletionHandler:^(NSModalResponse result) {
        if (result == NSModalResponseOK) {
            NSString *path = [[openPanel.URLs firstObject] path];
            [JRSavePathTool share].exportPath = path;
            [weakSelf.exportPathBtn setTitle:path];
        }
    }];
}



@end
