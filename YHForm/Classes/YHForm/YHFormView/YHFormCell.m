//
//  YHFormTableCell.m
//  YHForm
//
//  Created by Bryant_YH on 2020/9/1.
//  Copyright © 2020 Bryant_YH. All rights reserved.
//

#import "YHFormCell.h"
#import "YHFormBaseTableViewCell.h"
@interface YHFormCell ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)YHFormView *formView;
@property (nonatomic, copy)NSIndexPath *indexPath;
@property (nonatomic, copy)UIColor *lineColor;
@property (nonatomic)FormViewLineType type;

@end
@implementation YHFormCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        [self initSubViews];
    }
    return self;
}
-(void)setCellWithFormView:(YHFormView *)formView withIndexPath:(NSIndexPath *)indexPath withBounces:(BOOL)bounces withClass:(Class )class withIdentifier:(NSString *)identifier withLineType:(FormViewLineType )type withColor:(UIColor *)lineColor withCount:(NSInteger )count
{
    self.type=type;
    self.lineColor = lineColor;
    self.formView=formView;
    self.indexPath=indexPath;
    self.tableView.bounces = bounces;
    [self.tableView registerClass:class forCellReuseIdentifier:identifier];
    [self.tableView reloadData];
    if (type == FormViewLineNone) return;
    self.bottomLineView.backgroundColor = lineColor;
    self.rightLineView.backgroundColor = lineColor;
    self.leftLineView.backgroundColor = lineColor;
    self.leftLineView.hidden = (type== FormViewLineNoneBorder)?indexPath.row==0 : NO;
    self.rightLineView.hidden = (type== FormViewLineNoneBorder)? (indexPath.row>=0 && indexPath.row<=count-1): (indexPath.row>=0 && indexPath.row<count-1);
}
#pragma mark -UITableViewDelegate,UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 50;
    if (self.delegate && [self.delegate respondsToSelector:@selector(formView:heightInIndexPath:)])
    {
        NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:self.indexPath.row];
        height = [self.delegate formView:self.formView heightInIndexPath:cellIndexPath];
    }
    return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger )section
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)])
    {
        return [self.dataSource tableView:tableView numberOfRowsInSection:self.indexPath.row];
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:self.indexPath.row];
    NSInteger count = (self.dataSource && [self.dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) ? [self.dataSource tableView:tableView numberOfRowsInSection:self.indexPath.row] : 0;
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(tableView:withFormViewIndexPath:)])
    {
        YHFormBaseTableViewCell *cell =  [self.dataSource tableView:tableView withFormViewIndexPath:cellIndexPath];
        if (self.type!=FormViewLineNone)
        {
            cell.bottomLineView.backgroundColor = self.lineColor;
            cell.bottomLineView.hidden = indexPath.row==count-1;
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
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self addSubview:self.tableView];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0]];
}
@end
