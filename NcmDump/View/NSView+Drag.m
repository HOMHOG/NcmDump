//
//  NSView+Drag.m
//  NcmDump
//
//  Created by 丁嘉睿 on 2019/11/13.
//  Copyright © 2019 丁嘉睿. All rights reserved.
//

#import "NSView+Drag.h"

@implementation NSView (Drag)

- (void)jr_registerForDraggedTypes:(NSArray<NSPasteboardType> *)newTypes
{
    NSMutableArray *muTypes = [newTypes mutableCopy];
    if (newTypes.count == 0) {
        [muTypes addObject:NSFilenamesPboardType];
    }
    [self registerForDraggedTypes:[muTypes copy]];
}

// 拖放显示图标
- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender {
    [self set];
    return NSDragOperationGeneric;
}

- (NSDragOperation)draggingUpdated:(id<NSDraggingInfo>)sender {
    [self dragInSide] = YES;
    return NSDragOperationGeneric;
}

- (void)draggingEnded:(id<NSDraggingInfo>)sender {
    if (self.dragInSide) {
        NSPasteboard *pasteboard = [sender draggingPasteboard];
        NSArray *files = [pasteboard propertyListForType:NSFilenamesPboardType];
        NSMutableArray *results = [NSMutableArray arrayWithCapacity:files.count];
        for (NSString *filePath in files) {
            if ([self.dragDelegate respondsToSelector:@selector(supportFile)]) {
                NSString *pathExtension = [filePath pathExtension];
                NSArray *array = [self.dragDelegate supportFile];
                if ([array containsObject:pathExtension]) {
                    [results addObject:filePath];
                }
            }
        }
        if ([self.dragDelegate respondsToSelector:@selector(didDragFiles:)]) {
            [self.dragDelegate didDragFiles:[results copy]];
        }
    }
}

- (void)draggingExited:(id<NSDraggingInfo>)sender
{
    _dragInSide = NO;
}

// 拖放操作
- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender {
    NSPasteboard *pasteboard = [sender draggingPasteboard];
    NSArray *files = [pasteboard propertyListForType:NSFilenamesPboardType];
    for (NSString *filePath in files) {
        if ([self.dragDelegate respondsToSelector:@selector(supportFile)]) {
            NSString *pathExtension = [filePath pathExtension];
            NSArray *array = [self.dragDelegate supportFile];
            if (![array containsObject:pathExtension]) {
                return NO;
            }
        }
    }
    return YES;
}



#pragma mark runtime
- (void)setDragInSide:(BOOL)dragInSide
{
    objc_setAssociatedObject(self, @selector(dragInSide), dragInSide, OBJC_ASSOCIATION_ASSIGN);
}


- (BOOL)dragInSide
{
    return objc_getAssociatedObject(self, _cmd);
}

@end
