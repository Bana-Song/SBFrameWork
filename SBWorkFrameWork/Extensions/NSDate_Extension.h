//
//  NSDate_Extension.h
//  SBWorkFrameWork
//
//  Created by pg on 16/6/8.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface  NSDate(CustomDate)

/** 将时间字符串从一个格式转换成另外一个格式 */
+(NSString *)transitionTimeString:(NSString *)fromTimeString
                       fromFormat:(NSString*)fromFormat
                         toFormat:(NSString*)toFormat;

/** 将NSDate转换成字符串形式 */
+ (NSString *)stringFromDate:(NSDate *)date format:(NSString*)format;


/** 将时间从字符串形式转换成NSDate */
+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString*)format;

/** 获取距离当前时间 n 天的时间（String格式）;
    PS:   ( NSTimeInterval secondsPerDay =) 24*60*60 (一天24小时，一小时60分，一分60秒);
    正负代表前后
 */

+ (NSString *)stringFromTimeInterval:(NSTimeInterval)timeInterval format:(NSString *)format;

/** 根据字符时间获取距离当前时间的判断.
    PS:只判断了在当前时间之前
 */
+ (NSString *)judgeFromStringDate:(NSString *)dateStr andFormat:(NSString *)format;


//根据字符时间计算实岁年龄
+ (NSInteger)judgeFromStringDateToAge:(NSString *)dateStr andFormat:(NSString *)format;

@end
