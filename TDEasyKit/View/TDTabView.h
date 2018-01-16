//
//  TDTabView.h
//  TDEasyKit
//
//  Created by Duc Dang on 5/8/17.
//  Copyright © 2017 iCheck Corp. All rights reserved.
//

#import "TDView.h"

@protocol TDTabViewDelegate;
@protocol TDTabViewDataSource;

typedef NS_ENUM(NSInteger, TDTabViewFocusMode) {
    kTDTabViewFocusModeBar       = 0,          //1 small bar move between tabs,
    kTDTabViewFocusModeTrigle    = 1,       //1 tigle icon move between tabs
    kTDTabViewFocusModeHighlight = 2     //Highlight (Background color, text color changed) the selected tab, others isn't highlight
};

typedef NS_ENUM(NSInteger, TDTabViewLayoutMode) {
    kTDTabViewLayoutModeContinuous       = 0,          //lien tiep
    kTDTabViewLayoutModeFixed                           //Chia deu co dinh
};

/**
 Tabview with list of titles/views
 Focus Mode: Bar, Trigle, Highlight
 */
@interface TDTabView : TDView

/**
 Send event to superview
 */
@property (nonatomic) id<TDTabViewDelegate> delegate;

@property (nonatomic) id<TDTabViewDataSource> dataSource;

/**
 Number of tabs in tabview
 */
@property (nonatomic, readonly) NSInteger numberOfTabs;

/**
 Focus mode style when One tab is selected, moving between tabs
 */
@property (nonatomic) TDTabViewFocusMode focusMode;
@property (nonatomic) TDTabViewLayoutMode layoutMode;

/**
 Current Selected Tab
 */
@property (nonatomic) NSInteger currentTab;

@property (nonatomic) UIColor *tintColor;

-(void)reloadData;
/**
 Reload tabs when change the datasource data

 @param completion : callback
 */
-(void)reloadDataCompletion:(void(^)(BOOL finised))completion;

@end

@interface TDTabView (Layout)

@end

@interface TDTabView (Delegate_DataSource) <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

#pragma mark - DataSource
@protocol TDTabViewDataSource <NSObject>

/**
 set number of tabs for TabView

 @param tabView : TabView
 @return        : Number of tabs
 */
-(NSInteger)numberOfTabsInTabView:(TDTabView*)tabView;

/**
 Set Title for tab

 @param tabView : TabView
 @param index   : index to set Title
 @return        : Title String
 */
-(NSString*)tabView:(TDTabView*)tabView titleForIndex:(NSInteger)index;

@optional
-(UIFont*)tabView:(TDTabView*)tabView fontForTitleAtIndex:(NSInteger)index;

-(UIColor*)tabView:(TDTabView*)tabView colorForTitleAtIndex:(NSInteger)index;

//-(UIView*)tabView:(TDTabView*)tabView titleForIndex:(NSInteger)index;
@end

/**
 Delegate to send event action to superview
 */
@protocol TDTabViewDelegate <NSObject>

@optional
/**
 Invoke when One tab is selected

 @param tabView : tabView
 @param index   : selected Index
 */
-(void)tabView:(TDTabView*)tabView didSelectedIndex:(NSInteger)index;
@end
