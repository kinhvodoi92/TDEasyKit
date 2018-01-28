//
//  TDEasyKit.h
//  TDEasyKit
//
//  Created by Duc Dang on 4/26/17.
//  Copyright © 2017 iCheck Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for TDEasyKit.
FOUNDATION_EXPORT double TDEasyKitVersionNumber;

//! Project version string for TDEasyKit.
FOUNDATION_EXPORT const unsigned char TDEasyKitVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <TDEasyKit/PublicHeader.h>

#import <TDEasyKit/TDView.h>
#import <TDEasyKit/TDTabView.h>
#import <TDEasyKit/TDCollectionTextCell.h>
#import <TDEasyKit/TDScrollView.h>
#import <TDEasyKit/TDCollectionViewCell.h>
#import <TDEasyKit/TDButton.h>
#import <TDEasyKit/TDExtensions_Header.h>

#import <TDEasyKit/TDConstant.h>
#import <TDEasyKit/TDConfiguration.h>

#import <TDEasyKit/TDViewController.h>

@interface TDEasyKit : NSObject

/**
 Configure properties of Kit

 @param config TDConfiguration to config
 */
+(void)configure:(TDConfiguration*(^)(void))config;

@end
