//
//  ViewController.m
//  XHRealTimeBlurExample
//
//  Created by 曾 宪华 on 14-9-7.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import "ViewController.h"

#import "XHRealTimeBlur.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://store.apple.com"]];
    [self.webView loadRequest:request];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)TouchThere:(id)sender {
    
    self.view.willShowBlurViewcomplted = ^() {
        NSLog(@"willShow");
    };
    
    self.view.didShowBlurViewcompleted = ^(BOOL finished) {
        NSLog(@"didShow");
    };
    
    self.view.willDismissBlurViewCompleted = ^() {
        NSLog(@"willDismiss");
    };
    self.view.didDismissBlurViewCompleted = ^(BOOL finished) {
        NSLog(@"didDismiss");
    };
    [self.view showRealTimeBlurWithBlurStyle:XHBlurStyleBlackTranslucent hasTapGestureEnable:YES];
}
@end
