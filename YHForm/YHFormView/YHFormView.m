//
//  YHFormView.m
//  YHForm
//
//  Created by Bryant_YH on 2020/8/25.
//  Copyright © 2020 Bryant_YH. All rights reserved.
//


#import "YHFormView.h"
#import "YHFormCell.h"
#import "YHFormCollectionViewCell.h"
@interface YHFormView () <UICollectionViewDelegate, UICollectionViewDataSource, YHFormViewDelegate, YHFormViewDataSource, UIScrollViewDelegate>
@property (nonatomic, assign)CGFloat header_height;
@property (nonatomic, assign)CGFloat content_height;

@property (nonatomic, strong)UICollectionView *collectionView;//表头
@property (nonatomic, strong)UICollectionView *contentCollectionView;//表格内容
@property (nonatomic)Class cellClass;
@property (nonatomic, copy)NSString *cellIdentifier;
@property (nonatomic)FormViewLineType type;
@end
@implementation YHFormView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        self.bounces=YES;
        self.lineColor = [UIColor lightGrayColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDeviceOrientationDidChange)  name:UIDeviceOrientationDidChangeNotification object:nil];
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        self.header_height = self.header_height>0 ? self.header_height : 50;
        self.content_height = self.bounds.size.height - self.header_height;
        self.backgroundColor = [UIColor whiteColor];
        [self initSubViews];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame withHeaderHeight:(CGFloat )height withLineType:(FormViewLineType )type
{
    self.type=type;
    self.header_height = height;
    return [self initWithFrame:frame];
}
#pragma mark - Setter
-(void)setArray:(NSArray<NSString *> *)array
{
    _array = array;
    [self.collectionView reloadData];
}
-(void)setBounces:(BOOL)bounces
{
    _bounces = bounces;
    self.collectionView.bounces=self.bounces;
    self.contentCollectionView.bounces=self.bounces;
    [self.contentCollectionView reloadData];
}
-(void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    [self handleTheLine];
    if (self.type!= FormViewLineNone) {
        [self reloadData];
    }
}
#pragma mark - Interactive
 - (void)onDeviceOrientationDidChange
{
    [self.collectionView reloadData];
}
- (CGFloat )formView:(YHFormView *)formView heightInIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 50;
    if (self.delegate && [self.delegate respondsToSelector:@selector(formView:heightInIndexPath:)])
    {
        height = [self.delegate formView:self heightInIndexPath:indexPath];
    }
    return height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger )section
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)])
    {
        return [self.dataSource tableView:tableView numberOfRowsInSection:section];
    }
    return 0;
}
-(YHFormBaseTableViewCell *)tableView:(UITableView *)tableView withFormViewIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(tableView:withFormViewIndexPath:)])
    {
        return [self.dataSource tableView:tableView withFormViewIndexPath:indexPath];
    }
    return nil;
}
#pragma mark -
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = self.bounds.size.width / self.array.count;
    if (self.delegate && [self.delegate respondsToSelector:@selector(formView:widthForHeaderInSection:)])  {
        width = [self.delegate formView:self widthForHeaderInSection:indexPath.section];
    }
    else if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfSectionsInFromView:)]){
            width = width / [self.dataSource numberOfSectionsInFromView:self];
    }
    return CGSizeMake(width, [collectionView isEqual:self.collectionView]?self.header_height:self.content_height);
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfSectionsInFromView:)]) ? [self.dataSource numberOfSectionsInFromView:self] : self.array.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger count =  (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfSectionsInFromView:)]) ? [self.dataSource numberOfSectionsInFromView:self] : self.array.count;
    if ([collectionView isEqual:self.collectionView])
    {
        YHFormBaseCollectionViewCell *cell =(self.dataSource && [self.dataSource respondsToSelector:@selector(formView:withCollectionView:viewForHeaderInIndexPath:)])? [self.dataSource formView:self withCollectionView:collectionView viewForHeaderInIndexPath:indexPath] : [collectionView dequeueReusableCellWithReuseIdentifier:@"YHFormCollectionViewCell" forIndexPath:indexPath];
        if (self.type!=FormViewLineNone)
        {
            cell.topLineView.backgroundColor = self.lineColor;
            cell.bottomLineView.backgroundColor = self.lineColor;
            cell.rightLineView.backgroundColor = self.lineColor;
            cell.leftLineView.backgroundColor = self.lineColor;
            cell.leftLineView.hidden = (self.type== FormViewLineNoneBorder)?indexPath.row==0 : NO;
            cell.rightLineView.hidden = (self.type== FormViewLineNoneBorder)? (indexPath.row>=0 && indexPath.row<=count-1): (indexPath.row>=0 && indexPath.row<count-1);
        }
        if ([cell isKindOfClass:[YHFormCollectionViewCell class]])
        {
            [(YHFormCollectionViewCell *)cell setCellWithText:self.array[indexPath.row]];
        }
        return cell;
    }
    YHFormCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YHFormCell" forIndexPath:indexPath];
    [cell setCellWithFormView:self withIndexPath:indexPath withBounces:self.bounces withClass:self.cellClass withIdentifier:self.cellIdentifier withLineType:self.type withColor:self.lineColor withCount:count];
    cell.delegate=self;
    cell.dataSource=self;
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isEqual:self.collectionView])
    {
        self.contentCollectionView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
    }
    else if ([scrollView isEqual:self.contentCollectionView])
    {
        self.collectionView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
    }
}
#pragma mark - Handle
- (void)registerHeaderFormClass:(nullable Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier
{
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
}
- (void)registerFormClass:(nullable Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier
{
    self.cellClass = cellClass;
    self.cellIdentifier = identifier;
    [self.contentCollectionView reloadData];
}
- (void)reloadData
{
    [self.collectionView reloadData];
    [self.contentCollectionView reloadData];
}
-(void)handleTheLine
{
    if (self.type == FormViewLineNone)   return;
    if (self.type == FormViewLineALL)
    {
        self.collectionView.layer.masksToBounds=YES;
        self.collectionView.layer.borderColor = self.lineColor.CGColor;
        self.collectionView.layer.borderWidth = Line_Thickness;
        self.contentCollectionView.layer.masksToBounds=YES;
        self.contentCollectionView.layer.borderColor = self.lineColor.CGColor;
        self.contentCollectionView.layer.borderWidth = Line_Thickness;
    }
}
#pragma mark - Init
-(void)initSubViews
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing=0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.header_height) collectionViewLayout:flowLayout];
    self.collectionView.translatesAutoresizingMaskIntoConstraints=NO;
    [self.collectionView registerClass:[YHFormCollectionViewCell class] forCellWithReuseIdentifier:@"YHFormCollectionViewCell"];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self addSubview:self.collectionView];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:.0f constant:self.header_height]];

    UICollectionViewFlowLayout *contentFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    contentFlowLayout.minimumLineSpacing = 0;
    contentFlowLayout.minimumInteritemSpacing=0;
    contentFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.contentCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), self.bounds.size.width, self.content_height) collectionViewLayout:contentFlowLayout];
    self.contentCollectionView.translatesAutoresizingMaskIntoConstraints=NO;
    self.contentCollectionView.showsHorizontalScrollIndicator = NO;
    self.contentCollectionView.showsVerticalScrollIndicator = NO;
    self.contentCollectionView.backgroundColor = [UIColor whiteColor];
    self.contentCollectionView.dataSource = self;
    self.contentCollectionView.delegate = self;
    [self.contentCollectionView registerClass:[YHFormCell class] forCellWithReuseIdentifier:@"YHFormCell"];
    [self addSubview:self.contentCollectionView];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentCollectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentCollectionView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentCollectionView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.contentCollectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.collectionView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0]];
}

@end
