//
//  NSDate_Extension.m
//  SBWorkFrameWork
//
//  Created by pg on 16/6/8.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import "NSDate_Extension.h"

@implementation NSDate(CustomDate)

//时间格式的转换  PS：yyyy-MM-dd hh(HH):mm:ss HH为24小时制，hh为12小时制
+ (NSString *)transitionTimeString:(NSString *)fromTimeString
                        fromFormat:(NSString*)fromFormat
                          toFormat:(NSString*)toFormat{
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = fromFormat;
    NSDate *date = [format dateFromString:fromTimeString];
    
    format.dateFormat = toFormat;
    return [format stringFromDate:date];
}

+(NSString *)stringFromDate:(NSDate *)date format:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = format;
    return [formatter stringFromDate:date];

}

+ (NSDate *)dateFromString:(NSString *)dateString format:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = format;
    return [formatter dateFromString:dateString];
}

+ (NSString *)stringFromTimeInterval:(NSTimeInterval)timeInterval format:(NSString *)format {
    NSDate *resultDate = [NSDate dateWithTimeIntervalSinceNow:timeInterval];
    return [NSDate stringFromDate:resultDate format:format];
}


+(NSString *)judgeFromStringDate:(NSString *)dateStr andFormat:(NSString *)format {
    NSDate *currentDate = [NSDate dateFromString:dateStr format:format];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceNow];
    timeInterval =  -timeInterval;
    
    long temp = 0;
    NSString *result = @"";
    if (timeInterval < 60) {
        result = @"刚刚";
    }
    else if ((temp = timeInterval/60)<60)
    {
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    else if ((temp = temp/60) <24)
    {
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else if ((temp = temp/24) <30)
    {
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    else if  ((temp = temp/30) <12)
    {
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else
    {
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    return result;
}


+(NSInteger)judgeFromStringDateToAge:(NSString *)dateStr andFormat:(NSString *)format{
        NSDate *birthDate = [NSDate dateFromString:dateStr format:format];
    // 出生日期转换 年月日
        NSDateComponents *components1 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:birthDate];
        NSInteger brithDateYear  = [components1 year];
        NSInteger brithDateDay   = [components1 day];
        NSInteger brithDateMonth = [components1 month];
        
        // 获取系统当前 年月日
        NSDateComponents *components2 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
        NSInteger currentDateYear  = [components2 year];
        NSInteger currentDateDay   = [components2 day];
        NSInteger currentDateMonth = [components2 month];
        
        // 计算年龄
        NSInteger iAge = currentDateYear - brithDateYear - 1;
        if ((currentDateMonth > brithDateMonth) || (currentDateMonth == brithDateMonth && currentDateDay >= brithDateDay)) {
            iAge++;  
        }  
        
    return iAge;
}

@end
