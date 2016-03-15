//
//  InputTextViewController.m
//  XHRealTimeBlurExample
//
//  Created by 曾 宪华 on 14-9-8.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import "InputTextViewController.h"

#import "XHRealTimeBlur.h"

@interface InputTextViewController ()

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) XHRealTimeBlur *realTimeBlur;

@end

@implementation InputTextViewController

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 60)];
        _textView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.950];
        _textView.text = @"Click Here Input";
        _textView.font = [UIFont systemFontOfSize:25];
    }
    return _textView;
}

- (XHRealTimeBlur *)realTimeBlur {
    if (!_realTimeBlur) {
        _realTimeBlur = [[XHRealTimeBlur alloc] initWithFrame:self.view.bounds];
        _realTimeBlur.alpha = 0.0;
        [self.view addSubview:_realTimeBlur];
    }
    return _realTimeBlur;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Input";
    
    self.textField.inputAccessoryView = self.textView;
    
    __weak InputTextViewController *weakSelf = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        if (weakSelf) {
            __strong InputTextViewController *strongSelf = weakSelf;
            [strongSelf.view disMissRealTimeBlur];
        }
    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        if (weakSelf) {
            __strong InputTextViewController *strongSelf = weakSelf;
            [strongSelf.view showRealTimeBlurWithBlurStyle:XHBlurStyleTranslucent];
        }
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showInputTextView:(id)sender {
    [self.textField becomeFirstResponder];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.textView resignFirstResponder];
    [self.textField resignFirstResponder];
}

@end
