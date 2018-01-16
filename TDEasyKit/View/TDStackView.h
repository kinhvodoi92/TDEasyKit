//
//  TDStackView.h
//  TDEasyKit
//
//  Created by Duc Dang on 7/3/17.
//  Copyright © 2017 iCheck Corp. All rights reserved.
//

#import <TDEasyKit/TDEasyKit.h>

typedef NS_ENUM(NSInteger, TDStackViewDirection) {
    kTDStackViewDirectionVertical,
    kTDStackViewDirectionHorizontal
};

@interface TDStackView : TDScrollView
@property (nonatomic) NSMutableArray<UIView*> *views;
@property (nonatomic) TDStackViewDirection direction;
@property (nonatomic) CGFloat itemSpacing;
@property (nonatomic) CGFloat contentWidth;
@end
