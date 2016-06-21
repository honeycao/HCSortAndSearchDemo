//
//  ModelViewController.h
//  HCSortAndSearchDemo
//
//  Created by Caoyq on 16/6/17.
//  Copyright © 2016年 Caoyq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedItem)(NSString *item);

@interface Student : NSObject

@property (strong, nonatomic) UIImage *img;
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger age;

+ (NSMutableArray *)getModelData;



@end


@interface ModelViewController : UITableViewController

@property (strong, nonatomic) SelectedItem block;

- (void)didSelectedItem:(SelectedItem)block;

@end
