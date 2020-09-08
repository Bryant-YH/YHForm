//
//  YHTFormView.h
//  YHForm
//
//  Created by Bryant_YH on 2020/9/2.
//  Copyright © 2020 Bryant_YH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHTFormProtocol.h"
#import "YHFormViewType.h"
NS_ASSUME_NONNULL_BEGIN


///三块区域
@interface YHTFormView : UIView
///左上角固定的标题，不设置默认为一个Label。(无需设置其frame)可直接(UILabel *)
@property (nonatomic, strong)UIView *invariantView;
///默认invariantView，标题
@property (nonatomic, copy)NSString *invariantTitle;
///当不用自定义表头时传入源数据
@property (nonatomic, strong)NSArray<NSString *> *array;
///线条颜色
@property (nonatomic, copy)UIColor *lineColor;
@property (nonatomic, weak)id <YHTFormViewDataSource> dataSource;
@property (nonatomic, weak)id <YHTFormViewDelegate> delegate;
//@property (nonatomic, assign)BOOL bounces;
-(instancetype)initWithFrame:(CGRect)frame withHeaderHeight:(CGFloat )height withTitleWidth:(CGFloat )width withType:(YHTFormViewDirectionType )type withLineType:(FormViewLineType )lineType;

///可用于自定义上表头，如果不想用默认YHFormCollectionViewCell
- (void)registerHeaderFormClass:(nullable Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;
///可用于自定义左表头，如果不想用默认YHFormCollectionViewCell
- (void)registerLeftHeaderFormClass:(nullable Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;
///自定义表格内容  YHTFormViewDirectionX时候collectionVIewCell, YHTFormViewDirectionY为tableviewCell
- (void)registerFormClass:(nullable Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;
-(void)reloadData;
@end

NS_ASSUME_NONNULL_END
