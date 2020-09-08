//
//  YHFormViewType.h
//  YHForm
//
//  Created by Bryant_YH on 2020/9/4.
//  Copyright © 2020 Bryant_YH. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Line_Thickness 1.0f
///线条类型
typedef enum : NSUInteger {
    FormViewLineNone,//无线条
    FormViewLineNoneBorder,//无边框线条
    FormViewLineALL//全都有线条
} FormViewLineType;
///三块区域 方向
typedef enum : NSUInteger {
    YHTFormViewDirectionX,
    YHTFormViewDirectionY
} YHTFormViewDirectionType;

