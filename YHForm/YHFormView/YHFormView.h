//
//  YHFormView.h
//  YHForm
//
//  Created by Bryant_YH on 2020/8/25.
//  Copyright © 2020 Bryant_YH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHFormProtocol.h"
#import "YHFormViewType.h"

NS_ASSUME_NONNULL_BEGIN


///两块区域
@interface YHFormView : UIView
@property (nonatomic, assign)BOOL bounces;
///当不用自定义表头时传入源数据
@property (nonatomic, strong)NSArray<NSString *> *array;
@property (nonatomic, weak)id <YHFormViewDataSource> dataSource;
@property (nonatomic, weak)id <YHFormViewDelegate> delegate;
///线条颜色
@property (nonatomic, copy)UIColor *lineColor;
///可用于自定义表头，如果不想用默认YHFormCollectionViewCell
- (void)registerHeaderFormClass:(nullable Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;
///自定义表格内容
- (void)registerFormClass:(nullable Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;

- (void)reloadData;
- (instancetype)initWithFrame:(CGRect)frame withHeaderHeight:(CGFloat )height withLineType:(FormViewLineType )type;
@end

NS_ASSUME_NONNULL_END
