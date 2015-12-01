//
//  Segment.m
//  QQZone
//
//  Created by qingyun on 15/11/30.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#import "Segment.h"

@implementation Segment

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置文字颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted{}

@end
