//
//  TDCollectionTextCell.m
//  TDEasyKit
//
//  Created by Duc Dang on 5/9/17.
//  Copyright © 2017 iCheck Corp. All rights reserved.
//

#import "TDCollectionTextCell.h"

@interface TDCollectionTextCell()
{
    UILabel *_textLabel;
}

@end

@implementation TDCollectionTextCell

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont systemFontOfSize:14];
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.numberOfLines = 1;
        [self.contentView addSubview:_textLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];

    UIEdgeInsets insets = self.textInsets;
    _textLabel.frame = CGRectMake(insets.left, insets.top, CGRectGetWidth(self.contentView.frame) - insets.left - insets.right, CGRectGetHeight(self.contentView.frame) - insets.top - insets.bottom);
}

-(void)setText:(NSString *)text font:(UIFont *)font color:(UIColor *)color
{
    _textLabel.text = text;
    _textLabel.font = font;
    _textLabel.textColor = color;
}

-(void)setText:(NSString *)text
{
    [self setText:text font:[UIFont systemFontOfSize:14] color:[UIColor blackColor]];
}

-(UILabel *)textLabel
{
    return _textLabel;
}

+(CGFloat)widthForText:(NSString *)text font:(UIFont *)font
{
    return [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 50)
                              options:NSStringDrawingUsesFontLeading
                           attributes:@{
                                        NSFontAttributeName : font
                                        }
                              context:nil
            ].size.width;
}
@end
