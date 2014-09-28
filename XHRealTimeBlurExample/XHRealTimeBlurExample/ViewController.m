//
//  ViewController.m
//  XHRealTimeBlurExample
//
//  Created by 曾 宪华 on 14-9-7.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
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
    self.view.willDismissBlurViewCompleted = ^() {
        NSLog(@"willDismiss");
    };
    self.view.didDismissBlurViewCompleted = ^() {
        NSLog(@"didDismiss");
    };
    [self.view showRealTimeBlurWithBlurStyle:XHBlurStyleBlackTranslucent hasTapGestureEnable:YES];
}
@end
