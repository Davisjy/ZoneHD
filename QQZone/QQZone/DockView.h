//
//  DockView.h
//  QQZone
//
//  Created by qingyun on 15/11/29.
//  Copyright © 2015年 qingyun. All rights reserved.
//  整个左边工具栏

#import <UIKit/UIKit.h>
@class Tabbar,IconButtion,BottomMenu;
@interface DockView : UIView

@property (nonatomic, strong, readonly) Tabbar *tabBar;
@property (nonatomic, strong, readonly) IconButtion *iconView;
@property (nonatomic, strong, readonly) BottomMenu *bottomMenu;
//旋转，是否为横屏
- (void)rotate:(BOOL)lanscape;
@end
