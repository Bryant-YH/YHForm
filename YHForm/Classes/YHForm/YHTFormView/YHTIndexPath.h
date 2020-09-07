//
//  YHTIndexPath.h
//  YHForm
//
//  Created by Bryant_YH on 2020/9/3.
//  Copyright © 2020 Bryant_YH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHTIndexPath : NSIndexPath
@property (nonatomic, readonly) NSInteger form;
@property (nonatomic, readonly) NSInteger xSection;
@property (nonatomic, readonly) NSInteger ySection;

+(instancetype)indexPathForXSection:(NSInteger)xSection withYSection:(NSInteger )ySection withForm:(NSInteger )form;
+(instancetype)indexPathForXSection:(NSInteger)xSection withYSection:(NSInteger )ySection;
@end

NS_ASSUME_NONNULL_END
