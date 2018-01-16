//
//  TDButton.m
//  TDEasyKit
//
//  Created by Duc Dang on 7/4/17.
//  Copyright © 2017 iCheck Corp. All rights reserved.
//

#import "TDButton.h"

@implementation TDButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addTarget:self action:@selector(pressed:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchCancel];
    }
    return self;
}

-(void)layoutSubviews
{
    CGRect prevRect = self.frame;

    [super layoutSubviews];

    if (self.layoutBlock) {
        self.layoutBlock(self);
    }

    if (!CGRectEqualToRect(prevRect, self.frame) && self.superview) {
        [self.superview setNeedsLayout];
    }
}

-(void)dealloc
{
    self.layoutBlock = nil;
}

-(void)pressed:(UIButton*)sender
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];

    [UIView animateWithDuration:0.1 animations:^{
        sender.transform = CGAffineTransformMakeScale(1.05, 1.05);
    } completion:^(BOOL finished) {
        sender.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

-(void)touch:(UIButton*)sender {
    [UIView animateWithDuration:0.1 animations:^{
        sender.transform = CGAffineTransformMakeScale(1.05, 1.05);
    } completion:^(BOOL finished) {
        sender.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

-(void)cancel:(UIButton*)sender {
    [UIView animateWithDuration:0.1 animations:^{
        sender.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
    }];
}

@end
