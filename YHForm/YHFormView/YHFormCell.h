//
//  YHFormTableCell.h
//  YHForm
//
//  Created by Bryant_YH on 2020/9/1.
//  Copyright © 2020 Bryant_YH. All rights reserved.
//

#import "YHFormBaseCollectionViewCell.h"
#import "YHFormProtocol.h"
#import "YHFormViewType.h"
NS_ASSUME_NONNULL_BEGIN
@class YHFormView;
@interface YHFormCell : YHFormBaseCollectionViewCell
@property (nonatomic, weak)id<YHFormViewDelegate>delegate;
@property (nonatomic, weak)id<YHFormViewDataSource>dataSource;

-(void)setCellWithFormView:(YHFormView *)formView withIndexPath:(NSIndexPath *)indexPath withBounces:(BOOL)bounces withClass:(Class )class withIdentifier:(NSString *)identifier withLineType:(FormViewLineType )type withColor:(UIColor *)lineColor withCount:(NSInteger )count;
@end


NS_ASSUME_NONNULL_END
