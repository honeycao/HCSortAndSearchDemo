//
//  ModelCell.h
//  HCSortAndSearchDemo
//
//  Created by Caoyq on 16/6/17.
//  Copyright © 2016年 Caoyq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelViewController.h"

@interface ModelCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *age;

- (void)configCellWithModel:(Student *)model;

@end
