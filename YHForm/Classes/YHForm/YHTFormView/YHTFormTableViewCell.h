//
//  YHTFormTableViewCell.h
//  YHForm
//
//  Created by Bryant_YH on 2020/9/3.
//  Copyright © 2020 Bryant_YH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHTFormProtocol.h"
#import "YHFormBaseTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface YHTFormTableViewCell : YHFormBaseTableViewCell
@property (nonatomic, weak)id<YHTFormTableCellDelegate>delegate;
-(void)setCellWithXCount:(NSInteger )count withHeight:(CGFloat )height withIndexPath:(NSIndexPath *)indexPath withFormView:(YHTFormView *)formView withClass:(Class )class withIdentifier:(NSString *)identifier withLineType:(FormViewLineType )type withColor:(UIColor *)lineColor;
@end

NS_ASSUME_NONNULL_END
