//
//  CustomLabel.m
//  SBWorkFrameWork
//
//  Created by pg on 16/5/30.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import "CustomLabel.h"
#import "SBCutomLabelMember.h"
@interface CustomLabel()

@property (nonatomic,assign) SBCustomLabelLineType lineType;
@property (nonatomic,strong) UIColor *lineColor;
@end


@implementation CustomLabel

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    //判断需要划线的类型
    switch (_lineType) {
        case 0:
            break;
        case 1:{
            [self drawLine:2];
            break;
        }
        case 2:{
            [self drawLine:self.frame.size.height * 0.5];
            break;
        }
        case 3:{
            [self drawLine:self.frame.size.height - 2];
            break;
        }
        default:
            break;
    }

}

+ (CustomLabel*)labelWithFrame:(CGRect)frame
                 textColor:(UIColor*)color
                      font:(UIFont*)font
                   context:(NSString*)context{
    CustomLabel *label = [[CustomLabel alloc] init];
    label.frame = frame;
    label.textColor = color;
    label.font = font;
    label.text = context;
    return label;
}

-(void)fontWithSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"Arial" size:size];
    self.font = font;
}

- (void)drawLine:(CGFloat)height{
    //设置范围
    CGFloat x = 0;
    CGFloat y = height;
    CGFloat w = self.frame.size.width;
    CGFloat h = 1;
    
    //获取RGBA颜色值
    CGFloat R, G, B, A;
    CGColorRef color = _lineColor.CGColor;
    size_t numComponents = CGColorGetNumberOfComponents(color);
    
    //新建上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    if( numComponents == 4)
    {
        const CGFloat *components = CGColorGetComponents(color);
        R = components[0];
        G = components[1];
        B = components[2];
        A = components[3];
        //填充色
        CGContextSetRGBFillColor(context, R, G, B, A);
    }
    //填充文字
    CGContextFillRect(context, CGRectMake(x, y, w, h));
}

-(void)setFitToWidthWithFont:(CGFloat)fontSize andMaxWidth:(CGFloat)maxWidth{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    //根据指定的最大范围，获取文字的宽度
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(maxWidth, ScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    [self changeFrameWithX:nil orY:nil orW:[NSString stringWithFormat:@"%f",rect.size.width] orH:nil];
}

-(void)setFitToHeightWithFont:(CGFloat)fontSize andMaxHeight:(CGFloat)maxHeight{
    self.numberOfLines = 0;
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    //根据指定的最大范围，获取文字的高度
    CGRect rect = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, maxHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
   [self changeFrameWithX:nil orY:nil orW:nil orH:[NSString stringWithFormat:@"%f",rect.size.height]];
}

-(void)changeFrameWithX:(NSNumber *)x orY:(NSNumber *)y orW:(NSNumber *)width orH:(NSNumber *)height{
   //字符串转CGFloat，重新设置frame
    CGFloat orignX = self.frame.origin.x;
    CGFloat orignY = self.frame.origin.y;
    CGFloat orignW = self.frame.size.width;
    CGFloat orignH = self.frame.size.height;
    
    if (x != nil) {
        orignX = x.floatValue;
    }
    if (y != nil) {
        orignY = y.floatValue;
    }
    if (width != nil) {
        orignW = width.floatValue;
    }
    if (height != nil) {
        orignH = height.floatValue;
    }
    
    self.frame = CGRectMake(orignX, orignY, orignW, orignH);
}


-(void)setLine:(UIColor *)lineColor andLineType:(SBCustomLabelLineType)lineType{
    if (lineColor == nil) {
        _lineColor = self.textColor;
    }else{
        _lineColor = lineColor;
    }
    _lineType = lineType;
}


-(void)setMiddleOrBottomLine:(UIColor *)lineColor{
    //方法一：系统自带方法，添加参数，是个整个字符串上加中划线（问题：数字和文字的中间线不在一条直线上）
//    if (lineColor == nil) {
//        lineColor = self.textColor;
//    }
    /*
     下划线:NSUnderlineStyleAttributeName
     中划线:addAttribute:NSStrikethroughStyleAttributeName
    */
//    NSMutableAttributedString *atr = [[NSMutableAttributedString alloc] initWithString:self.text];
//    [atr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger: NSUnderlineStyleSingle] range:NSMakeRange(0, self.text.length)];
//    [atr addAttribute:NSStrikethroughColorAttributeName value:lineColor range:NSMakeRange(0, self.text.length)];
//    [self setAttributedText:atr];
    
    //方法二：看drawRect
}

-(void)setCustomStyleWithModelsAry:(NSArray *)modelAry{
    
    NSMutableString *readStr = [[NSMutableString alloc] initWithString:@""];
    NSMutableString *showStr = [[NSMutableString alloc] initWithString:@""];
    for(SBCutomLabelMember *member in modelAry)
    {
        [showStr appendString:member.text];
    }
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[showStr copy]];
    for (int i = 0 ; i < modelAry.count; i++) {
        SBCutomLabelMember *member = modelAry[i];
        
        [str addAttribute:NSForegroundColorAttributeName value:member.textColor range:NSMakeRange(readStr.length, member.text.length)];
        [str addAttribute:NSFontAttributeName value:member.font range:NSMakeRange(readStr.length, member.text.length)];
        [readStr appendString:member.text];
    }
    self.attributedText = str;
}


@end
