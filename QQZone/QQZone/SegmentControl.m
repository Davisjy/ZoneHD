//
//  SegmentControl.m
//  QQZone
//
//  Created by qingyun on 15/11/30.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#import "SegmentControl.h"
#import "Common.h"
#import "UIImage+MJ.h"
#import "Segment.h"

@interface SegmentControl ()
@property (nonatomic, strong) Segment *selectedBtn;
@end

@implementation SegmentControl

- (void)setItems:(NSArray *)items
{
    _items = items;
    
    //1.移除之前创建的按钮
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //2.添加新的按钮
    int count = items.count;
    for (int i = 0; i < count; i ++) {
        Segment *btn = [[Segment alloc] init];
        
        btn.tag = i;
        // 设置文字
        [btn setTitle:items[i] forState:UIControlStateNormal];
        // 设置背景
        NSString *bgName = nil;
        NSString *selectedName = nil;
        if (i == 0) {//最左边
            bgName = @"SegmentedControl_Left_Normal";
            selectedName = @"SegmentedControl_Left_Selected";
        } else if (i == count - 1) {//最右边
            bgName = @"SegmentedControl_Normal";
            selectedName = @"SegmentedControl_Right_Selected";
        } else {
            bgName = @"SegmentedControl_Right_Normal";
            selectedName = @"SegmentedControl_Selected";
        }
        [btn setBackgroundImage:[UIImage resizedImageWithName:bgName] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage resizedImageWithName:selectedName] forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:btn];
    }
}

- (void)btnClick:(Segment *)sender
{
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    int count = self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (int i = 0; i < count; i ++) {
        Segment *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.y = 0;
        btn.x = i * btnW;
    }
}

- (void)setSelectedIndex:(int)selectedIndex
{
    int count = self.subviews.count;
    if (selectedIndex < 0 || selectedIndex >= count) return;
    Segment *segment = self.subviews[selectedIndex];
    [self btnClick:segment];
}

- (int)selectedIndex
{
    return self.selectedBtn.tag;
}

@end
