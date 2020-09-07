//
//  YHFormTestCell.m
//  YHForm
//
//  Created by Bryant_YH on 2020/8/27.
//  Copyright © 2020 Bryant_YH. All rights reserved.
//

#import "YHFormTestCell.h"
@interface YHFormTestCell ()
@property (nonatomic, strong)UILabel *formLabel;
@end
@implementation YHFormTestCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame])
    {
        self.formLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.formLabel.text=@"asd";
        self.formLabel.textAlignment=NSTextAlignmentCenter;
        self.formLabel.backgroundColor = [UIColor redColor];
        [self addSubview:self.formLabel];
    }
    return self;
}
-(void)setCellWithModel:(NSString *)text
{
    self.formLabel.text=text;
    self.formLabel.backgroundColor =([text isEqualToString:@"qwe"])? [UIColor yellowColor] : [UIColor redColor];

}
@end
