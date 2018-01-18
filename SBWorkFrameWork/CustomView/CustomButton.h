//
//  CustomButton.h
//  SBWorkFrameWork
//
//  Created by pg on 16/5/31.
//  Copyright © 2016年 Bana. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface CustomButton : UIButton

-(void)setShadowOffset:(CGSize)offset andAphla:(CGFloat)aphla andColor:(UIColor *)color andRadius:(CGFloat)radius;  //默认颜色为黑色

/** 设置字体大小
    带默认字体 
 */
-(void)titleFontWithSize:(CGFloat)size;

@end
