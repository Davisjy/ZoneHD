//
//  Tabbarbutton.m
//  QQZone
//
//  Created by qingyun on 15/11/29.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#import "Tabbarbutton.h"
#import "Common.h"

#define  TabbarBtnImageLanscapeRatio   0.4


@implementation Tabbarbutton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:20];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted{}

//图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if (self.width > BottomMenuButtonLanscapeW) {
        CGFloat imageW = self.width * TabbarBtnImageLanscapeRatio;
        CGFloat imageH = self.height;
        return CGRectMake(0, 0, imageW, imageH);
    } else {//竖屏
        return self.bounds;
    }
}

//文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    if (self.width > BottomMenuButtonLanscapeW) {
        CGFloat titleX = self.width * TabbarBtnImageLanscapeRatio;
        CGFloat titleW = self.width - titleX;
        CGFloat titleH = self.height;
        return CGRectMake(titleX, 0, titleW, titleH);
    }else {//竖屏
        return CGRectZero;
    }
}

@end
