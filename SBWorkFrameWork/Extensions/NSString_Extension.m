//
//  NSString_Extension.m
//  SBWorkFrameWork
//
//  Created by pg on 16/6/8.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import "NSString_Extension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString(CustomString)


//判断字符是否为空
+(BOOL)isBlankString:(NSString *)string{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


//md5 32位加密 （小写）
+(NSString *)md5StrFor32:(NSString *)string{
    const char *cStr = [string UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0],result[1],result[2],result[3],
            result[4],result[5],result[6],result[7],
            result[8],result[9],result[10],result[11],
            result[12],result[13],result[14],result[15],
            result[16], result[17],result[18], result[19],
            result[20], result[21],result[22], result[23],
            result[24], result[25],result[26], result[27],
            result[28], result[29],result[30], result[31]];
}

//md5 16位加密 （大写）

+(NSString *)md5StrFor16:(NSString *)string {
    const char *cStr = [string UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

//验证格式的两个方法
+(BOOL)isCorrectForamt:(NSString *)string andType:(SBFormatType)type {

    NSString *regex = @"";
    if ([NSString isBlankString:string]) {
        return NO;
    }
    switch (type) {
        case SBFormatTypeEmail:{
            regex = mailRegex;
            break;
        }
        case SBFormatTypeIP:{
            regex = ipRegex;
            break;
        }
        case SBFormatTypeURL:{
            regex = httpUrlRegex;
            break;
        }
        case SBFormatTypeIDCard:{
            regex = IDCardRegex;
            break;
        }
        case SBFormatTypeUserName:{
            regex = userNameRegex;
            break;
        }
        case SBFormatTypePassword:{
            regex = passWordRegex;
            break;
        }
        case SBFormatTypePhone:{
            regex = phonenumRegex;
            break;
        }
        default:
            break;
    }
    NSError *error = nil;
    
    NSRegularExpression *TelExp = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *isMatchTel = [TelExp firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    if (isMatchTel)
    {
        return YES;
    }
    return NO;
}

+(BOOL)isCorrectForamt:(NSString *)string andType:(SBFormatType)type andAlertMsg:(NSString *)msg{
    if (![NSString isCorrectForamt:string andType:type]){
        SBLog(@"格式错误：%@",msg);
        [SBProgressHUD showErrorWithStatus:msg];
        return NO;
    }
    return YES;
}


-(CGFloat)getHeightWithStringandFontSize:(CGFloat)fontSize andMaxWidth:(CGFloat)maxWidth{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGRect rect = [self boundingRectWithSize:CGSizeMake(maxWidth, ScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.height;
}

-(CGFloat)getWidthWithStringandFontSize:(CGFloat)fontSize andMaxHeight:(CGFloat)maxHeight {
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGRect rect = [self boundingRectWithSize:CGSizeMake(ScreenWidth, maxHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.width;
}

/** 获取字符串的宽 */
-(CGFloat)getWidthWithStringandFontSize:(CGFloat)fontSize{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGRect rect = [self boundingRectWithSize:CGSizeMake(ScreenWidth, ScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.width;
}

/** 获取字符串的高 */
-(CGFloat)getHeightWithStringandFontSize:(CGFloat)fontSize{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGRect rect = [self boundingRectWithSize:CGSizeMake(ScreenWidth, ScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.height;
}


/** 获取字符串的宽,限定宽度 */
-(CGFloat)getWidthWithStringandFontSize:(CGFloat)fontSize andMaxWidth:(CGFloat)maxWidth{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGRect rect = [self boundingRectWithSize:CGSizeMake(ScreenWidth, ScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    if (rect.size.width > maxWidth) {
        return maxWidth;
    }
    return rect.size.width;
}
/** 获取字符串的高,限定高度 */
-(CGFloat)getHeightWithStringandFontSize:(CGFloat)fontSize andMaxHeight:(CGFloat)maxHeight{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGRect rect = [self boundingRectWithSize:CGSizeMake(ScreenWidth, ScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    if (rect.size.height > maxHeight) {
        return maxHeight;
    }
    return rect.size.height;
}

/**  普通字符串转换为十六进制的 */
- (NSString *)hexStringFromString{
    NSData *myD = [self dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%X",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    return hexStr;
}


/**
 * 补零
 */
-(NSString *)AddZero:(CGFloat)maxLength
{
    if(self.length < maxLength){
        NSMutableString *formatStr = [NSMutableString string];
        for (int i = 0; i< (maxLength - self.length); i++) {
            [formatStr appendString:@"0"];
        }
        [formatStr appendString:@"%@"];
        return [NSString stringWithFormat:formatStr,self];
    }
    return self;
}

/**
 十六进制转NSdata
 */
-(NSData*) hexToBytes{
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= self.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [self substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}


//限制输入数字
+ (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

@end
