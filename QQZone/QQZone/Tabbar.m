//
//  Tabbar.m
//  QQZone
//
//  Created by qingyun on 15/11/29.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#import "Tabbar.h"
#import "Common.h"
#import "Tabbarbutton.h"
#import "UIImage+MJ.h"

@interface Tabbar ()
@property (nonatomic, strong) Tabbarbutton *selectedBtn;
@end

@implementation Tabbar

- (void)unselect
{
    self.selectedBtn.selected = NO;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化6个按钮
        [self setupButtonWithIcon:@"tab_bar_feed_icon" title:@"全部动态"];
        [self setupButtonWithIcon:@"tab_bar_passive_feed_icon" title:@"与我相关"];
        [self setupButtonWithIcon:@"tab_bar_pic_wall_icon" title:@"照片墙"];
        [self setupButtonWithIcon:@"tab_bar_e_album_icon" title:@"电子相框"];
        [self setupButtonWithIcon:@"tab_bar_friend_icon" title:@"好友"];
        [self setupButtonWithIcon:@"tab_bar_e_more_icon" title:@"更多"];
    }
    return self;
}

- (void)setupButtonWithIcon:(NSString *)icon title:(NSString *)title
{
    Tabbarbutton *button = [[Tabbarbutton alloc] init];
    // 绑定tag
    button.tag = self.subviews.count;
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    
    [button setBackgroundImage:[UIImage resizedImageWithName:@"tabbar_separate_selected_bg"] forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:button];
}

//监听按钮点击
- (void)buttonClick:(Tabbarbutton *)button
{
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectButtonFrom:self.selectedBtn.tag to:button.tag];
    }
    
    self.selectedBtn.selected = NO;
    button.selected = YES;
    self.selectedBtn = button;
}

- (void)rotate:(BOOL)lanscape
{
    int count = self.subviews.count;
    self.width = self.superview.width;
    self.height = BottomMenuButtonH * 6;
    
    for (int i = 0; i < count; i ++) {
        Tabbarbutton *btn = self.subviews[i];
        btn.width = self.width;
        btn.height = BottomMenuButtonH;
        btn.x = 0;
        btn.y = i * btn.height;
    }
}

@end
