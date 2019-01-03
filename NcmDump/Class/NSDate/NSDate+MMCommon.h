//
//  NSDate+MMCommon.h
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

#import <Foundation/Foundation.h>

@interface NSDate (MMCommon) 

void import_NSDate_MMCommon_Compression (void);


/**
 *  @author lincf, 16-06-03 15:06:36
 *
 *  返回当前时区时间
 *
 *  @return Date
 */
+ (NSDate *)mm_localeDate;
- (NSDate *)mm_localeDate;

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
                  Second:(NSUInteger)second;

/****************************************************
 *@Description:实现dateFormatter单例方法
 *@Params:nil
 *Return:相应格式的NSDataFormatter对象
 ****************************************************/
+ (NSDateFormatter *)mm_defaultDateFormatterWithFormatYYYYMMddHHmmss;
+ (NSDateFormatter *)mm_defaultDateFormatterWithFormatYYYYMMdd;
+ (NSDateFormatter *)mm_defaultDateFormatterWithFormatYYYYMMddLine;
+ (NSDateFormatter *)mm_defaultDateFormatterWithFormatMMddHHmm;

+ (NSDateFormatter *)mm_defaultDateFormatterWithFormatYYYYMMddHHmmInChinese;
+ (NSDateFormatter *)mm_defaultDateFormatterWithFormatMMddHHmmInChinese;
+ (NSDateFormatter *)mm_defaultDateFormatterWithFormatHHmmInChinese;

/** YYYY MM dd HH mm ss */
+ (NSDateFormatter *)mm_defaultDateFormatterWithFormatStr:(NSString *)format;

/**********************************************************
 *@Description:获取当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents
 *@Params:nil
 *@Return:当天的包括“年”，“月”，“日”，“周”，“时”，“分”，“秒”的NSDateComponents
 ***********************************************************/
- (NSDateComponents *)mm_componentsOfDay;


/****************************************************
 *@Description:获得NSDate对应的年份
 *@Params:nil
 *@Return:NSDate对应的年份
 ****************************************************/
- (NSUInteger)mm_year;

/****************************************************
 *@Description:获得NSDate对应的月份
 *@Params:nil
 *@Return:NSDate对应的月份
 ****************************************************/
- (NSUInteger)mm_month;


/****************************************************
 *@Description:获得NSDate对应的日期
 *@Params:nil
 *@Return:NSDate对应的日期
 ****************************************************/
- (NSUInteger)mm_day;


/****************************************************
 *@Description:获得NSDate对应的小时数
 *@Params:nil
 *@Return:NSDate对应的小时数
 ****************************************************/
- (NSUInteger)mm_hour;


/****************************************************
 *@Description:获得NSDate对应的分钟数
 *@Params:nil
 *@Return:NSDate对应的分钟数
 ****************************************************/
- (NSUInteger)mm_minute;


/****************************************************
 *@Description:获得NSDate对应的秒数
 *@Params:nil
 *@Return:NSDate对应的秒数
 ****************************************************/
- (NSUInteger)mm_second;

/****************************************************
 *@Description:获得NSDate对应的星期
 *@Params:nil
 *@Return:NSDate对应的星期
 ****************************************************/
- (NSUInteger)mm_weekday;

/******************************************
 *@Description:获取当天是当年的第几周
 *@Params:nil
 *@Return:当天是当年的第几周
 ******************************************/
- (NSUInteger)mm_weekOfDayInYear;

/****************************************************
 *@Description:获得一般当天的工作开始时间
 *@Params:nil
 *@Return:一般当天的工作开始时间
 ****************************************************/
- (NSDate *)mm_workBeginTime;


/****************************************************
 *@Description:获得一般当天的工作结束时间
 *@Params:nil
 *@Return:一般当天的工作结束时间
 ****************************************************/
- (NSDate *)mm_workEndTime;


/****************************************************
 *@Description:获取一小时后的时间
 *@Params:nil
 *@Return:一小时后的时间
 ****************************************************/
- (NSDate *)mm_oneHourLater;


/****************************************************
 *@Description:获得某一天的这个时刻
 *@Params:nil
 *@Return:某一天的这个时刻
 ****************************************************/
- (NSDate *)mm_sameTimeOfDate;

/******************************************
 *@Description:判断与某一天是否为同一天
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一天；NO-不同一天
 ******************************************/
- (BOOL)mm_sameDayWithDate:(NSDate *)otherDate;

/******************************************
 *@Description:判断与某一天是否为同一周
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一周；NO-不同一周
 ******************************************/
- (BOOL)mm_sameWeekWithDate:(NSDate *)otherDate;

/******************************************
 *@Description:判断与某一天是否为同一月
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一月；NO-不同一月
 ******************************************/
- (BOOL)mm_sameMonthWithDate:(NSDate *)otherDate;

/******************************************
 *@Description:判断与某一天是否为同一年
 *@Params:
 *  otherDate:某一天
 *@Return:YES-同一年；NO-不同一年
 ******************************************/
- (BOOL)mm_sameYearWithDate:(NSDate *)otherDate;


/****************************************************
 *@Description:获取时间的字符串格式
 *@Params:nil
 *@Return:时间的字符串格式
 ****************************************************/
- (NSString *)mm_stringOfDateWithFormatYYYYMMddHHmmss;
- (NSString *)mm_stringOfDateWithFormatYYYYMMdd;
- (NSString *)mm_stringOfDateWithFormatYYYYMMddLine;
- (NSString *)mm_stringOfDateWithFormatMMddHHmm;
- (NSString *)mm_stringOfDateWithFormatYYYYMMddHHmmInChinese;
- (NSString *)mm_stringOfDateWithFormatMMddHHmmInChinese;
- (NSString *)mm_stringOfDateWithFormatHHmmInChinese;

/** YYYY MM dd HH mm ss */
- (NSString *)mm_stringOfDateWithFormatStr:(NSString *)format;

- (NSDate *)mm_todayBeginTime;
- (NSDate *)mm_todayEndTime;

/*******
 *返回day天后的日期(若day为负数,则为|day|天前的日期)
 *********/
- (NSDate *)mm_dateAfterDay:(int)day;

/** 
 * 返回某月的天数
 */
- (NSUInteger)mm_daysInMonth;

/** 返回某天到当前相差的天数 */
- (NSUInteger)mm_daysDifferentFromOtherDate:(NSDate *)otherDate;

/** 判断是否在某个时间范围内 */
- (BOOL)mm_isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour;

/** 判断当天是否在某个日期范围内 */
- (BOOL)mm_isBetweenFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

@end
