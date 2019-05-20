//
//  JRProgressIndicatorViewController.m
//  NcmDump
//
//  Created by 丁嘉睿 on 2019/5/20.
//  Copyright © 2019 丁嘉睿. All rights reserved.
//

#import "JRProgressIndicatorViewController.h"

@interface JRProgressIndicatorViewController ()

@property (weak) IBOutlet NSProgressIndicator *ProgressIndicator;

@end

@implementation JRProgressIndicatorViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.minValue = 0;
    self.maxValue = 0;
}

- (void)setMinValue:(double)minValue
{
    _ProgressIndicator.minValue = minValue;
    _minValue = minValue;
}

- (void)setMaxValue:(double)maxValue
{
    _ProgressIndicator.maxValue = maxValue;
    _maxValue = maxValue;
}

- (void)setProgress:(CGFloat)progress
{
    _ProgressIndicator.doubleValue = progress;
    if (progress >= self.maxValue) {
        [self dismissController:nil];
    }
}

@end
