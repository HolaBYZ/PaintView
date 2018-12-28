//
//  VAGradientHelper.h
//  VAGradientHelper
//
//  Created by 栗子哇 on 2018/12/28.
//  Copyright © 2018 NineTon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define kDefaultWidth 200
#define kDefaultHeight 200

typedef NS_ENUM(NSInteger, VAGradientDirection) {
    VALinearGradientDirectionLevel,                 //AC - BD
    VALinearGradientDirectionVertical,              //AB - CD
    VALinearGradientDirectionUpwardDiagonalLine,    //A - D
    VALinearGradientDirectionDownDiagonalLine,      //C - B
};
//      A         B
//       _________
//      |         |
//      |         |
//       ---------
//      C         D

@interface VAGradientHelper : NSObject


/**
 创建渐变图层（默认宽高）
 
 @param startColor 开始颜色
 @param endColor 结束颜色
 @param directionType 渐变方向
 @return 返回image直接添加在uiimageview
 */
+ (UIImage *)getLinearGradientImage:(UIColor *)startColor and:(UIColor *)endColor directionType:(VAGradientDirection)directionType;

/**
 创建渐变图层（自定义尺寸）
 
 @param startColor 开始颜色
 @param endColor 结束颜色
 @param directionType 渐变方向
 @param size 尺寸
 @return 返回image直接添加在uiimageview
 */
+ (UIImage *)getLinearGradientImage:(UIColor *)startColor and:(UIColor *)endColor directionType:(VAGradientDirection)directionType optionSize:(CGSize)size;


/**
 创建带圆角的渐变图层（默认尺寸 / 2.）
 
 @param centerColor 中心颜色
 @param outColor 周围颜色
 @return 返回image直接添加在uiimageview
 */
+ (UIImage *)getRadialGradientImage:(UIColor *)centerColor and:(UIColor *)outColor;


/**
 创建带圆角的渐变图层（自定义尺寸 / 2.）
 
 @param centerColor 中心颜色
 @param outColor 周围颜色
 @param size 尺寸
 @return 返回image直接添加在uiimageview
 */
+ (UIImage *)getRadialGradientImage:(UIColor *)centerColor and:(UIColor *)outColor option:(CGSize)size;

/**
 渐变动画
 
 @param view 生效View
 */
+ (void)addGradientChromatoAnimation:(UIView *)view;


/**
 渐变文字动画（不需要addsubview）
 
 @param parentView 父视图
 @param label 展示文字label
 @param startColor 开始颜色
 @param endColor 结束颜色
 */
+ (void)addLinearGradientForlabelText:(UIView *)parentView label:(UILabel *)label start:(UIColor *)startColor and:(UIColor *)endColor;


/**
 创建文字随机渐变动画
 
 @param parentView 父视图
 @param label 展示文字label
 */
+ (void)addGradientChromatoAnimationForlabelText:(UIView *)parentView label:(UILabel *)label;

@end

NS_ASSUME_NONNULL_END
