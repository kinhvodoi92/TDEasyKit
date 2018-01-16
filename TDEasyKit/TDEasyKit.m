//
//  TDEasyKit.m
//  TDEasyKit
//
//  Created by Duc Dang on 4/27/17.
//  Copyright © 2017 iCheck Corp. All rights reserved.
//

#import "TDEasyKit.h"

@implementation TDEasyKit

+(void)configure:(TDConfiguration*(^)())configBlock
{
    TDConfiguration *config = configBlock();

    TDConfiguration *defaultConfig = [TDConfiguration defaultConfiguration];
    defaultConfig.navigationBarHeight = config.navigationBarHeight;
    defaultConfig.navigationBarColor = config.navigationBarColor;

    defaultConfig = nil;
}

@end
