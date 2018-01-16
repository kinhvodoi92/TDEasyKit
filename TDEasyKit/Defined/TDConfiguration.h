//
//  TDConfiguration.h
//  TDEasyKit
//
//  Created by Duc Dang on 4/27/17.
//  Copyright © 2017 iCheck Corp. All rights reserved.
//

@interface TDConfiguration : NSObject

/**
 Height of @navigationBar
 Default is 44, defined in TDConstant
 */
@property (nonatomic) CGFloat navigationBarHeight;

/**
 Color of @navigationBar
 Default is Black
 */
@property (nonatomic) UIColor *navigationBarColor;

/**
 Text Color of @navigationBar
 Default is White
 */
@property (nonatomic) UIColor *navigationBarTintColor;

@property (nonatomic) UIImage *navigationBarBackIcon;

/**
 Default Configuration for Kit

 @return default TDConfiguration
 */
+(TDConfiguration*)defaultConfiguration;

@end
