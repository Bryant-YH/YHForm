//
//  YHTFormView.m
//  YHForm
//
//  Created by Bryant_YH on 2020/9/2.
//  Copyright © 2020 Bryant_YH. All rights reserved.
//

#import "YHTFormView.h"
#import "YHTIndexPath.h"
#import "YHTFormCell.h"
#import "YHFormCollectionViewCell.h"
#import "YHTFormTableViewCell.h"
@interface YHTFormView ()<UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, YHTFormCellDelegate, UIScrollViewDelegate, YHTFormTableCellDelegate>
@property (nonatomic, strong)UIView *headerView;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UICollectionView *contentCollectionView;
@property (nonatomic, strong)UITableView *contentTableView;
@property (nonatomic, assign)CGFloat headerHeight;
@property (nonatomic, assign)CGFloat headerWidth;
@property (nonatomic, assign)CGFloat contentHeight;
@property (nonatomic) YHTFormViewDirectionType type;//排序方向
@property (nonatomic)Class cellClass;
@property (nonatomic, copy)NSString *cellIdentifier;
@property (nonatomic)FormViewLineType lineType;
@property (nonatomic, strong)UIView *topLineView;
@property (nonatomic, strong)UIView *leftLineView;
@property (nonatomic, strong)UIView *rightLineView;
@property (nonatomic, strong)UIView *bottomLineView;
@property (nonatomic, strong)UIView *rightHeaderLineView;
@property (nonatomic, strong)UIView *bottomHeaderLineView;

@property (nonatomic, assign)BOOL isShowLeftHeaderLine;
@end
@implementation YHTFormView

-(instancetype)initWithFrame:(CGRect)frame withHeaderHeight:(CGFloat )height withTitleWidth:(CGFloat )width withType:(YHTFormViewDirectionType )type withLineType:(FormViewLineType )lineType
{
    if (self == [super initWithFrame:frame])
    {
        self.isShowLeftHeaderLine = YES;
        self.type = type;
        self.backgroundColor = [UIColor whiteColor];
        self.headerHeight = height;
        self.headerWidth = width;
        self.contentHeight = self.bounds.size.height - self.headerHeight;
        [self iniSubViews];
        self.lineType = lineType;
        self.lineColor = [UIColor lightGrayColor];
    }
    return self;
}
#pragma mark - Setter
-(void)setArray:(NSArray<NSString *> *)array
{
    _array = array;
    [self.collectionView reloadData];
}
-(void)setInvariantTitle:(NSString *)invariantTitle
{
    _invariantTitle = invariantTitle;
    if ([self.invariantView isKindOfClass:[UILabel class]])
    {
        ((UILabel *)self.invariantView).text = self.invariantTitle;
    }
}
-(void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    if (self.lineType!= FormViewLineNone) {
        [self handleTheLine];
        [self reloadData];
    }
}
//-(void)setBounces:(BOOL)bounces
//{
//    _bounces = bounces;
//    self.collectionView.bounces=self.bounces;
//    self.tableView.bounces=self.bounces;
//    if (self.type == YHTFormViewDirectionX)
//    {
//        self.contentTableView.bounces=self.bounces;
//        [self.contentTableView reloadData];
//    }
//    else
//    {
//        self.contentCollectionView.bounces=self.bounces;
//        [self.contentCollectionView reloadData];
//    }
//}
- (void)registerHeaderFormClass:(nullable Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier
{
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
}
- (void)registerLeftHeaderFormClass:(nullable Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier
{
    [self.tableView registerClass:cellClass forCellReuseIdentifier:identifier];
}

- (void)registerFormClass:(nullable Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier
{
    self.cellClass=cellClass;
    self.cellIdentifier=identifier;
    if (self.type == YHTFormViewDirectionX)   [self.contentTableView reloadData];
    else  [self.contentCollectionView reloadData];
}
-(void)reloadData
{
    [self.collectionView reloadData];
    [self.tableView reloadData];
    if (self.type == YHTFormViewDirectionX)   [self.contentTableView reloadData];
    else  [self.contentCollectionView reloadData];
}
#pragma mark - Delegate
//YHTFormViewDirectionY
- (CGFloat)cellDelegateFormView:(YHTFormView *)formView heightForIndexPath:(YHTIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(formView:heightForIndexPath:)])
    {
        return [self.delegate formView:self heightForIndexPath:indexPath];
    }
    return 50;
}
-(NSInteger)cellDelegateFormViewOfContentTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger )section
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(formViewOfContentTableView:numberOfRowsInSection:)])
    {
        return [self.dataSource formViewOfContentTableView:tableView numberOfRowsInSection:section];
    }
    return 0;
}
-(YHFormBaseTableViewCell *)cellDelegateFormViewOfContentTableView:(UITableView *)tableView withFormViewIndexPath:(YHTIndexPath *)indexPath
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(formViewOfContentTableView:withFormViewIndexPath:)])
    {
        return [self.dataSource formViewOfContentTableView:tableView withFormViewIndexPath:indexPath];
    }
    return nil;
}
//YHTFormViewDirectionX
- (CGFloat )tableCellDelegateFormView:(YHTFormView *)formView widthForHeaderInSection:(NSInteger)xSection
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(formView:widthForHeaderInSection:)])  {
        return [self.delegate formView:self widthForHeaderInSection:xSection];
    }
    return self.bounds.size.width / self.array.count;
}
- (YHFormBaseCollectionViewCell *)tableCellDelegateCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(YHTIndexPath *)indexPath
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(formViewOfCollectionView:cellForItemAtIndexPath:)])
    {
        return [self.dataSource formViewOfCollectionView:collectionView cellForItemAtIndexPath:indexPath];
    }
    return nil;
}
#pragma mark -TableView
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.tableView])
    {
        return (self.delegate && [self.delegate respondsToSelector:@selector(formView:heightForHeaderInSection:)])? [self.delegate formView:self heightForHeaderInSection:indexPath.row] : 50;
    }
    YHTIndexPath *cellIndexPath = [YHTIndexPath indexPathForXSection:0 withYSection:indexPath.section withForm:indexPath.row];
    return (self.delegate && [self.delegate respondsToSelector:@selector(formView:heightForIndexPath:)])? [self.delegate formView:self heightForIndexPath:cellIndexPath] : 50;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView isEqual:self.contentTableView])
    {
        return (self.dataSource && [self.dataSource respondsToSelector:@selector(formViewOfTableView:numberOfRowsInSection:)])? [self.dataSource formViewOfTableView:tableView numberOfRowsInSection:0] : 1;
    }
    return 1;
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.tableView])
    {
        return (self.dataSource && [self.dataSource respondsToSelector:@selector(formViewOfTableView:numberOfRowsInSection:)])? [self.dataSource formViewOfTableView:tableView numberOfRowsInSection:section] : 0;
    }
    return (self.dataSource && [self.dataSource respondsToSelector:@selector(formViewOfContentTableView:numberOfRowsInSection:)])? [self.dataSource formViewOfContentTableView:tableView numberOfRowsInSection:section] : 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.contentTableView])
    {
        NSInteger xCount = (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfSectionsInFromView:)]) ? [self.dataSource numberOfSectionsInFromView:self] : self.array.count;
        YHTIndexPath *cellIndexPath = [YHTIndexPath indexPathForXSection:0 withYSection:indexPath.section withForm:indexPath.row];
        CGFloat height = (self.delegate && [self.delegate respondsToSelector:@selector(formView:heightForIndexPath:)])? [self.delegate formView:self heightForIndexPath:cellIndexPath] : 50;
        YHTFormTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YHTFormTableViewCell"];
        [cell setCellWithXCount:xCount withHeight:height withIndexPath:indexPath withFormView:self withClass:self.cellClass withIdentifier:self.cellIdentifier withLineType:self.lineType withColor:self.lineColor];
        cell.delegate=self;
        
        return cell;
    }
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(formViewOfTableView:withFormViewIndexPath:)]) {
        YHFormBaseTableViewCell *cell = [self.dataSource formViewOfTableView:tableView withFormViewIndexPath:indexPath];
        if (self.lineType != FormViewLineNone) {
            cell.bottomLineView.backgroundColor = self.lineColor;
            cell.rightLineView.backgroundColor = self.lineColor;
            cell.leftLineView.backgroundColor = self.lineColor;
            cell.leftLineView.hidden=YES;
        }
        return cell;
    }
    return nil;
}
#pragma mark -CollectionView
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = self.bounds.size.width / self.array.count;
    if (self.delegate && [self.delegate respondsToSelector:@selector(formView:widthForHeaderInSection:)])  {
        width = [self.delegate formView:self widthForHeaderInSection:indexPath.section];
    }
    else if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfSectionsInFromView:)]){
            width = width / [self.dataSource numberOfSectionsInFromView:self];
    }
    return CGSizeMake(width, [collectionView isEqual:self.collectionView]?self.headerHeight:self.contentHeight);
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfSectionsInFromView:)]) ? [self.dataSource numberOfSectionsInFromView:self] : self.array.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([collectionView isEqual:self.collectionView])
    {
        YHFormBaseCollectionViewCell *cell =(self.dataSource && [self.dataSource respondsToSelector:@selector(formView:withCollectionView:viewForHeaderInIndexPath:)])? [self.dataSource formView:self withCollectionView:collectionView viewForHeaderInIndexPath:indexPath] : [collectionView dequeueReusableCellWithReuseIdentifier:@"YHFormCollectionViewCell" forIndexPath:indexPath];
        if (self.lineType!=FormViewLineNone)
        {
            cell.bottomLineView.backgroundColor = self.lineColor;
            cell.leftLineView.backgroundColor = self.lineColor;
            cell.leftLineView.hidden = indexPath.row==0;
        }
        if ([cell isKindOfClass:[YHFormCollectionViewCell class]])
        {
            [(YHFormCollectionViewCell *)cell setCellWithText:self.array[indexPath.row]];
        }
        return cell;
    }
    YHTFormCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YHTFormCell" forIndexPath:indexPath];
    [cell setCellWithFormView:self withIndexPath:indexPath withClass:self.cellClass withIdentifier:self.cellIdentifier withLineType:self.lineType withColor:self.lineColor];
    cell.delegate=self;
    if (self.lineType!=FormViewLineNone)
    {
        cell.leftLineView.backgroundColor = self.lineColor;
        cell.leftLineView.hidden = indexPath.row==0;
    }
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.type == YHTFormViewDirectionX)
    {
        if ([scrollView isEqual:self.tableView])  self.contentTableView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
        else if ([scrollView isEqual:self.contentTableView]) self.tableView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
        else if ([scrollView isEqual:self.collectionView])
        {
            [self handleTheXScroll:scrollView];
        }
        return;
    }
    if ([scrollView isEqual:self.collectionView]) self.contentCollectionView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
    else if ([scrollView isEqual:self.contentCollectionView]) self.collectionView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (self.type == YHTFormViewDirectionX) [self handleTheXScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.type == YHTFormViewDirectionX) [self handleTheXScroll:scrollView];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.type == YHTFormViewDirectionX) [self handleTheXScroll:scrollView];
}
-(void)tableCellDelegateScrollViewDidScroll:(UIScrollView *)scrollView
{
    self.collectionView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
    [self handleTheXScroll:scrollView];
}
-(void)handleTheXScroll:(UIScrollView *)scrollView
{
    [self.contentTableView.visibleCells enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        for (UIView *view in obj.subviews) {
            if ([view isKindOfClass:[UICollectionView class]]) {
                ((UICollectionView* ) view).contentOffset = CGPointMake(self.collectionView.contentOffset.x, 0);
                break;
            }
        }
    }];
}
-(void)handleTheLine
{
    self.topLineView.backgroundColor = self.lineColor;
    self.bottomLineView.backgroundColor = self.lineColor;
    self.rightHeaderLineView.backgroundColor = self.lineColor;
    self.bottomHeaderLineView.backgroundColor = self.lineColor;
    if (self.lineType != FormViewLineNoneBorder)
    {
        self.rightLineView.backgroundColor = self.lineColor;
        self.leftLineView.backgroundColor = self.lineColor;
    }
}
#pragma mark - Init
-(void)iniSubViews
{
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.headerWidth, self.headerHeight)];
    self.headerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.headerView];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:self.headerWidth]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.headerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:self.headerHeight]];
    UILabel *invariantLabel = [[UILabel alloc] init];
    invariantLabel.textAlignment=NSTextAlignmentCenter;
    invariantLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    invariantLabel.numberOfLines = 0;
    invariantLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.headerView addSubview:invariantLabel];
    self.invariantView = invariantLabel;
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.invariantView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.invariantView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.invariantView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.headerView attribute:NSLayoutAttributeWidth multiplier:1.0f constant:-8]];
    [self.headerView addConstraint:[NSLayoutConstraint constraintWithItem:self.invariantView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:self.headerView attribute:NSLayoutAttributeHeight multiplier:1.0f constant:-8]];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing=0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self.collectionView registerClass:[YHFormCollectionViewCell class] forCellWithReuseIdentifier:@"YHFormCollectionViewCell"];
    self.collectionView.translatesAutoresizingMaskIntoConstraints=NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.bounces = NO;
    [self addSubview:self.collectionView];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeRight multiplier:1.0f constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0]];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator=NO;
    self.tableView.showsHorizontalScrollIndicator=NO;
    self.tableView.translatesAutoresizingMaskIntoConstraints=NO;
    self.tableView.bounces=NO;
    [self addSubview:self.tableView];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.headerView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0]];
    
    if (self.type == YHTFormViewDirectionX)
    {
        self.contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.contentTableView registerClass:[YHTFormTableViewCell class] forCellReuseIdentifier:@"YHTFormTableViewCell"];
        self.contentTableView.delegate=self;
        self.contentTableView.dataSource=self;
        self.contentTableView.estimatedSectionFooterHeight=0;
        self.contentTableView.estimatedSectionHeaderHeight=0;
        self.contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.contentTableView.showsVerticalScrollIndicator=NO;
        self.contentTableView.showsHorizontalScrollIndicator=NO;
        self.contentTableView.translatesAutoresizingMaskIntoConstraints=NO;
        self.contentTableView.bounces=NO;
        self.contentTableView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.contentTableView];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentTableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.collectionView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentTableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentTableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.tableView attribute:NSLayoutAttributeRight multiplier:1.0f constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentTableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:0]];
    }
    else
    {
        UICollectionViewFlowLayout *contentFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        contentFlowLayout.minimumLineSpacing = 0;
        contentFlowLayout.minimumInteritemSpacing=0;
        contentFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.contentCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:contentFlowLayout];
        self.contentCollectionView.translatesAutoresizingMaskIntoConstraints=NO;
        self.contentCollectionView.showsHorizontalScrollIndicator = NO;
        self.contentCollectionView.showsVerticalScrollIndicator = NO;
        self.contentCollectionView.backgroundColor = [UIColor whiteColor];
        [self.contentCollectionView registerClass:[YHTFormCell class] forCellWithReuseIdentifier:@"YHTFormCell"];
        self.contentCollectionView.dataSource = self;
        self.contentCollectionView.delegate = self;
        self.contentCollectionView.bounces=NO;
        [self addSubview:self.contentCollectionView];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentCollectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.collectionView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentCollectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentCollectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.tableView attribute:NSLayoutAttributeRight multiplier:1.0f constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentCollectionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:0]];
    }
    
}
-(void)layoutSubviews
{
    _topLineView.frame = CGRectMake(0, 0, self.bounds.size.width, Line_Thickness);
    _leftLineView.frame = CGRectMake(0, 0, Line_Thickness, self.bounds.size.height);
    _bottomLineView.frame = CGRectMake(0, self.bounds.size.height - Line_Thickness, self.bounds.size.width, Line_Thickness);
    _rightLineView.frame = CGRectMake(self.bounds.size.width - Line_Thickness, 0, Line_Thickness, self.bounds.size.height);
    _rightHeaderLineView.frame = CGRectMake(self.headerView.bounds.size.width - Line_Thickness, 0, Line_Thickness, self.headerView.bounds.size.height);
    _bottomHeaderLineView.frame = CGRectMake(0, self.headerView.bounds.size.height - Line_Thickness, self.headerView.bounds.size.width, Line_Thickness);
}
-(UIView *)topLineView
{
    if (!_topLineView)
    {
        _topLineView = [self lineView];
    }
    return _topLineView;
}
-(UIView *)leftLineView
{
    if (!_leftLineView)
    {
        _leftLineView = [self lineView];
    }
    return _leftLineView;
}
-(UIView *)bottomLineView
{
    if (!_bottomLineView)
    {
        _bottomLineView = [self lineView];
    }
    return _bottomLineView;
}
-(UIView *)rightLineView
{
    if (!_rightLineView)
    {
        _rightLineView = [self lineView];
    }
    return _rightLineView;
}
-(UIView *)rightHeaderLineView
{
    if (!_rightHeaderLineView)
    {
        _rightHeaderLineView = [[UIView alloc] init];
        [self.headerView addSubview:_rightHeaderLineView];
    }
    return _rightHeaderLineView;
}
-(UIView *)bottomHeaderLineView
{
    if (!_bottomHeaderLineView)
    {
        _bottomHeaderLineView = [[UIView alloc] init];
        [self.headerView addSubview:_bottomHeaderLineView];
    }
    return _bottomHeaderLineView;
}
-(UIView *)lineView
{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = self.lineColor;
    [self addSubview:lineView];
    return lineView;
}
@end
