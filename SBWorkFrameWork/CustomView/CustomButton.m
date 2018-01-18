//
//  CustomButton.m
//  SBWorkFrameWork
//
//  Created by pg on 16/5/31.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

//设置阴影
-(void)setShadowOffset:(CGSize)offset andAphla:(CGFloat)aphla andColor:(UIColor *)color andRadius:(CGFloat)radius{
    if (color == nil) {
        color = [UIColor blackColor];
    }
    self.layer.shadowColor  = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = aphla;
    //self.layer.masksToBounds = NO;
    self.layer.shadowRadius = radius;//阴影半径，默认3
}

//设置字体大小
-(void)titleFontWithSize:(CGFloat)size{
    UIFont *font = [UIFont fontWithName:@"Arial" size:size];
    self.titleLabel.font = font;
}

@end
