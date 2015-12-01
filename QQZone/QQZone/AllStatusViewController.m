//
//  AllStatusViewController.m
//  QQZone
//
//  Created by qingyun on 15/11/30.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#import "AllStatusViewController.h"
#import "SegmentControl.h"

@interface AllStatusViewController ()

@end

@implementation AllStatusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];

    //设置顶部控件
    SegmentControl *sc = [[SegmentControl alloc] init];
    sc.items = @[@"全部", @"特别关心", @"好友动态", @"认证空间"];
    sc.frame = CGRectMake(0, 0, 400, 40);
    sc.selectedIndex = 0;
//    sc.segmentWidth = 100;
    self.navigationItem.titleView = sc;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
}

- (void)dismiss{
//    [[LoginViewController alloc ]init]; 只会加载LoginView.xib  LoginViewController.xib
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *loginVC = [sb instantiateInitialViewController]; //箭头所指控制器
    self.view.window.rootViewController = loginVC;
}

@end
