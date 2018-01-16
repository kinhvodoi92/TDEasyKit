//
//  UIImage+Extensions.m
//  TDEasyKit
//
//  Created by Duc Dang on 4/27/17.
//  Copyright © 2017 iCheck Corp. All rights reserved.
//

#import "UIImage+Extensions.h"
#import "TDConstant.h"

@implementation UIImage (UIImage_TDExtensions)

+(UIImage*)td_imageNamed:(NSString *)name
{
    return [UIImage imageNamed:name inBundle:[TDConstant bundle] compatibleWithTraitCollection:nil];
}

@end
