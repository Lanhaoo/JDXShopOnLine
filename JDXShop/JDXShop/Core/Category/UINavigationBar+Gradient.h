//
//  UINavigationBar+Gradient.h
//  Client_NBS
//
//  Created by 上海百彻 on 2018/2/11.
//  Copyright © 2018年 上海百彻. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Gradient)
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor;
- (void)lt_setElementsAlpha:(CGFloat)alpha;
- (void)lt_setTranslationY:(CGFloat)translationY;
- (void)lt_reset;
@end
