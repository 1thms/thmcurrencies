//
//  THMUIUtils.m
//  Currencies
//
//  Created by Krzysztof Jężak on 28.11.2016.
//  Copyright © 2016 Krzysztof Jężak. All rights reserved.
//

#import "THMUIUtils.h"

@implementation THMUIUtils

+ (UIColor *)defaultBackgroundColor {
    return [UIColor lightGrayColor];
}

+ (UIColor *)defaultButtonFirstGradientColor {
    return [UIColor colorWithRed:255./255. green:205./255. blue:2./255. alpha:1.0];
}

+ (UIColor *)defaultButtonSecondGradientColor {
    return [UIColor colorWithRed:255./255. green:163./255. blue:2./255. alpha:1.0];
}

+ (UIColor *)defaultShadowColor {
    return [UIColor darkGrayColor];
}

+ (UIColor *)blackColor {
    return [UIColor blackColor];
}

@end
