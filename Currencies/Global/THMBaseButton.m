//
//  THMBaseButton.m
//  Currencies
//
//  Created by Krzysztof Jężak on 28.11.2016.
//  Copyright © 2016 Krzysztof Jężak. All rights reserved.
//

#import "THMBaseButton.h"
#import "THMUIUtils.h"

@interface THMBaseButton ()

@property(nonatomic) CAGradientLayer *gradientLayer;

@end

@implementation THMBaseButton

- (void)awakeFromNib {
    [super awakeFromNib];
    self.gradientLayer = [CAGradientLayer layer];
    
    self.gradientLayer.colors = [NSArray
                                 arrayWithObjects:(id)[THMUIUtils defaultButtonFirstGradientColor].CGColor,
                                 (id)[THMUIUtils defaultButtonSecondGradientColor].CGColor,
                                 nil];
    
    self.gradientLayer.locations =
    [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0f],
     [NSNumber numberWithFloat:0.75f], nil];
    [self.gradientLayer setStartPoint:CGPointMake(0.0, 0.5)];
    [self.gradientLayer setEndPoint:CGPointMake(1.0, 0.5)];
    self.gradientLayer.cornerRadius = self.frame.size.height / 2.;
    
    [self.layer setShadowColor:[THMUIUtils defaultShadowColor].CGColor];
    
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16.];
    [self setTitleColor:[THMUIUtils blackColor] forState:UIControlStateNormal];
    [self setTitleColor:[THMUIUtils defaultBackgroundColor] forState:UIControlStateDisabled];
    
    [self.layer setShadowOpacity:0.5];
    [self.layer setShadowRadius:5.];
    [self.layer setShadowOffset:CGSizeMake(0., 5.0)];
    self.layer.cornerRadius = self.frame.size.height / 2.;
    
    self.contentEdgeInsets = UIEdgeInsetsMake(8., 16., 8., 16.);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!self.gradientLayer.superlayer) {
        self.gradientLayer.frame = self.bounds;
        [self.layer insertSublayer:self.gradientLayer atIndex:0];
    }
    
}

@end
