//
//  MainViewController.m
//  QQZone
//
//  Created by qingyun on 15/11/29.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#import "MainViewController.h"
#import "DockView.h"
#import "Common.h"
#import "Tabbar.h"
#import "IconButtion.h"
#import "BottomMenu.h"
#import "AllStatusViewController.h"
#import "NavViewController.h"
#import "ComposeViewController.h"

#define kRandomColor     [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1.0]
#define kConentViewW  600

@interface MainViewController ()<TabbarDelegate, BottomMenuDelegate>

@property (nonatomic, strong) DockView *dock;
//右边内容子控制器的内容
@property (nonatomic, strong) UIView *contentView;
//@property (nonatomic, weak) UIViewController *currentChildVC;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //1.初始化Dock
    [self setUpDock];
    
    //2.初始化contentView
    [self setupContentView];
    
    //3.初始化控制器
    [self setupChildViewControllers];
    
    //4.默认点击头像
    [self iconClick];
    
}
//初始化contentView
- (void)setupContentView
{
    //1.创建
    UIView *contentView = [[UIView alloc] init];
    contentView.width = kConentViewW;
    contentView.height = self.view.height;
    contentView.x = self.dock.width;
    contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:contentView];
    self.contentView = contentView;
    
    //2.pan手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragContentView:)];
    [self.contentView addGestureRecognizer:pan];
}

//触发了拖拽手势(begin-->ing-->end)
- (void)dragContentView:(UIPanGestureRecognizer *)pan
{
    //取消了pan
    if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {
        //恢复原来位置
        [UIView animateWithDuration:0.5 animations:^{
            pan.view.transform = CGAffineTransformIdentity;
        }];
    } else{
        CGPoint translationPoint = [pan translationInView:pan.view];
    //    NSLog(@"%@", NSStringFromCGPoint(translationPoint));
        //0.5越小，弹簧效果越小
        pan.view.transform = CGAffineTransformMakeTranslation(translationPoint.x * 0.5, 0);
    }
}

//初始化自控制器
- (void)setupChildViewControllers
{
    AllStatusViewController *allStatusVC = [[AllStatusViewController alloc] init];
    [self setupOneViewController:allStatusVC];
    //只要调用addChildViewController方法，就能将自控制器添加到childViewControllers数组中
//    self.childViewControllers
    UIViewController *vc1 = [[UIViewController alloc] init];
    [self setupOneViewController:vc1];
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    [self setupOneViewController:vc2];
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    [self setupOneViewController:vc3];
    
    UIViewController *vc4 = [[UIViewController alloc] init];
    [self setupOneViewController:vc4];
    
    UIViewController *vc5 = [[UIViewController alloc] init];
    [self setupOneViewController:vc5];
    
    UIViewController *home = [[UIViewController alloc] init];
    home.view.backgroundColor = [UIColor whiteColor];
    [self setupOneViewController:home];
}

- (void)setupOneViewController:(UIViewController *)vc
{
    NavViewController *nav = [[NavViewController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

- (void)setUpDock
{
    self.view.backgroundColor = [UIColor colorWithRed:55.0/255.0 green:55.0/255.0 blue:55.0/255.0 alpha:1.0];
    DockView *dock = [[DockView alloc] init];
    self.dock = dock;
    CGFloat dockH = self.view.height;
    //自动伸缩属性
    dock.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    dock.frame = CGRectMake(0, 0, 0, dockH);
    [self.view addSubview:dock];
    
    //判断当前横屏还是竖屏来确定dockView的width
    //    [self willRotateToInterfaceOrientation:self.interfaceOrientation duration:0.0];
    
    //根据当前的屏幕方向设置dock的属性
    [self.dock rotate:UIInterfaceOrientationIsLandscape(self.interfaceOrientation)];
    
    //设置代理
    self.dock.tabBar.delegate = self;
    
    //监听头像点击
    [self.dock.iconView addTarget:self action:@selector(iconClick) forControlEvents:UIControlEventTouchUpInside];
    
    //
    self.dock.bottomMenu.delegate = self;
}

//头像点击事件
- (void)iconClick
{
    int count = self.childViewControllers.count;
    
    // 切换主页控制器(最后一个自控制器)
    int index = count - 1;
    
    //获得当前正在显示控制器的索引
    int from = 0;
    for (int i = 0; i < count; i ++) {
        UIViewController *VC = self.childViewControllers[i];
        if (VC.view.superview) {
            from = i;
            break;
        }
    }
    // 切换控制器
    [self tabBar:nil didSelectButtonFrom:from to:index];
    
    // 让tabbar里面所有按钮取消选中
    [self.dock.tabBar unselect];
}

//当屏幕即将旋转的时候   toInterfaceOrientation旋转完毕后的最终方向  duration旋转所耗时间
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration animations:^{
        [self.dock rotate:UIInterfaceOrientationIsLandscape(toInterfaceOrientation)];
        self.contentView.x = self.dock.width;

    }];
    
}

#pragma mark - bottomMenuDelegate
- (void)bottomMenu:(BottomMenu *)bottomMenu didClickBottom:(BottomMenuType)bottomType
{
    switch (bottomType) {
        case BottomMenuTypeMood:
        case BottomMenuTypeBlog:
        case BottomMenuTypePhoto:{
            ComposeViewController *compose = [[ComposeViewController alloc] init];
            NavViewController *nav = [[NavViewController alloc] initWithRootViewController:compose];
            nav.modalPresentationStyle = UIModalPresentationFormSheet;
            [self presentViewController:nav animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - TabbarDelegate
- (void)tabBar:(Tabbar *)tabBar didSelectButtonFrom:(int)from to:(int)to
{
    //1.添加新控制器view
    UIViewController *newVC = self.childViewControllers[to];
    
    //    [self.contentView addSubview:newVC.view];
    if (newVC.view.superview) return;
    newVC.view.frame = self.contentView.bounds;
    
    UIViewController *rootVC = [newVC.childViewControllers firstObject];
    rootVC.view.backgroundColor = kRandomColor;
    //2.移除之前的控制器
    UIViewController *oldVC ;
    UIViewController *lastVC = [self.childViewControllers lastObject];
    if (lastVC.view.superview) {
        oldVC = lastVC;
    }else {
        oldVC = self.childViewControllers[from];
    }
    
    
    //3.转场动画
    if (oldVC.view.superview) { //正在显示旧控制器
        [oldVC.view removeFromSuperview];
        [self.contentView addSubview:newVC.view];
        
        CATransition *transition = [CATransition animation];
        transition.type = @"rippleEffect";
        transition.duration = 1.0;
        [self.contentView.layer addAnimation:transition forKey:nil];
        
        //[UIView transitionFromView:oldVC.view toView:newVC.view duration:1.0 options:UIViewAnimationOptionTransitionCurlUp completion:nil];
    }else {  //没有显示任何控制器
        [self.contentView addSubview:newVC.view];
    }
    
    
    //在iPhone/iPad，控制器view的autoresizingMask，默认是伸缩宽度和高度
//    newVC.view.autoresizingMask = UIViewAutoresizingNone;
    
    //3.转场动画 (不需要主动调用移除老的添加新的)
//    if (self.currentChildVC) {
//        [UIView transitionFromView:oldVC.view toView:newVC.view duration:1.0 options:UIViewAnimationOptionTransitionCurlDown completion:nil];
//    }else {
//        [self.view addSubview:newVC.view];
//    }
    
//    self.currentChildVC = newVC;
}



//- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
//{
//    
//}

@end
