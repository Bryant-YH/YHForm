//
//  YHFormTestTableCell.m
//  YHForm
//
//  Created by Bryant_YH on 2020/9/1.
//  Copyright © 2020 Bryant_YH. All rights reserved.
//

#import "YHFormTestTableCell.h"
@interface YHFormTestTableCell ()
@property (nonatomic, strong)UILabel *label;
@end
@implementation YHFormTestTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.label = [[UILabel alloc] init];
        self.label.textColor = [UIColor yellowColor];
        
        self.label.textAlignment=NSTextAlignmentCenter;
//        self.label.backgroundColor = [UIColor grayColor];
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
