//
//  XHRealTimeBlur.h
//  XHRealTimeBlurExample
//
//  Created by 曾 宪华 on 14-9-7.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

static NSString * const XHRealTimeBlurKey = @"XHRealTimeBlurKey";

typedef NS_ENUM(NSInteger, XHBlurStyle) {
    // 垂直梯度背景从黑色到半透明的。
    XHBlurStyleBlackGradient = 0,
    // 类似UIToolbar的半透明背景
    XHBlurStyleTranslucent,
    // 纯白色
    XHBlurStyleWhite
};

@interface XHRealTimeBlur : UIView

/**
 *  Default is XHBlurStyleTranslucent
 */
@property (nonatomic, assign) XHBlurStyle blurStyle;

@property (nonatomic, assign) BOOL showed;

// Default is 0.3
@property (nonatomic, assign) NSTimeInterval duration;

- (void)showBlurViewAtView:(UIView *)currentView;

- (void)showBlurViewAtViewController:(UIViewController *)currentViewContrller;

- (void)disMiss;

@end

@interface UIView (XHRealTimeBlur)

- (void)showRealTimeBlurWithBlurStyle:(XHBlurStyle)blurStyle;
- (void)disMissRealTimeBlur;

@end

@implementation UIView (XHRealTimeBlur)

- (XHRealTimeBlur *)realTimeBlur {
    return objc_getAssociatedObject(self, &XHRealTimeBlurKey);
}

- (void)setRealTimeBlur:(XHRealTimeBlur *)realTimeBlur {
    objc_setAssociatedObject(self, &XHRealTimeBlurKey, realTimeBlur, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showRealTimeBlurWithBlurStyle:(XHBlurStyle)blurStyle {
    XHRealTimeBlur *realTimeBlur = [self realTimeBlur];
    if (!realTimeBlur) {
        realTimeBlur = [[XHRealTimeBlur alloc] initWithFrame:self.bounds];
        realTimeBlur.blurStyle = blurStyle;
        [self setRealTimeBlur:realTimeBlur];
    }
    [realTimeBlur showBlurViewAtView:self];
}

- (void)disMissRealTimeBlur {
    [[self realTimeBlur] disMiss];
}

@end
