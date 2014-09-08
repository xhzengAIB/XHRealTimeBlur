//
//  XHRealTimeBlur.m
//  XHRealTimeBlurExample
//
//  Created by 曾 宪华 on 14-9-7.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import "XHRealTimeBlur.h"

@interface XHGradientView : UIView

@end

@implementation XHGradientView

+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        CAGradientLayer *gradientLayer = (CAGradientLayer *)self.layer;
        gradientLayer.colors = @[
                                 (id)[[UIColor colorWithWhite:0 alpha:1] CGColor],
                                 (id)[[UIColor colorWithWhite:0 alpha:0.5] CGColor],
                                 ];
    }
    return self;
}

@end

@interface XHRealTimeBlur ()

@property (nonatomic, strong) XHGradientView *gradientBackgroundView;
@property (nonatomic, strong) UIToolbar *blurBackgroundView;
@property (nonatomic, strong) UIView *whiteBackgroundView;

@end

@implementation XHRealTimeBlur

- (void)showBlurViewAtView:(UIView *)currentView {
    [self showAnimationAtContainerView:currentView];
}

- (void)showBlurViewAtViewController:(UIViewController *)currentViewContrller {
    [self showAnimationAtContainerView:currentViewContrller.view];
}

- (void)disMiss {
    [self hiddenAnimation];
}

#pragma mark - Private

- (void)showAnimationAtContainerView:(UIView *)containerView {
    if (self.showed) {
        [self disMiss];
        return;
    }
    self.alpha = 0.0;
    [containerView addSubview:self];
    [UIView animateWithDuration:self.duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        self.showed = YES;
    }];
}

- (void)hiddenAnimation {
    [UIView animateWithDuration:self.duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.showed = NO;
        [self removeFromSuperview];
    }];
}

#pragma mark - Propertys

- (XHGradientView *)gradientBackgroundView {
    if (!_gradientBackgroundView) {
        _gradientBackgroundView = [[XHGradientView alloc] initWithFrame:self.bounds];
    }
    return _gradientBackgroundView;
}

- (UIToolbar *)blurBackgroundView {
    if (!_blurBackgroundView) {
        _blurBackgroundView = [[UIToolbar alloc] initWithFrame:self.bounds];
        [_blurBackgroundView setBarStyle:UIBarStyleBlackTranslucent];
    }
    return _blurBackgroundView;
}

- (UIView *)whiteBackgroundView {
    if (!_whiteBackgroundView) {
        _whiteBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _whiteBackgroundView.backgroundColor = [UIColor clearColor];
        _whiteBackgroundView.tintColor = [UIColor colorWithWhite:0.2 alpha:1.0];
    }
    return _whiteBackgroundView;
}

- (UIView *)backgroundView {
    switch (self.blurStyle) {
        case XHBlurStyleBlackGradient:
            return self.gradientBackgroundView;
            break;
        case XHBlurStyleTranslucent:
            return self.blurBackgroundView;
            break;
        case XHBlurStyleWhite:
            return self.whiteBackgroundView;
            break;
        default:
            break;
    }
}

#pragma mark - Life Cycle

- (void)setup {
    self.duration = 0.3;
    self.blurStyle = XHBlurStyleTranslucent;
    self.backgroundColor = [UIColor clearColor];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        [self addSubview:[self backgroundView]];
    }
}

@end
