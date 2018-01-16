//
//  TDViewController.h
//  TDEasyKit
//
//  Created by Duc Dang on 4/26/17.
//  Copyright © 2017 iCheck Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TDNavigationBar;

@protocol TDNavigationBarDelegate <NSObject>

@optional
-(void)pressedBack:(TDNavigationBar*)navigationBar;

@end

/**
 Custom NavigationBar
 Contain: LeftContainer, CenterContainer, RightContainer
 AutoLayout
 Default Height: 44
 */
@interface TDNavigationBar : UIView

@end

@interface TDNavigationBar (Layout)

@end

@interface TDNavigationBar (Actions)

-(void)back:(UIButton*)sender;

@end

@interface TDViewController : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic) TDNavigationBar *navigationBar;
@property (nonatomic) UIView *statusBar;

@property (nonatomic) BOOL hidesBackButton;

@property (nonatomic) CGFloat keyboardHeight;
@property (nonatomic) BOOL shouldLayoutDependOnKeyboard;

/**
 List of Views for left of navigationBar
 Default is nil
 */
@property (nonatomic) NSArray<UIView*> *leftViews;

/**
 List of Views for Center of navigationBar
 Default is nil
 */
@property (nonatomic) NSArray<UIView*> *titleViews;

/**
 List of Views for right of navigationBar
 Default is nil
 */
@property (nonatomic) NSArray<UIView*> *rightViews;

-(void)setup;

-(void)setTitleViews:(NSArray<UIView *> *)titleViews spacing:(CGFloat)spacing;
-(void)setTitle:(NSString *)title font:(UIFont*)font;
-(void)setNavigationBarHidden:(BOOL)isHidden;
@end

@interface TDViewController (Layout)

@end

@interface TDViewController (Actions)
-(void)pressedBack:(TDNavigationBar *)navigationBar;
@end
