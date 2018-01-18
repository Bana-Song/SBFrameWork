//
//  CustomLabel.h
//  SBWorkFrameWork
//
//  Created by pg on 16/5/30.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum{
    SBCustomLabelLineTypeDefault,   //没有线条
    SBCustomLabelLineTypeTop,       //上划线
    SBCustomLabelLineTypeMiddle,    //中划线
    SBCustomLabelLineTypeBottom     //下划线
}SBCustomLabelLineType;//自定义线条类型


@interface CustomLabel : UILabel

+ (CustomLabel*)labelWithFrame:(CGRect)frame
                 textColor:(UIColor*)color
                      font:(UIFont*)font
                   context:(NSString*)context;

/** 设置字体大小
    方法中带默认字体
 */
-(void)fontWithSize:(CGFloat)size;

-(void)setFitToWidthWithFont:(CGFloat)fontSize andMaxWidth:(CGFloat)maxWidth; //自适应宽度

-(void)setFitToHeightWithFont:(CGFloat)fontSize andMaxHeight:(CGFloat)maxHeight; //自适应高度

-(void)changeFrameWithX:(NSNumber *)x orY:(NSNumber *)y orW:(NSNumber *)width orH:(NSNumber *)height;//改变frame

-(void)setLine:(UIColor *)lineColor andLineType:(SBCustomLabelLineType)lineType; //加线，颜色可以为空

-(void)setCustomStyleWithModelsAry:(NSArray *)modelAry; //设置自定义样式:SBCutomLabelMember （通过颜色值，字体大小，文字）



@end


