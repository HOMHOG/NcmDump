//
//  JRProgressIndicatorViewController.h
//  NcmDump
//
//  Created by 丁嘉睿 on 2019/5/20.
//  Copyright © 2019 丁嘉睿. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface JRProgressIndicatorViewController : NSViewController

@property (nonatomic, assign) double minValue;

@property (nonatomic, assign) double maxValue;

- (void)setProgress:(CGFloat)progress;

@end

NS_ASSUME_NONNULL_END
