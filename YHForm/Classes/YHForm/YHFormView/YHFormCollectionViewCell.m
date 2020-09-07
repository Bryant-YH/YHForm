//
//  YHFormCollectionViewCell.m
//  YHForm
//
//  Created by Bryant_YH on 2020/8/27.
//  Copyright © 2020 Bryant_YH. All rights reserved.
//

#import "YHFormCollectionViewCell.h"
@interface YHFormCollectionViewCell ()
@property (nonatomic, strong)UILabel *formLabel;
@end
@implementation YHFormCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame])
    {
        self.formLabel = [[UILabel alloc] init];
        self.formLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.formLabel.font = [UIFont systemFontOfSize:[UIFont labelFontSize]];
        self.formLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:self.formLabel];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.formLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.formLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0]];
    }
    return self;
}
-(void)setCellWithText:(NSString *)text
{
    self.formLabel.text = text;
}
@end
