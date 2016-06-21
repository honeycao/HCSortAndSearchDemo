//
//  ModelCell.m
//  HCSortAndSearchDemo
//
//  Created by Caoyq on 16/6/17.
//  Copyright © 2016年 Caoyq. All rights reserved.
//

#import "ModelCell.h"

@implementation ModelCell

- (void)configCellWithModel:(Student *)model {
    Student *stu = model;
    self.image.image = stu.img;
    self.image.backgroundColor = [UIColor redColor];
    self.name.text = [NSString stringWithFormat:@"姓名：%@",stu.name];
    self.age.text = [NSString stringWithFormat:@"年龄：%ld",model.age];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
