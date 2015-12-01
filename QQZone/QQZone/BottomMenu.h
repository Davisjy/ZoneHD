//
//  BottiomMenu.h
//  QQZone
//
//  Created by qingyun on 15/11/29.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BottomMenu;

typedef enum {
    BottomMenuTypeMood, //心情
    BottomMenuTypePhoto, //拍照
    BottomMenuTypeBlog  //日志
}BottomMenuType;

@protocol BottomMenuDelegate <NSObject>

- (void)bottomMenu:(BottomMenu *)bottomMenu didClickBottom:(BottomMenuType)bottomType;

@end

@interface BottomMenu : UIView
//旋转，是否为横屏
- (void)rotate:(BOOL)lanscape;
@property (nonatomic, weak) id<BottomMenuDelegate> delegate;
@end
