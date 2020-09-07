//
//  YHFormProtocol.h
//  YHForm
//
//  Created by Bryant_YH on 2020/8/25.
//  Copyright © 2020 Bryant_YH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHFormView;
@class YHFormBaseTableViewCell;
@class YHFormBaseCollectionViewCell;
NS_ASSUME_NONNULL_BEGIN
@protocol YHFormViewDataSource <NSObject>

///自定义表格内容
-(YHFormBaseTableViewCell *)tableView:(UITableView *)tableView withFormViewIndexPath:(NSIndexPath *)indexPath;
///表格内容的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger )section;

@optional
///表头个数
- (NSInteger )numberOfSectionsInFromView:(YHFormView *)formView;

///可用于自定义表头，从左向右排序，0,1...
- (YHFormBaseCollectionViewCell *)formView:(YHFormView *)formView withCollectionView:(UICollectionView *)collectionView viewForHeaderInIndexPath:(NSIndexPath *)indexPath;

@end

@protocol YHFormViewDelegate <NSObject>

@optional
///表头宽度，不设置默认为平均分配
- (CGFloat )formView:(YHFormView *)formView widthForHeaderInSection:(NSInteger)section;
///表内容的高度，不设置默认50
- (CGFloat )formView:(YHFormView *)formView heightInIndexPath:(NSIndexPath *)indexPath;
@end
NS_ASSUME_NONNULL_END
