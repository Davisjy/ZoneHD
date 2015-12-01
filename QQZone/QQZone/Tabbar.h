//
//  Tabbar.h
//  QQZone
//
//  Created by qingyun on 15/11/29.
//  Copyright © 2015年 qingyun. All rights reserved.
//  Dock中间的选项卡

#import <UIKit/UIKit.h>

@class Tabbar;
@protocol TabbarDelegate <NSObject>

@optional
- (void)tabBar:(Tabbar *)tabBar didSelectButtonFrom:(int)from to:(int)to;

@end

@interface Tabbar : UIView
//旋转，是否为横屏
- (void)rotate:(BOOL)lanscape;
@property (nonatomic, weak) id<TabbarDelegate> delegate;
//取消选中
- (void)unselect;

@end
