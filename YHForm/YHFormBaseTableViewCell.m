//
//  YHFormBaseTableViewCell.m
//  YHForm
//
//  Created by Bryant_YH on 2020/9/5.
//  Copyright © 2020 Bryant_YH. All rights reserved.
//

#import "YHFormBaseTableViewCell.h"

@implementation YHFormBaseTableViewCell


-(void)layoutSubviews
{
    _topLineView.frame = CGRectMake(0, 0, self.bounds.size.width, Line_Thickness);
    _bottomLineView.frame = CGRectMake(0, self.bounds.size.height - Line_Thickness, self.bounds.size.width, Line_Thickness);
    _leftLineView.frame = CGRectMake(0, 0, Line_Thickness, self.bounds.size.height);
    _rightLineView.frame = CGRectMake(self.bounds.size.width - Line_Thickness, 0, Line_Thickness, self.bounds.size.height);
}
-(UIView *)topLineView
{
    if (!_topLineView)
    {
        _topLineView = [self lineView];
    }
    return _topLineView;
}
-(UIView *)bottomLineView
{
    if (!_bottomLineView)
    {
        _bottomLineView = [self lineView];
    }
    return _bottomLineView;
}
-(UIView *)leftLineView
{
    if (!_leftLineView)
    {
        _leftLineView = [self lineView];
    }
    return _leftLineView;
}
-(UIView *)rightLineView
{
    if (!_rightLineView)
    {
        _rightLineView = [self lineView];
    }
    return _rightLineView;
}
-(UIView *)lineView
{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    return lineView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
