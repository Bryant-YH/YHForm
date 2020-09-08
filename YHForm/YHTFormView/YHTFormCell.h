//
//  YHTFormCell.h
//  YHForm
//
//  Created by Bryant_YH on 2020/9/3.
//  Copyright © 2020 Bryant_YH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHTFormProtocol.h"
#import "YHFormBaseCollectionViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface YHTFormCell : YHFormBaseCollectionViewCell
@property (nonatomic, weak)id <YHTFormCellDelegate> delegate;
-(void)setCellWithFormView:(YHTFormView *)formView withIndexPath:(NSIndexPath *)indexPath withClass:(Class )class withIdentifier:(NSString *)identifier withLineType:(FormViewLineType )type withColor:(UIColor *)lineColor;
@end

NS_ASSUME_NONNULL_END
