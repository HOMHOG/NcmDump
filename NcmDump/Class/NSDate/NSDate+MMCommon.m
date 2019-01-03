//
//  NSDate+MMCommon.m
//  FreeDaily
//
//  Created by YongbinZhang on 3/5/13.
//  Copyright (c) 2013 YongbinZhang
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "NSDate+MMCommon.h"

@implementation NSDate (MMCommon) 

void import_NSDate_MMCommon_Compression (void) { }


#pragma mark - 返回当前时区时间
+ (NSDate *)mm_localeDate
{
    return [[NSDate date] mm_localeDate];
}

- (NSDate *)mm_localeDate
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: self];
    
    NSDate *localeDate = [self  dateByAddingTimeInterval: interval];
    
    return localeDate;
}

/****************************************************
 *@Description:根据年份、月份、日期、小时数、分钟数、秒数返回NSDate
 *@Params:
 *  year:年份
 *  month:月份
 *  day:日期
 *  hour:小时数
 *  minute:分钟数
 *  second:秒数
 *@Return:
 ****************************************************/
+ (NSDate *)mm_dateWithYear:(NSUInteger)year
                   Month:(NSUInteger)month
                     Day:(NSUInteger)day
                    Hour:(NSUInteger)hour
                  Minute:(NSUInteger)minute
                  Second:(NSUInteger)second
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
    dateComponents.year = year;
    dateComponents.month = month;
    dateComponents.day = day;
    dateComponents.hour = hour;
    dateComponents.minute = minute;
    dateComponents.second = second;
    
    return [[[NSCalendar currentCalendar] dateFromComponents:dateComponents] mm_localeDate];
}


/****************************************************
 *@Description:实现dateFormatter单例方法
 *@Params:nil
 *Return:相应格式的NSDataFormatter对象
 ****************************************************/
+ (NSDateFormatter *)mm_defaultDateFormatterWithFormatYYYYMMddHHmmss
{
    static NSDateFormatter *staticDateFormatterWithFormatYYYYMMddHHmmss;
    if (!staticDateFormatterWithFormatYYYYMMddHHmmss) {
        staticDateFormatterWithFormatYYYYMMddHHmmss = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatYYYYMMddHHmmss setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    }
    
    return staticDateFormatterWithFormatYYYYMMddHHmmss;
}

+ (NSDateFormatter *)mm_defaultDateFormatterWithFormatYYYYMMdd
{
    static NSDateFormatter *staticDateFormatterWithFormatYYYYMMddHHmmss;
    if (!staticDateFormatterWithFormatYYYYMMddHHmmss) {
        staticDateFormatterWithFormatYYYYMMddHHmmss = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatYYYYMMddHHmmss setDateFormat:@"YYYY.MM.dd"];
    }
    
    return staticDateFormatterWithFormatYYYYMMddHHmmss;
}

+ (NSDateFormatter *)mm_defaultDateFormatterWithFormatYYYYMMddLine
{
    static NSDateFormatter *staticDateFormatterWithFormatYYYYMMddHHmmss;
    if (!staticDateFormatterWithFormatYYYYMMddHHmmss) {
        staticDateFormatterWithFormatYYYYMMddHHmmss = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatYYYYMMddHHmmss setDateFormat:@"YYYY-MM-dd"];
    }
    
    return staticDateFormatterWithFormatYYYYMMddHHmmss;
}

+ (NSDateFormatter *)mm_defaultDateFormatterWithFormatMMddHHmm
{
    static NSDateFormatter *staticDateFormatterWithFormatMMddHHmm;
    if (!staticDateFormatterWithFormatMMddHHmm) {
        staticDateFormatterWithFormatMMddHHmm = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatMMddHHmm setDateFormat:@"MM-dd HH:mm"];
    }
    
    return staticDateFormatterWithFormatMMddHHmm;
}

+ (NSDateFormatter *)mm_defaultDateFormatterWithFormatYYYYMMddHHmmInChinese
{
    static NSDateFormatter *staticDateFormatterWithFormatYYYYMMddHHmmssInChines;
    if (!staticDateFormatterWithFormatYYYYMMddHHmmssInChines) {
        staticDateFormatterWithFormatYYYYMMddHHmmssInChines = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatYYYYMMddHHmmssInChines setDateFormat:@"YYYY年MM月dd日 HH:mm"];
    }
    
    return staticDateFormatterWithFormatYYYYMMddHHmmssInChines;
}

+ (NSDateFormatter *)mm_defaultDateFormatterWithFormatMMddHHmmInChinese
{
    static NSDateFormatter *staticDateFormatterWithFormatMMddHHmmInChinese;
    if (!staticDateFormatterWithFormatMMddHHmmInChinese) {
        staticDateFormatterWithFormatMMddHHmmInChinese = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatMMddHHmmInChinese setDateFormat:@"MM月dd日 HH:mm"];
    }
    
    return staticDateFormatterWithFormatMMddHHmmInChinese;
}

+ (NSDateFormatter *)mm_defaultDateFormatterWithFormatHHmmInChinese
{
    static NSDateFormatter *staticDateFormatterWithFormatHHmmInChinese;
    if (!staticDateFormatterWithFormatHHmmInChinese) {
        staticDateFormatterWithFormatHHmmInChinese = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatHHmmInChinese setDateFormat:@"HH:mm"];
    }
    
    return staticDateFormatterWithFormatHHmmInChinese;
}

+ (NSDateFormatter *)mm_defaultDateFormatterWithFormatStr:(NSString *)format
{
    static NSDateFormatter *staticDateFormatterWithFormatStr;
    if (!staticDateFormatterWithFormatStr) {
        staticDateFormatterWithFormatStr = [[NSDateFormatter alloc] init];
        [staticDateFormatterWithFormatStr setDateFormat:format];
    }
    
    return staticDateFormatterWithFormatStr;
}


/**********************************************************
 *@Description:获取当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents
 *@Params:nil
 *@Return:当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents
 ***********************************************************/
- (NSDateComponents *)mm_componentsOfDay
{
    return [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
}


//  --------------------------NSDate---------------------------
/****************************************************
 *@Description:获得NSDate对应的年份
 *@Params:nil
 *@Return:NSDate对应的年份
 ****************************************************/
- (NSUInteger)mm_year
{
    return [self mm_componentsOfDay].year;
}

/****************************************************
 *@Description:获得NSDate对应的月份
 *@Params:nil
 *@Return:NSDate对应的月份
 ****************************************************/
- (NSUInteger)mm_month
{
    return [self mm_componentsOfDay].month;
}


/****************************************************
 *@Description:获得NSDate对应的日期
 *@Params:nil
 *@Return:NSDate对应的日期
 ****************************************************/
- (NSUInteger)mm_day
{
    return [self mm_componentsOfDay].day;
}


/****************************************************
 *@Description:获得NSDate对应的小时数
 *@Params:nil
 *@Return:NSDate对应的小时数
 ****************************************************/
- (NSUInteger)mm_hour
{
    return [self mm_componentsOfDay].hour;
}


/****************************************************
 *@Description:获得NSDate对应的分钟数
 *@Params:nil
 *@Return:NSDate对应的分钟数
 ****************************************************/
- (NSUInteger)mm_minute
{
    return [self mm_componentsOfDay].minute;
}


/****************************************************
 *@Description:获得NSDate对应的秒数
 *@Params:nil
 *@Return:NSDate对应的秒数
 ****************************************************/
- (NSUInteger)mm_second
{
    return [self mm_componentsOfDay].second;
}

/****************************************************
 *@Description:获得NSDate对应的星期
 *@Params:nil
 *@Return:NSDate对应的星期
 ****************************************************/
- (NSUInteger)mm_weekday
{
    return [self mm_componentsOfDay].weekday;
}

/******************************************
 *@Description:获取当天是当年的第几周
 *@Params:nil
 *@Return:当天是当年的第几周
 ******************************************/
- (NSUInteger)mm_weekOfDayInYear
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitWeekOfYear inUnit:NSCalendarUnitYear forDate:self];
}


/****************************************************
 *@Description:获得一般当天的工作开始时间
 *@Params:nil
 *@Return:一般当天的工作开始时间
 ****************************************************/
- (NSDate *)mm_workBeginTime
{
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [components setHour:9];
    [components setMinute:30];
    [components setSecond:0];
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (NSDate *)mm_todayBeginTime {
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

- (NSDate *)mm_todayEndTime
{
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [components setHour:23];
    [components setMinute:59];
    [components setSecond:59];
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

/****************************************************
 *@Description:获得一般当天的工作结束时间
 *@Params:nil
 *@Return:一般当天的工作结束时间
 ****************************************************/
- (NSDate *)mm_workEndTime
{
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [components setHour:18];
    [components setMinute:0];
    [components setSecond:0];
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}


/****************************************************
 *@Description:获取一小时后的时间
 *@Params:nil
 *@Return:一小时后的时间
 ****************************************************/
- (NSDate *)mm_oneHourLater
{
    return [NSDate dateWithTimeInterval:3600 sinceDate:self];
}


/****************************************************
 *@Description:获得某一天的这个时刻
 *@Params:nil
 *@Return:某一天的这个时刻
 ****************************************************/
- (NSDate *)mm_sameTimeOfDate
{
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [components setHour:[[NSDate date] mm_hour]];
    [components setMinute:[[NSDate date] mm_minute]];
    [components setSecond:[[NSDate date] mm_second]];
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

/******************************************
 *@Description:判断与某一天是否为同一天
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一天；NO-不同一天
 ******************************************/
- (BOOL)mm_sameDayWithDate:(NSDate *)otherDate
{
    if (self.mm_year == otherDate.mm_year && self.mm_month == otherDate.mm_month && self.mm_day == otherDate.mm_day) {
        return YES;
    } else {
        return NO;
    }
}


/******************************************
 *@Description:判断与某一天是否为同一周
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一周；NO-不同一周
 ******************************************/
- (BOOL)mm_sameWeekWithDate:(NSDate *)otherDate
{
    if (self.mm_year == otherDate.mm_year  && self.mm_month == otherDate.mm_month && self.mm_weekOfDayInYear == otherDate.mm_weekOfDayInYear) {
        return YES;
    } else {
        return NO;
    }
}

/******************************************
 *@Description:判断与某一天是否为同一月
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一月；NO-不同一月
 ******************************************/
- (BOOL)mm_sameMonthWithDate:(NSDate *)otherDate
{
    if (self.mm_year == otherDate.mm_year && self.mm_month == otherDate.mm_month) {
        return YES;
    } else {
        return NO;
    }
}

/******************************************
 *@Description:判断与某一天是否为同一年
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一年；NO-不同一年
 ******************************************/
- (BOOL)mm_sameYearWithDate:(NSDate *)otherDate
{
    if (self.mm_year == otherDate.mm_year) {
        return YES;
    } else {
        return NO;
    }
}


/****************************************************
 *@Description:获取时间的字符串格式
 *@Params:nil
 *@Return:时间的字符串格式
 ****************************************************/
- (NSString *)mm_stringOfDateWithFormatYYYYMMddHHmmss
{
    return [[NSDate mm_defaultDateFormatterWithFormatYYYYMMddHHmmss] stringFromDate:self];
}

- (NSString *)mm_stringOfDateWithFormatYYYYMMdd
{
    return [[NSDate mm_defaultDateFormatterWithFormatYYYYMMdd] stringFromDate:self];
}

- (NSString *)mm_stringOfDateWithFormatYYYYMMddLine {
    return [[NSDate mm_defaultDateFormatterWithFormatYYYYMMddLine] stringFromDate:self];
}

- (NSString *)mm_stringOfDateWithFormatMMddHHmm
{
    return [[NSDate mm_defaultDateFormatterWithFormatMMddHHmm] stringFromDate:self];
}

- (NSString *)mm_stringOfDateWithFormatYYYYMMddHHmmInChinese
{
    return [[NSDate mm_defaultDateFormatterWithFormatYYYYMMddHHmmInChinese] stringFromDate:self];
}

- (NSString *)mm_stringOfDateWithFormatMMddHHmmInChinese
{
    return [[NSDate mm_defaultDateFormatterWithFormatMMddHHmmInChinese] stringFromDate:self];
}

- (NSString *)mm_stringOfDateWithFormatHHmmInChinese
{
    return [[NSDate mm_defaultDateFormatterWithFormatHHmmInChinese] stringFromDate:self];
}

- (NSString *)mm_stringOfDateWithFormatStr:(NSString *)format
{
    return [[NSDate mm_defaultDateFormatterWithFormatStr:format] stringFromDate:self];
}


//!返回day天后的日期(若day为负数,则为|day|天前的日期)
- (NSDate *)mm_dateAfterDay:(int)day {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // Get the weekday component of the current date
    
    // NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    // to get the end of week for a particular date, add (7 - weekday) days
    
    [componentsToAdd setDay:day];
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    return dateAfterDay;
    
}

/** 返回当月天数 */
- (NSUInteger)mm_daysInMonth
{
    NSRange days = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return days.length;
}

/** 返回某天到当前相差的天数 */
- (NSUInteger)mm_daysDifferentFromOtherDate:(NSDate *)otherDate
{
    int D_DAY = 60*60*24;
    NSTimeInterval interval = [self timeIntervalSinceDate:otherDate];
    NSUInteger days = @(interval).intValue / D_DAY;
    return days;
}

/** 判断是否在某个时间范围内 */
- (BOOL)mm_isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour
{
    NSInteger hour = [self mm_hour];
    if(hour >= fromHour && hour <= toHour) {
        return YES;
    }
    return NO;
}

/** 判断当天是否在某个日期范围内 */
- (BOOL)mm_isBetweenFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate
{
    NSInteger fromDays = [self mm_daysDifferentFromOtherDate:fromDate];
    NSInteger toDays = [self mm_daysDifferentFromOtherDate:toDate];
    if (fromDays >= 0 && toDays <= 0) {
        return YES;
    }
    return NO;
}

@end
