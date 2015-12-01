//
//  SegmentControl.h
//  QQZone
//
//  Created by qingyun on 15/11/30.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentControl : UIView

@property (nonatomic, strong) NSArray *items;
//设置当前选中的位置
@property (nonatomic, assign) int selectedIndex;

@end
