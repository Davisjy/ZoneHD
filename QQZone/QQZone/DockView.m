//
//  DockView.m
//  QQZone
//
//  Created by qingyun on 15/11/29.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#import "DockView.h"
#import "IconButtion.h"
#import "Tabbar.h"
#import "BottomMenu.h"
#import "Common.h"

@interface DockView ()


@end

@implementation DockView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpIconButton];
        [self setupTabBar];
        [self setUpBottomMenu];
    }
    return self;
}

- (void)setUpIconButton
{
    IconButtion *iconView = [[IconButtion alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
}

- (void)setupTabBar
{
    Tabbar *tabBar = [[Tabbar alloc] init]; 
    tabBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:tabBar];
    _tabBar = tabBar;
}

- (void)setUpBottomMenu
{
    BottomMenu *bottomMenu = [[BottomMenu alloc] init];
    [self addSubview:bottomMenu];
    bottomMenu.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    _bottomMenu = bottomMenu;
}

//调整子控件内部的情况
- (void)rotate:(BOOL)lanscape
{
    //1.调整底部菜单
    [self.bottomMenu rotate:lanscape];
    
    //2.设置dock自己的属性
    self.width = self.bottomMenu.width;
    
    //3.调整tabbar
    [self.tabBar rotate:lanscape];
    self.tabBar.y = self.bottomMenu.y - self.tabBar.height;
    
    //4.调整头像
    [self.iconView rotate:lanscape];
    
}

@end
