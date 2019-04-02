//
//  AppDelegate.m
//  NcmDump
//
//  Created by 丁嘉睿 on 2019/1/3.
//  Copyright © 2019 丁嘉睿. All rights reserved.
//

#import "AppDelegate.h"
#import "ClientInformation.h"

@interface AppDelegate ()

@property (nonatomic, nullable) NSWindowController *preferencesWindowController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [ClientInformation start];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    // Insert code here to tear down your application
}


- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

- (IBAction)mainMenuPreferencesApp:(id)sender {
    [NSApp activateIgnoringOtherApps:YES];
    if(_preferencesWindowController == nil)
    {
        _preferencesWindowController = [[NSStoryboard storyboardWithName:@"PreferencesStoryboard" bundle:nil] instantiateInitialController];
    }
    [_preferencesWindowController.window center];
    [_preferencesWindowController.window orderFrontRegardless];
    
    [_preferencesWindowController showWindow:self];
}

@end
