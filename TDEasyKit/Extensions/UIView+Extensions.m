//
//  UIView+Extensions.m
//  TDEasyKit
//
//  Created by Duc Dang on 5/23/17.
//  Copyright © 2017 iCheck Corp. All rights reserved.
//
#import <objc/runtime.h>

#import "UIView+Extensions.h"

@implementation UIView (UIView_Extensions)

-(void)setLayoutBlock:(TDViewLayoutBlock)layoutBlock
{
    objc_setAssociatedObject(self, @selector(layoutBlock), layoutBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(TDViewLayoutBlock)layoutBlock
{
    return objc_getAssociatedObject(self, @selector(layoutBlock));
}

@end
