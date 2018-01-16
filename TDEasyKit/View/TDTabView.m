//
//  TDTabView.m
//  TDEasyKit
//
//  Created by Duc Dang on 5/8/17.
//  Copyright © 2017 iCheck Corp. All rights reserved.
//

#import "TDTabView.h"
#import "TDCollectionTextCell.h"

@interface TDTabView()
{
    UICollectionView *tabsView;
    UIView *barView;

    NSInteger _numberOfTabs;
}
@end

@implementation TDTabView

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];

        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;

        tabsView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame)) collectionViewLayout:layout];
        tabsView.backgroundColor = [UIColor clearColor];
        tabsView.showsHorizontalScrollIndicator = false;
        tabsView.delegate = self;
        tabsView.dataSource = self;
        [tabsView registerClass:[TDCollectionTextCell class] forCellWithReuseIdentifier:@"CellIdentifier"];
        [self addSubview:tabsView];

        barView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(tabsView.frame) - 2, 0, 2)];
        barView.backgroundColor = [UIColor blackColor];
        [tabsView addSubview:barView];
    }
    return self;
}

-(void)reloadData
{
    [self reloadDataCompletion:nil];
}

-(void)reloadDataCompletion:(void (^)(BOOL))completion
{
    [tabsView performBatchUpdates:^{
        [tabsView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    } completion:^(BOOL finished) {
//        [self setCurrentTab:0];
        if (completion) {
            completion(finished);
        }
    }];
}

-(void)setCurrentTab:(NSInteger)currentTab
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfTabsInTabView:)] && [self.dataSource numberOfTabsInTabView:self] > currentTab) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentTab inSection:0];
        CGRect cellFrame = [tabsView layoutAttributesForItemAtIndexPath:indexPath].frame;

        if (tabsView.contentOffset.x > CGRectGetMinX(cellFrame)) {
            [tabsView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:true];
        }
        else if (tabsView.contentOffset.x < CGRectGetMaxX(cellFrame) - CGRectGetWidth(tabsView.frame)) {
            [tabsView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionRight animated:true];
        }

        TDCollectionTextCell  *prevCell = (TDCollectionTextCell*)[tabsView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:_currentTab inSection:0]];
        TDCollectionTextCell  *cell = (TDCollectionTextCell*)[tabsView cellForItemAtIndexPath:indexPath];
        [UIView animateWithDuration:0.3f animations:^{
            barView.frame = CGRectMake(CGRectGetMinX(cellFrame), CGRectGetMinY(barView.frame), CGRectGetWidth(cellFrame), CGRectGetHeight(barView.frame));
            if (prevCell && [self.dataSource respondsToSelector:@selector(tabView:colorForTitleAtIndex:)]) {
                prevCell.textLabel.textColor = [self.dataSource tabView:self colorForTitleAtIndex:_currentTab];
            }
            if (cell) {
                cell.textLabel.textColor = _tintColor;
            }
        } completion:^(BOOL finished) {
            barView.frame = CGRectMake(CGRectGetMinX(cellFrame), CGRectGetMinY(barView.frame), CGRectGetWidth(cellFrame), CGRectGetHeight(barView.frame));
        }];
    }

    _currentTab = currentTab;
}

-(void)setTintColor:(UIColor *)tintColor
{
    _tintColor = tintColor;

    if (barView) {
        barView.backgroundColor = tintColor;
    }
}

-(NSInteger)numberOfTabs
{
    return _numberOfTabs;
}

@end

@implementation TDTabView (Layout)

-(void)layoutSubviews
{
    [super layoutSubviews];

    tabsView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    barView.frame = CGRectMake(CGRectGetMinX(barView.frame), CGRectGetHeight(tabsView.frame) - 2, CGRectGetWidth(barView.frame), 2);
}

@end

@implementation TDTabView (Delegate_DataSource)

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfTabsInTabView:)]) {
        _numberOfTabs = [self.dataSource numberOfTabsInTabView:self];
        return _numberOfTabs;
    }

    return 0;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(tabView:titleForIndex:)]) {
        NSString *title = [self.dataSource tabView:self titleForIndex:indexPath.item];
        UIFont *titleFont = [UIFont systemFontOfSize:14];

        if ([self.dataSource respondsToSelector:@selector(tabView:fontForTitleAtIndex:)]) {
            titleFont = [self.dataSource tabView:self fontForTitleAtIndex:indexPath.item];
        }

        return CGSizeMake(_layoutMode == kTDTabViewLayoutModeFixed ? CGRectGetWidth(collectionView.frame) / [self.dataSource numberOfTabsInTabView:self] : [TDCollectionTextCell widthForText:title font:titleFont] + 40, CGRectGetHeight(self.frame));
    }
    return CGSizeZero;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TDCollectionTextCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(tabView:titleForIndex:)]) {
        NSString *title = [self.dataSource tabView:self titleForIndex:indexPath.item];
        UIFont *titleFont = [UIFont systemFontOfSize:14];
        UIColor *titleColor = [UIColor blackColor];

        if ([self.dataSource respondsToSelector:@selector(tabView:fontForTitleAtIndex:)]) {
            titleFont = [self.dataSource tabView:self fontForTitleAtIndex:indexPath.item];
        }

        if ([self.dataSource respondsToSelector:@selector(tabView:colorForTitleAtIndex:)]) {
            titleColor = [self.dataSource tabView:self colorForTitleAtIndex:indexPath.item];
        }
        if (indexPath.item == _currentTab) {
            titleColor = _tintColor;
        }

        [cell setText:title font:titleFont color:titleColor];

        title = nil;
        titleFont = nil;
        titleColor = nil;
    }

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self setCurrentTab:indexPath.item];
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabView:didSelectedIndex:)]) {
        [self.delegate tabView:self didSelectedIndex:indexPath.item];
    }
}
@end
