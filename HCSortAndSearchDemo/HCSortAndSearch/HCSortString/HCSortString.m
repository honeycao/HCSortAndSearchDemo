//
//  HCSortString.m
//
//  Created by Caoyq on 16/6/16.
//  Copyright © 2016年 Caoyq. All rights reserved.
//

#import "HCSortString.h"
#import <objc/runtime.h>
#import "UIAlertController+HCAdd.h"

@implementation HCSortString

+ (NSMutableArray *)sortForStringAry:(NSArray *)ary {
    NSMutableArray *sortAry = [NSMutableArray arrayWithArray:ary];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    NSArray *descriptorAry = [NSArray arrayWithObject:descriptor];
    [sortAry sortUsingDescriptors:descriptorAry];
    
    //将 # 数据放到末尾
    NSMutableArray *removeAry = [NSMutableArray new];
    for (NSString *str in sortAry){
        if ([str isEqualToString:@"#"]) {
            [removeAry addObject:str];
            break;
        }
    }
    [sortAry removeObjectsInArray:removeAry];
    [sortAry addObjectsFromArray:removeAry];
    
    return sortAry;
}

+ (NSMutableArray *)getAllValuesFromDict:(NSDictionary *)dict {
    NSMutableArray *valuesAry = [NSMutableArray new];
    NSArray *keyAry = [self sortForStringAry:[dict allKeys]];
    for (NSString *key in keyAry){
        NSArray *value = [dict objectForKey:key];
        [valuesAry addObjectsFromArray:value];
    }
    return valuesAry;
}

+ (NSMutableDictionary *)sortAndGroupForArray:(NSArray *)ary PropertyName:(NSString *)name {
    NSMutableDictionary *sortDic = [NSMutableDictionary new];
    NSMutableArray *sortAry = [NSMutableArray new];
    NSMutableArray *objAry = [NSMutableArray new];
    NSString *type;
    
    if (ary.count <= 0) {
        [UIAlertController showAlertViewWithTitle:@"提示" Message:@"数据源不能为空" BtnTitles:@[@"确定"] ClickBtn:nil];
        return sortDic;
    }
    
    id objc = ary.firstObject;
    if ([objc isKindOfClass:[NSString class]]) {
        type = @"string";
        for (NSString *str in ary){
            HCSortString *sortString = [HCSortString new];
            sortString.string = str;
            [objAry addObject:sortString];
        }
    }else if ([objc isKindOfClass:[NSDictionary class]]){
        type = @"dict";
    }else{
        type = @"model";
        unsigned int propertyCount, i;
        objc_property_t *properties = class_copyPropertyList([objc class], &propertyCount);
        for (NSObject *obj in ary){
            HCSortString *sortString = [HCSortString new];
            sortString.model = obj;
            for (i = 0; i < propertyCount; i++) {
                objc_property_t property = properties[i];
                const char *char_name = property_getName(property);
                NSString *propertyName = [NSString stringWithUTF8String:char_name];
                if ([propertyName isEqualToString:name]) {
                    id propertyValue = [obj valueForKey:(NSString *)propertyName];
                    sortString.string = propertyValue;
                    [objAry addObject:sortString];
                    break;
                }
                if (i == propertyCount -1) {
                    [UIAlertController showAlertViewWithTitle:@"提示" Message:[NSString stringWithFormat:@"数据源中的Model没有你指定的属性:%@",name] BtnTitles:@[@"确定"] ClickBtn:nil];
                    return sortDic;
                }
            }
        }
    }
    
    sortAry = [self sortAsInitialWithArray:objAry];
    
    NSMutableArray *item = [NSMutableArray array];
    NSString *itemString;
    for (HCSortString *sort in sortAry){
        //首字母不同则item重新初始化，相同则共用一个item
        if (![itemString isEqualToString:sort.initial]) {
            itemString = sort.initial;
            item = [NSMutableArray array];
            if ([type isEqualToString:@"string"]) {
                [item addObject:sort.string];
            }else if ([type isEqualToString:@"model"]){
                [item addObject:sort.model];
            }
            [sortDic setObject:item forKey:itemString];
        }else{
            //item已添加到 regularAry，所以item数据改变时，对应regularAry中也会改变
            if ([type isEqualToString:@"string"]) {
                [item addObject:sort.string];
            }else if ([type isEqualToString:@"model"]){
                [item addObject:sort.model];
            }
        }
    }
    
    return sortDic;
}

/**
 *  将数组按首字母排序
 */
+ (NSMutableArray *)sortAsInitialWithArray:(NSArray *)ary {
    //存储包含首字母和字符串的对象
    NSMutableArray *objectAry = [NSMutableArray array];
    
    //遍历的同时把首字符和对应的字符串存入到srotString对象属性中
    for (NSInteger index = 0; index < ary.count; index++) {
        HCSortString *sortString = ary[index];
        sortString.englishString = [HCSortString transform:sortString.string];
        
        if (sortString.string == nil) {
            sortString.string = @"";
        }
        
        //判断首字符是否为字母
        NSString *regex = @"[A-Za-z]+";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        //得到字符串首个字符
        NSString *header = [sortString.string substringToIndex:1];
        if ([predicate evaluateWithObject:header]) {
            sortString.initial = [header capitalizedString];
        }else{
            
            if (![sortString.string isEqualToString:@""]) {
                //特殊处理的一个字
                if ([header isEqualToString:@"长"]) {
                    sortString.initial = @"C";
                    sortString.englishString = [sortString.englishString stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"C"];
                }else{
                    
                    char initial = [sortString.englishString characterAtIndex:0];
                    if (initial >= 'A' && initial <= 'Z') {
                        sortString.initial = [NSString stringWithFormat:@"%c",initial];
                    }else{
                        sortString.initial = @"#";
                    }
                }
            }else{
                sortString.initial = @"#";
            }
        }
        [objectAry addObject:sortString];
    }
    //先按照首字母initial排序，然后对于首字母相同的再按照englishString排序
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"initial" ascending:YES];
    NSSortDescriptor *descriptor2 = [NSSortDescriptor sortDescriptorWithKey:@"englishString" ascending:YES];
    NSArray *descriptorAry = [NSArray arrayWithObjects:descriptor,descriptor2, nil];
    [objectAry sortUsingDescriptors:descriptorAry];
    
    return objectAry;
}

/**
 * 将中文转化为英文(英文不变)
 *@param   chinese   传入的字符串
 *@return  返回去掉空格并大写的字符串
 */
+ (NSString *)transform:(NSString *)chinese
{
    NSMutableString *english = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)english, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)english, NULL, kCFStringTransformStripCombiningMarks, NO);
    
    //去除两端空格和回车 中间空格不用去，用以区分不同汉字
    [english stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return [english uppercaseString];
}

@end
