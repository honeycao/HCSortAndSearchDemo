//
//  HCSortString.h
//
//  Created by Caoyq on 16/6/16.
//  Copyright © 2016年 Caoyq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HCSortString : NSObject

///大写首字母
@property (strong, nonatomic) NSString     *initial;

///最原始的字符串
@property (strong, nonatomic) NSString     *string;

///转化得到的大写英文字符串
@property (strong, nonatomic) NSString     *englishString;

///model类型
@property (strong, nonatomic) NSObject     *model;

#pragma mark - 给数组按首字母排序和分组
/**
 *  给数组按首字母排序和分组
 *@param   ary   传进来的数组(数组中可以是字符串、model)
 *@param   name  如果数组中是字符组则可以为nil，如果为model，则是需要排序的属性名
 *@return  返回一个以首字母为key的字典
 */
+ (NSMutableDictionary *)sortAndGroupForArray:(NSArray *)ary PropertyName:(nullable NSString *)name;

#pragma mark - 给字符串数组进行排序
/**
 *  给字符串数组进行排序
 *@param   ary   字符串数组
 *@return  返回排序好的数组
 */
+ (NSMutableArray *)sortForStringAry:(NSArray *)ary;

#pragma mark - 得到一个字典的所有值
/**
 *  得到一个字典的所有值
 *@param   dict   传入的字典
 *@return  返回一个存放字典所有值的数组
 */
+ (NSMutableArray *)getAllValuesFromDict:(NSDictionary *)dict;

NS_ASSUME_NONNULL_END
@end
