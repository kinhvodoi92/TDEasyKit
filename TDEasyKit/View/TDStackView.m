//
//  TDStackView.m
//  TDEasyKit
//
//  Created by Duc Dang on 7/3/17.
//  Copyright © 2017 iCheck Corp. All rights reserved.
//

#import "TDStackView.h"

@interface TDStackView()
{
    TDView *container;
}

@end

@implementation TDStackView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.views = [[NSMutableArray alloc] init];

        container = [[TDView alloc] init];
        [self addSubview:container];

        __weak typeof(self) weakSelf = self;
        container.layoutBlock = ^(UIView * _Nonnull view) {
            CGFloat location = 0;
            for (UIView *v in weakSelf.views) {
                CGRect rect = v.frame;
                if (weakSelf.direction == kTDStackViewDirectionVertical) {
                    rect.origin.y = location;
                    location += rect.size.height;
                }
                else {
                    rect.origin.x = location;
                    location += rect.size.width;
                }
                v.frame = rect;
            }
        };
    }
    return self;
}

-(void)addSubview:(UIView *)view
{
    if ([self.views containsObject:view]) {
        return;
    }

    [self.views addObject:view];
    [container addSubview:view];
}

-(void)insertSubview:(UIView *)view atIndex:(NSInteger)index
{
    if ([self.views containsObject:view] || index > self.views.count) {
        return;
    }

    [self.views insertObject:view atIndex:index];
    [container addSubview:view];
}

-(void)removeSubview:(UIView*)view
{
    if ([self.views containsObject:view]) {
        [self.views removeObject:view];
        [view removeFromSuperview];

        [self layoutSubviews];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];

    if (self.contentWidth == 0) {
        self.contentWidth = CGRectGetWidth(self.frame);
    }

    container.frame = CGRectMake((CGRectGetWidth(self.frame) - self.contentWidth) / 2, 0, self.contentWidth, CGRectGetHeight(container.frame));
    [container layoutSubviews];
    self.contentSize = CGSizeMake(self.contentSize.width, CGRectGetHeight(container.frame));
}

@end
