//
//  UIView+Extensions.h
//  TDEasyKit
//
//  Created by Duc Dang on 5/23/17.
//  Copyright © 2017 iCheck Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TDViewLayoutBlock)(UIView *_Nonnull view);

@interface UIView (UIView_Extensions)

/**
 The block contain layout attributes
 Called when the function layoutSubviews is called
 Use to define view's layout without layoutSubviews implementation
 */
@property (nonatomic) TDViewLayoutBlock _Nullable layoutBlock;

@end
