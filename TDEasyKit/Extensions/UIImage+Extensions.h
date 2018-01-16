//
//  UIImage+Extensions.h
//  TDEasyKit
//
//  Created by Duc Dang on 4/27/17.
//  Copyright © 2017 iCheck Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImage_TDExtensions)

/**
 Set image with name in TDEasyKitBundle.bundle

 @param name Name of image file
 @return image
 */
+(UIImage*)td_imageNamed:(NSString *)name;

@end
