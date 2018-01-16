//
//  TDConfiguration.m
//  TDEasyKit
//
//  Created by Duc Dang on 4/27/17.
//  Copyright © 2017 iCheck Corp. All rights reserved.
//

#import "TDConfiguration.h"
#import "TDConstant.h"

@implementation TDConfiguration

-(id)init
{
    if (self = [super init]) {
        self.navigationBarHeight = kTDDefaultNavigationBarHeight;
        self.navigationBarColor = kTDDefaultNavigationBarColor;
        self.navigationBarTintColor = kTDDefaultNavigationBarTintColor;
        self.navigationBarBackIcon = kTDDefaultNavigationBarBacKIcon;
    }
    return self;
}

+(TDConfiguration*)defaultConfiguration
{
    static TDConfiguration *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TDConfiguration alloc] init];
    });
    return instance;
}

-(void)setNavigationBarColor:(UIColor *)navigationBarColor
{
    _navigationBarColor = navigationBarColor;
    if (!navigationBarColor) {
        _navigationBarColor = kTDDefaultNavigationBarColor;
    }
}

-(void)setNavigationBarTintColor:(UIColor *)navigationBarTintColor
{
    _navigationBarTintColor = navigationBarTintColor;
    if (!navigationBarTintColor) {
        _navigationBarTintColor = kTDDefaultNavigationBarTintColor;
    }
}

-(void)setNavigationBarBackIcon:(UIImage *)navigationBarBackIcon
{
    _navigationBarBackIcon = navigationBarBackIcon;
    if (!navigationBarBackIcon) {
        _navigationBarBackIcon = kTDDefaultNavigationBarBacKIcon;
    }
}
@end
