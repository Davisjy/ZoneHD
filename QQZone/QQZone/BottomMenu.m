//
//  BottiomMenu.m
//  QQZone
//
//  Created by qingyun on 15/11/29.
//  Copyright © 2015年 qingyun. All rights reserved.
//  Dock底部的菜单

#import "BottomMenu.h"
#import "Common.h"
#import "UIImage+MJ.h"

@implementation BottomMenu

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //初始化三个按钮
        [self setupButtonWithIcon:@"tabbar_mood" tag:BottomMenuTypeMood];
        [self setupButtonWithIcon:@"tabbar_photo" tag:BottomMenuTypePhoto];
        [self setupButtonWithIcon:@"tabbar_blog" tag:BottomMenuTypeBlog];
    }
    return self;
}

- (void)setupButtonWithIcon:(NSString *)icon tag:(BottomMenuType)tag;
{
    UIButton *btn = [[UIButton alloc] init];
    btn.tag = tag;
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage resizedImageWithName:@"tabbar_separate_selected_bg"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

- (void)btnClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(bottomMenu:didClickBottom:)]) {
        [self.delegate bottomMenu:self didClickBottom:sender.tag];
    }
}

- (void)rotate:(BOOL)lanscape
{
    int count = self.subviews.count;
    //可以减少三目运算
    if (lanscape) {
        self.width = (BottomMenuButtonLanscapeW * count);
        self.height = BottomMenuButtonH;
        
        for (int i = 0; i < count;  i++ ) {
            UIButton *btn = self.subviews[i];
            btn.x = i * BottomMenuButtonLanscapeW;
            btn.y = 0;
            btn.width = BottomMenuButtonLanscapeW;
            btn.height = BottomMenuButtonH;
        }
    }else {
        self.width = BottomMenuButtonPortrainW;
        self.height = (BottomMenuButtonH * count);
        
        for (int i = 0; i < count;  i++ ) {
            UIButton *btn = self.subviews[i];
            btn.x = 0;
            btn.y = i * BottomMenuButtonH;
            btn.width = BottomMenuButtonPortrainW;
            btn.height = BottomMenuButtonH;
        }
    }
    
    //self.width = lanscape ? (BottomMenuButtonLanscapeW * 3) : BottomMenuButtonPortrainW ;
    //self.height = lanscape ? BottomMenuButtonH : (BottomMenuButtonH * 3);
    self.y = self.superview.height - self.height;
}

@end
