//
//  YHTFormCell.m
//  YHForm
//
//  Created by Bryant_YH on 2020/9/3.
//  Copyright © 2020 Bryant_YH. All rights reserved.
//

#import "YHTFormCell.h"
#import "YHTIndexPath.h"
#import "YHFormBaseTableViewCell.h"
@interface YHTFormCell ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)YHTFormView *formView;
@property (nonatomic, copy)NSIndexPath *indexPath;
@property (nonatomic, copy)UIColor *lineColor;
@property (nonatomic)FormViewLineType type;
@end
@implementation YHTFormCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        [self initSubViews];
    }
    return self;
}
-(void)setCellWithFormView:(YHTFormView *)formView withIndexPath:(NSIndexPath *)indexPath withClass:(Class )class withIdentifier:(NSString *)identifier withLineType:(FormViewLineType )type withColor:(UIColor *)lineColor
{
    self.type=type;
    self.lineColor=lineColor;
    self.formView=formView;
    self.indexPath=indexPath;
    [self.tableView registerClass:class forCellReuseIdentifier:identifier];
    [self.tableView reloadData];
}
#pragma mark -UITableViewDelegate,UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 50;
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellDelegateFormView:heightForIndexPath:)])
    {
        YHTIndexPath *cellIndexPath = [YHTIndexPath indexPathForXSection:0 withYSection:self.indexPath.row withForm:indexPath.row];
        height = [self.delegate cellDelegateFormView:self.formView heightForIndexPath:cellIndexPath];
    }
    return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger )section
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellDelegateFormViewOfContentTableView:numberOfRowsInSection:)])
    {
        return [self.delegate cellDelegateFormViewOfContentTableView:tableView numberOfRowsInSection:self.indexPath.row];
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YHTIndexPath *cellIndexPath = [YHTIndexPath indexPathForXSection:0 withYSection:self.indexPath.row withForm:indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellDelegateFormViewOfContentTableView:withFormViewIndexPath:)])
    {
        YHFormBaseTableViewCell *cell = [self.delegate cellDelegateFormViewOfContentTableView:tableView withFormViewIndexPath:cellIndexPath];
        if (self.type != FormViewLineNone)
        {
            cell.bottomLineView.backgroundColor = self.lineColor;
        }
        return cell;
    }
    return nil;
}
#pragma mark - Init
-(void)initSubViews
{
    self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.showsVerticalScrollIndicator=NO;
    self.tableView.showsHorizontalScrollIndicator=NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0]];
}
@end
