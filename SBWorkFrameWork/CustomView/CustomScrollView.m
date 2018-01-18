//
//  CustomScrollView.m
//  SBWorkFrameWork
//
//  Created by pg on 16/6/14.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import "CustomScrollView.h"

@implementation CustomScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


/** 多层嵌套UIScrollView，防止手势冲突的时候触发的事件(开启所有效果) */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
   // NSLog(@"%ld",gestureRecognizer.state);
    if (gestureRecognizer.state != 0) {
        return YES;
    } else {
        return NO;
    }
    
}

@end
