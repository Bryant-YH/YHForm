//
//  YHTIndexPath.m
//  YHForm
//
//  Created by Bryant_YH on 2020/9/3.
//  Copyright © 2020 Bryant_YH. All rights reserved.
//

#import "YHTIndexPath.h"
#import <UIKit/UIKit.h>
@implementation YHTIndexPath
+(instancetype)indexPathForXSection:(NSInteger)xSection withYSection:(NSInteger )ySection withForm:(NSInteger )form
{
    YHTIndexPath *index = [[YHTIndexPath alloc] init];
    index.form = form;
    index.xSection = xSection;
    index.ySection = ySection;
    return index;
}
+(instancetype)indexPathForXSection:(NSInteger)xSection withYSection:(NSInteger )ySection
{
    YHTIndexPath *index = [[YHTIndexPath alloc] init];
    index.xSection = xSection;
    index.ySection = ySection;
    return index;
}
-(void)setForm:(NSInteger)form
{
    _form = form;
}
-(void)setXSection:(NSInteger)xSection
{
    _xSection = xSection;
}
-(void)setYSection:(NSInteger)ySection
{
    _ySection = ySection;
}
@end
