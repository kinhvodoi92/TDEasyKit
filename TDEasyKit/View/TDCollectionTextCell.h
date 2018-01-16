//
//  TDCollectionTextCell.h
//  TDEasyKit
//
//  Created by Duc Dang on 5/9/17.
//  Copyright © 2017 iCheck Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDCollectionTextCell : UICollectionViewCell

@property (nonatomic, readonly) UILabel *textLabel;
@property (nonatomic) UIEdgeInsets textInsets;

+(CGFloat)widthForText:(NSString*)text font:(UIFont*)font;

-(void)setText:(NSString*)text;
-(void)setText:(NSString*)text font:(UIFont*)font color:(UIColor*)color;

@end
