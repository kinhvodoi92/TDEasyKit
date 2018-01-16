//
//  TDConstant.m
//  TDEasyKit
//
//  Created by Duc Dang on 4/27/17.
//  Copyright © 2017 iCheck Corp. All rights reserved.
//

#import "TDConstant.h"

CGFloat const kTDDefaultNavigationBarHeight = 44;
UIColor *const kTDDefaultNavigationBarColor = [UIColor blackColor];
UIColor *const kTDDefaultNavigationBarTintColor = [UIColor whiteColor];
UIImage *const kTDDefaultNavigationBarBacKIcon = [UIImage td_imageNamed:@"icon_bar_back_green"];

@implementation TDConstant

static NSBundle *internalBundle = nil;
+(NSBundle*)bundle {
    if (!internalBundle) {
        internalBundle = [NSBundle bundleForClass:[self class]];

        NSURL *url = internalBundle.resourceURL;

        if (url) {
            internalBundle = [NSBundle bundleWithURL:[url URLByAppendingPathComponent:@"TDEasyKitBundle.bundle"]];
        }

        url = nil;
    }
    
    return internalBundle;
}

@end
