//
//  TDButton.h
//  TDEasyKit
//
//  Created by Duc Dang on 7/4/17.
//  Copyright © 2017 iCheck Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TDButtonAnimation) {
    kTDButtonAnimationNone,
    kTDButtonAnimationScale,
    kTDButtonAnimationShakeHorizontal,
    kTDButtonAnimationShakeVertical
};

@interface TDButton : UIButton
@property (nonatomic) TDButtonAnimation animation;
@end
