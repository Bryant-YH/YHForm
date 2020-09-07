//
//  YHTFormProtocol.h
//  YHForm
//
//  Created by Bryant_YH on 2020/9/3.
//  Copyright © 2020 Bryant_YH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class YHTFormView;
@class YHTIndexPath;
@class YHFormBaseTableViewCell;
@class YHFormBaseCollectionViewCell;
@protocol YHTFormViewDataSource <NSObject>

///左表头的行数
-(NSInteger)formViewOfTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger )section;
///自定义左表头
-(YHFormBaseTableViewCell *)formViewOfTableView:(UITableView *)tableView withFormViewIndexPath:(NSIndexPath *)indexPath;
///表格内容的行数 YHTFormViewDirectionY时候为行数； YHTFormViewDirectionX时候section为YSection左表头下标
-(NSInteger)formViewOfContentTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger )section;



@optional
//下两方法根据需求必实现其中一个
///自定义表格样式 YHTFormViewDirectionY
-(YHFormBaseTableViewCell *)formViewOfContentTableView:(UITableView *)tableView withFormViewIndexPath:(YHTIndexPath *)indexPath;
///自定义表格样式 YHTFormViewDirectionX
- (YHFormBaseCollectionViewCell *)formViewOfCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(YHTIndexPath *)indexPath;

///上表头个数
- (NSInteger )numberOfSectionsInFromView:(YHTFormView *)formView;

///可用于自定义上表头，从左向右排序，0,1...
- (YHFormBaseCollectionViewCell *)formView:(YHTFormView *)formView withCollectionView:(UICollectionView *)collectionView viewForHeaderInIndexPath:(NSIndexPath *)indexPath;

@end

///左表头的宽度，高度均没有做任何特殊处理。需要自己进行适配
@protocol YHTFormViewDelegate <NSObject>
///左表头的高度
- (CGFloat )formView:(YHTFormView *)formView heightForHeaderInSection:(NSInteger)ySection;
///表格内容高度
- (CGFloat)formView:(YHTFormView *)formView heightForIndexPath:(YHTIndexPath *)indexPath;
@optional
///上表头宽度，不设置默认为平均分配
- (CGFloat )formView:(YHTFormView *)formView widthForHeaderInSection:(NSInteger)xSection;

@end


///YHTFormViewDirectionY
@protocol YHTFormCellDelegate <NSObject>

- (CGFloat)cellDelegateFormView:(YHTFormView *)formView heightForIndexPath:(YHTIndexPath *)indexPath;

-(NSInteger)cellDelegateFormViewOfContentTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger )section;

-(YHFormBaseTableViewCell *)cellDelegateFormViewOfContentTableView:(UITableView *)tableView withFormViewIndexPath:(YHTIndexPath *)indexPath;
@end

///YHTFormViewDirectionX
@protocol YHTFormTableCellDelegate <NSObject>

- (CGFloat )tableCellDelegateFormView:(YHTFormView *)formView widthForHeaderInSection:(NSInteger)xSection;
- (YHFormBaseCollectionViewCell *)tableCellDelegateCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(YHTIndexPath *)indexPath;

-(void)tableCellDelegateScrollViewDidScroll:(UIScrollView *)scrollView;
@end

NS_ASSUME_NONNULL_END
