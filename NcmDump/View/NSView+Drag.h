//
//  NSView+Drag.h
//  NcmDump
//
//  Created by 丁嘉睿 on 2019/11/13.
//  Copyright © 2019 丁嘉睿. All rights reserved.
//


#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSView (Drag)

- (void)jr_registerForDraggedTypes:(NSArray<NSPasteboardType> *)newTypes;

@end

NS_ASSUME_NONNULL_END
