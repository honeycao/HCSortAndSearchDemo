//
//  SearchViewController.h
//  HCSortAndSearchDemo
//
//  Created by Caoyq on 16/3/28.
//  Copyright © 2016年 Caoyq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectedItem)(NSString *item);
@interface SearchViewController : UITableViewController

@property (strong, nonatomic) SelectedItem block;

- (void)didSelectedItem:(SelectedItem)block;
@end
