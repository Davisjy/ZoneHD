//
//  IconButtion.m
//  QQZone
//
//  Created by qingyun on 15/11/29.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#import "IconButtion.h"
#import "Common.h"


@implementation IconButtion

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setTitle:@"Davis" forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"摇一摇"] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.imageView.layer.cornerRadius = 10;
    }
    return self;
}

- (void)rotate:(BOOL)lanscape
{
    if (lanscape) {
        self.y = 60;
        self.width = self.superview.width * 0.35;
        self.height = self.width + 30;
        self.x = (self.superview.width - self.width) * 0.5;
    }else {
        self.x = 10;
        self.y = 40;
        self.width = self.superview.width - 2 * self.x;
        self.height = self.width;
    }
}

//图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if (self.width > BottomMenuButtonPortrainW) {
        CGFloat imageW = self.width;
        CGFloat imageH = imageW;
        return CGRectMake(0, 0, imageW, imageH);
    } else {//竖屏
        return self.bounds;
    }
}

//文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    if (self.width > BottomMenuButtonLanscapeW) {
        CGFloat titleY = self.width;
        CGFloat titleW = self.width;
        CGFloat titleH = self.height - self.y;
        return CGRectMake(0, titleY, titleW, titleH);
    }else {//竖屏
        return CGRectZero;
    }
}


@end
