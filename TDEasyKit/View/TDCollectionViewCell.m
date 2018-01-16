//
//  TDCollectionViewCell.m
//  TDEasyKit
//
//  Created by Duc Dang on 7/7/17.
//  Copyright © 2017 iCheck Corp. All rights reserved.
//

#import "TDCollectionViewCell.h"

@implementation TDCollectionViewCell

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

@end
