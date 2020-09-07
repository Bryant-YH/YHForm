//
//  TestCollectionViewCell.m
//  YHForm
//
//  Created by Bryant_YH on 2020/9/4.
//  Copyright © 2020 Bryant_YH. All rights reserved.
//

#import "TestCollectionViewCell.h"
@interface TestCollectionViewCell ()
@property (nonatomic, strong)UILabel *label;
@end
@implementation TestCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        self.label = [[UILabel alloc] init];
        self.label.textColor = [UIColor yellowColor];
        
        self.label.textAlignment=NSTextAlignmentCenter;
        [self addSubview:self.label];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.label.frame = self.bounds;
}
-(void)setCellWithTxt:(NSString *)text
{
    self.label.text=text;
}
@end
