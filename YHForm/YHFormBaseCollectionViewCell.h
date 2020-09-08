//
//  YHFormBaseCollectionViewCell.h
//  YHForm
//
//  Created by Bryant_YH on 2020/9/4.
//  Copyright © 2020 Bryant_YH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHFormViewType.h"
NS_ASSUME_NONNULL_BEGIN

@interface YHFormBaseCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong)UIView *topLineView;
@property (nonatomic, strong)UIView *leftLineView;
@property (nonatomic, strong)UIView *rightLineView;
@property (nonatomic, strong)UIView *bottomLineView;
@end

NS_ASSUME_NONNULL_END
