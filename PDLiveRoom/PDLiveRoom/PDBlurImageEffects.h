//
//  PDBlurImageEffects.h
//  PDBlurImage
//
//  Created by 彭懂 on 16/9/5.
//  Copyright © 2016年 彭懂. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PDBlurImageEffects : NSObject

/**
 *  不同效果的图片输出
 */
+ (UIImage *)pd_imageEffectLightFromImage:(UIImage *)inputImage;
+ (UIImage *)pd_imageEffectExtraLightFromImage:(UIImage *)inputImage;
+ (UIImage *)pd_imageEffectDarkFromImage:(UIImage *)inputImage;
+ (UIImage *)pd_imageEffectTintFromImage:(UIImage *)inputImage andEffectColor:(UIColor *)tintColor;

@end
