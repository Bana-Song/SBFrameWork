//
//  NSString_Extension.h
//  SBWorkFrameWork
//
//  Created by pg on 16/6/8.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    SBFormatTypeEmail, //邮箱
    SBFormatTypeURL, //网址
    SBFormatTypeIDCard, //身份证号
    SBFormatTypeUserName, //字母和数字 6-20位
    SBFormatTypeIP, //IP地址
    SBFormatTypePassword, //汉字、数字、字母、下划线，下划线位置不限
    SBFormatTypePhone //电话
}SBFormatType;

@interface NSString(CustomString)

/** 判断字符是否为空 */
+(BOOL)isBlankString:(NSString *)string;

/** md5 32位加密 （小写） */
+(NSString *)md5StrFor32:(NSString *)string;

/** md5 16位加密 （大写） */
+(NSString *)md5StrFor16:(NSString *)string;

/** 验证格式是否正确，不带提示框 */
+(BOOL)isCorrectForamt:(NSString *)string andType:(SBFormatType)type;

/** 验证格式是否正确，带提示框 */
+(BOOL)isCorrectForamt:(NSString *)string andType:(SBFormatType)type andAlertMsg:(NSString *)msg;


/** 根据文字和字体大小获取宽度 PS:基于屏幕宽度和高度的范围 */
-(CGFloat)getWidthWithStringandFontSize:(CGFloat)fontSize;

/** 根据文字和字体大小获取宽度 PS:基于限定宽度 */
-(CGFloat)getWidthWithStringandFontSize:(CGFloat)fontSize andMaxWidth:(CGFloat)maxWidth;

/** 根据文字和字体大小获取高度 PS:基于限定宽度 */
-(CGFloat)getHeightWithStringandFontSize:(CGFloat)fontSize andMaxWidth:(CGFloat)maxWidth;
/** 根据文字和字体大小获取宽度 PS:基于限定高度 */
-(CGFloat)getWidthWithStringandFontSize:(CGFloat)fontSize andMaxHeight:(CGFloat)maxHeight;

/** 根据文字和字体大小获取高度 PS:基于屏幕宽度和高度的范围*/
-(CGFloat)getHeightWithStringandFontSize:(CGFloat)fontSize;


/** 根据文字和字体大小获取高度 PS:基于限定高度*/
-(CGFloat)getHeightWithStringandFontSize:(CGFloat)fontSize andMaxHeight:(CGFloat)maxHeight;


/**  普通字符串转换为十六进制的 */
- (NSString *)hexStringFromString;

/**
 * 补零
 */
-(NSString *)AddZero:(CGFloat)maxLength;

/**
 十六进制转NSdata
 */
-(NSData*) hexToBytes;


//限制输入数字
+ (BOOL)validateNumber:(NSString*)number;
@end
