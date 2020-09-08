//
//  YHTFormTableViewCell.m
//  YHForm
//
//  Created by Bryant_YH on 2020/9/3.
//  Copyright © 2020 Bryant_YH. All rights reserved.
//

#import "YHTFormTableViewCell.h"
#import "YHTIndexPath.h"
#import "YHFormBaseCollectionViewCell.h"
@interface YHTFormTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>
@property (nonatomic, assign)NSInteger count;
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, copy)NSIndexPath *indexPath;
@property (nonatomic, strong)YHTFormView *formView;
@property (nonatomic, copy)UIColor *lineColor;
@property (nonatomic)FormViewLineType type;
@end
@implementation YHTFormTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubViews];
    }
    return self;
}
-(void)setCellWithXCount:(NSInteger )count withHeight:(CGFloat )height withIndexPath:(NSIndexPath *)indexPath withFormView:(YHTFormView *)formView withClass:(Class )class withIdentifier:(NSString *)identifier withLineType:(FormViewLineType )type withColor:(UIColor *)lineColor
{
    self.type=type;
    self.lineColor=lineColor;
    self.formView = formView;
    self.count = count;
    self.height = height;
    self.indexPath = indexPath;
    if (self.type != FormViewLineNone) {
        self.bottomLineView.backgroundColor = self.lineColor;
    }
    [self.collectionView registerClass:class forCellWithReuseIdentifier:identifier];
    [self.collectionView reloadData];
}
#pragma mark - 
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = self.bounds.size.width / self.count;
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableCellDelegateFormView:widthForHeaderInSection:)])  {
        width = [self.delegate tableCellDelegateFormView:self.formView widthForHeaderInSection:indexPath.row];
    }
    return CGSizeMake(width, self.height);
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YHTIndexPath *cellIndexPath = [YHTIndexPath indexPathForXSection:indexPath.row withYSection:self.indexPath.section withForm:indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableCellDelegateCollectionView:cellForItemAtIndexPath:)])
    {
        YHFormBaseCollectionViewCell *cell = [self.delegate tableCellDelegateCollectionView:collectionView cellForItemAtIndexPath:cellIndexPath];
        if (self.type!=FormViewLineNone)
        {
            cell.leftLineView.backgroundColor = self.lineColor;
            cell.leftLineView.hidden=indexPath.row==0;
        }
        return cell;
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableCellDelegateScrollViewDidScroll:)])
    {
        [self.delegate tableCellDelegateScrollViewDidScroll:scrollView];
    }
}
#pragma mark - Init
-(void)initSubViews
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing=0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.translatesAutoresizingMaskIntoConstraints=NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.bounces=NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self addSubview:self.collectionView];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0f constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
