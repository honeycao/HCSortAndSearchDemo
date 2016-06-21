//
//  UIAlertController+HCAdd.h
//  HCKit
//
//  Created by Caoyq on 16/6/1.
//  Copyright © 2016年 honeycao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (HCAdd)

/**
 * 快速创建一个AlertView
 *@param    title         首行显示的标题
 *@param    message       首行之下显示的消息
 *@param    btnTitles     存放所有按钮名称的数组(存放顺序和排列顺序一致，按序取出来的数据超过3个则是从上往下依次排列，等于2个则是从左到右依次排列)
 *@param    clickBtnBlock 点击事件的回调(传回来的下标值和数组元素位置一一对应)
 *@return   void
 */
+ (void)showAlertViewWithTitle:(NSString *)title Message:(NSString *)message BtnTitles:(NSArray<NSString *> *)btnTitles ClickBtn:(void (^)(NSInteger index))clickBtnBlock;

/**
 * 快速创建一个ActionSheet
 *@param   title            首行显示的标题
 *@param   message          首行之下显示的消息
 *@param   cancelBtnTitle   最底下按钮的名称
 *@param   otherBtnTitles   除了cancelBtnTitle之外,其他按钮名称都按顺序存放在这个数组中，显示的时候是从上到下依次按顺序呈列
 *@param   clickBtnBlock    点击事件的回调，返回点击的下标值，cancel按钮默认为0，其他按钮值和数组元素存放顺序一致（1.2.3...）
 *@return  void
 */
+ (void)showActionSheetWithTitle:(NSString *)title Message:(NSString *)message cancelBtnTitle:(NSString *)cancelBtnTitle OtherBtnTitles:(NSArray<NSString *> *)otherBtnTitles ClickBtn:(void(^)(NSInteger index))clickBtnBlock;

@end
