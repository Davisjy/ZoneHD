//
//  LoginViewController.m
//  QQZone
//
//  Created by qingyun on 15/11/29.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#import "LoginViewController.h"
#import "UIImage+MJ.h"
#import "MainViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;

//文本框
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
//整个登录view
@property (weak, nonatomic) IBOutlet UIView *loginView;
//登录按钮
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIButton *rememberPwdBtn;
@property (weak, nonatomic) IBOutlet UIButton *autoLogin;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.设置按钮背景
    [self.loginBtn setBackgroundImage:[UIImage resizedImageWithName:@"login_button_normal"] forState:UIControlStateNormal];
    
    [self.loginBtn setBackgroundImage:[UIImage resizedImageWithName:@"login_button_pressed"] forState:UIControlStateHighlighted];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

//登录
- (IBAction)login:(UIButton *)sender {
    //1.帐号验证
    NSString *userName = self.userName.text;
    if (userName.length == 0) {
        [self showError:@"请输入帐号"];
        return;
    }
    //2.验证密码
    NSString *pwd = self.password.text;
    if (pwd.length == 0) {
        [self showError:@"请输入密码"];
        return;
    }
    //3.发送请求
    self.view.userInteractionEnabled = NO;
    [self.loadingView startAnimating];
    
    CGFloat delay = 2.0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //4.请求完毕
        [self.loadingView stopAnimating];
        self.view.userInteractionEnabled = YES;
        
        //5.帐号密码为123才是对的
        if (![userName isEqualToString:@"123"]) {
            [self showError:@"请输入正确帐号"];
            return ;
        }
        if (![pwd isEqualToString:@"123"]) {
            [self showError:@"请输入正确密码"];
            return ;
        }
        
        //6.登录成功 跳转
        self.view.window.rootViewController = [[MainViewController alloc] init];
    });
}

//点击checkBox
- (IBAction)checkBoxClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if ([sender isEqual:self.rememberPwdBtn] && !sender.selected) {//取消了“记住密码”
        self.autoLogin.selected = NO;
    }else if ([sender isEqual:self.autoLogin] && sender.selected){
        //勾选了自动登录
        self.rememberPwdBtn.selected = YES;
    }
}

//用来显示错误提醒信息
- (void)showError:(NSString *)errorMsg
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"登录失败" message:errorMsg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:okAction];
    [self presentViewController:alertVC animated:YES completion:nil];
    
    //抖动
    CAKeyframeAnimation *shakeAnim = [CAKeyframeAnimation animation];
    shakeAnim.keyPath = @"transform.translation.x";
    CGFloat delta = 10;
    shakeAnim.values = @[@0, @(-delta), @(delta), @0];
    shakeAnim.repeatCount = 2;
    shakeAnim.duration = 0.15;
    [self.loginView.layer addAnimation:shakeAnim forKey:nil];
}



#pragma mark - textFiled delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:self.userName]) {//帐号
        [self.password becomeFirstResponder];
    }else{
        [self login:nil];
    }
    return YES;
}

@end
