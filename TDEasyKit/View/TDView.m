//
//  TDView.m
//  TDEasyKit
//
//  Created by Duc Dang on 5/8/17.
//  Copyright © 2017 iCheck Corp. All rights reserved.
//

#import "TDView.h"
#import "UIView+Extensions.h"

@implementation TDView

-(void)layoutSubviews
{
    CGRect prevRect = self.frame;

    [super layoutSubviews];

    __weak typeof(self) weakself = self;
    if (self.layoutBlock) {
        self.layoutBlock(weakself);
    }

    if (!CGRectEqualToRect(prevRect, self.frame) && self.superview) {
        [self.superview setNeedsLayout];
    }
}

-(void)dealloc
{
    self.layoutBlock = nil;
}

@end
