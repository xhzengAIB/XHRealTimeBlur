//
//  XHRealTimeBlur.h
//  XHRealTimeBlurExample
//
//  Created by 曾 宪华 on 14-9-7.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void(^DidDismissBlurViewBlcok)(void);
typedef void(^WillDismissBlurViewBlcok)(void);


static NSString * const XHRealTimeBlurKey = @"XHRealTimeBlurKey";
static NSString * const XHRealTimeDidDismissBlurViewBlcokKey = @"XHRealTimeDidDismissBlurViewBlcokKey";
static NSString * const XHRealTimeWillDismissBlurViewBlcokKey = @"XHRealTimeWillDismissBlurViewBlcokKey";

typedef NS_ENUM(NSInteger, XHBlurStyle) {
    // 垂直梯度背景从黑色到半透明的。
    XHBlurStyleBlackGradient = 0,
    // 类似UIToolbar的半透明背景
    XHBlurStyleTranslucent,
    // 黑色半透明背景
    XHBlurStyleBlackTranslucent,
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

/**
 *  是否触发点击手势，默认关闭
 */
@property (nonatomic, assign) BOOL hasTapGestureEnable;
@property (nonatomic, copy) DidDismissBlurViewBlcok didDismissBlurViewCompleted;
@property (nonatomic, copy) WillDismissBlurViewBlcok willDismissBlurViewCompleted;


- (void)showBlurViewAtView:(UIView *)currentView;

- (void)showBlurViewAtViewController:(UIViewController *)currentViewContrller;

- (void)disMiss;

@end

@interface UIView (XHRealTimeBlur)

@property (nonatomic, copy) DidDismissBlurViewBlcok didDismissBlurViewCompleted;
@property (nonatomic, copy) WillDismissBlurViewBlcok willDismissBlurViewCompleted;

- (void)showRealTimeBlurWithBlurStyle:(XHBlurStyle)blurStyle;
- (void)showRealTimeBlurWithBlurStyle:(XHBlurStyle)blurStyle hasTapGestureEnable:(BOOL)hasTapGestureEnable;
- (void)disMissRealTimeBlur;

@end

@implementation UIView (XHRealTimeBlur)

- (DidDismissBlurViewBlcok)didDismissBlurViewCompleted {
    return objc_getAssociatedObject(self, &XHRealTimeDidDismissBlurViewBlcokKey);
}

- (void)setDidDismissBlurViewCompleted:(DidDismissBlurViewBlcok)didDismissBlurViewCompleted {
    objc_setAssociatedObject(self, &XHRealTimeDidDismissBlurViewBlcokKey, didDismissBlurViewCompleted, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (WillDismissBlurViewBlcok)willDismissBlurViewCompleted {
    return objc_getAssociatedObject(self, &XHRealTimeWillDismissBlurViewBlcokKey);
}

- (void)setWillDismissBlurViewCompleted:(WillDismissBlurViewBlcok)willDismissBlurViewCompleted {
    objc_setAssociatedObject(self, &XHRealTimeWillDismissBlurViewBlcokKey, willDismissBlurViewCompleted, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (XHRealTimeBlur *)realTimeBlur {
    return objc_getAssociatedObject(self, &XHRealTimeBlurKey);
}

- (void)setRealTimeBlur:(XHRealTimeBlur *)realTimeBlur {
    objc_setAssociatedObject(self, &XHRealTimeBlurKey, realTimeBlur, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showRealTimeBlurWithBlurStyle:(XHBlurStyle)blurStyle {
    [self showRealTimeBlurWithBlurStyle:blurStyle hasTapGestureEnable:NO];
}

- (void)showRealTimeBlurWithBlurStyle:(XHBlurStyle)blurStyle hasTapGestureEnable:(BOOL)hasTapGestureEnable {
    XHRealTimeBlur *realTimeBlur = [self realTimeBlur];
    if (!realTimeBlur) {
        realTimeBlur = [[XHRealTimeBlur alloc] initWithFrame:self.bounds];
        realTimeBlur.blurStyle = blurStyle;
        [self setRealTimeBlur:realTimeBlur];
    }
    realTimeBlur.didDismissBlurViewCompleted = self.didDismissBlurViewCompleted;
    realTimeBlur.willDismissBlurViewCompleted = self.willDismissBlurViewCompleted;
    realTimeBlur.hasTapGestureEnable = hasTapGestureEnable;
    [realTimeBlur showBlurViewAtView:self];
}

- (void)disMissRealTimeBlur {
    [[self realTimeBlur] disMiss];
}

@end
