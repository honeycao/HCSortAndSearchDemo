//
//  ViewController.m
//  FriendSearch
//
//  Created by Caoyq on 16/3/28.
//  Copyright © 2016年 Caoyq. All rights reserved.
//

#import "ViewController.h"
#import "SearchViewController.h"
#import "AnotherSearchViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    self.navigationItem.title = @"搜索框选择";
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)clickedBtn1:(id)sender {
    AnotherSearchViewController *another = [AnotherSearchViewController new];
    [self.navigationController pushViewController:another animated:YES];
}

- (IBAction)CilckedBtn2:(id)sender {
    SearchViewController *search = [SearchViewController new];
    [self.navigationController pushViewController:search animated:YES];}
@end
