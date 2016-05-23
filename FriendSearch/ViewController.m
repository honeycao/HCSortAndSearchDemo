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
#import "EasySerachViewController.h"
#import "HCHeader.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *titleTableView;
@property (strong, nonatomic) NSArray *dataSource;
@end

@implementation ViewController


- (void)viewDidLoad {
    self.navigationItem.title = @"搜索类型";
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    UIBarButtonItem *back = [[UIBarButtonItem alloc]init];
    back.title = @"";
    self.navigationItem.backBarButtonItem = back;
    _dataSource = @[@"搜索栏滚动式通讯录",@"搜索栏固定式通讯录",@"单独调用搜索功能"];
    [self.view addSubview:self.titleTableView];
    
    NSLog(@"cyq_%@",[NSDate date]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UITableView *)titleTableView {
    if (!_titleTableView) {
        _titleTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _titleTableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        _titleTableView.delegate = self;
        _titleTableView.dataSource = self;
    }
    return _titleTableView;
}

#pragma mark - Table View DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell.detailTextLabel setAdjustsFontSizeToFitWidth:YES];
    [cell.detailTextLabel setMinimumScaleFactor:0.5];
    switch (indexPath.row) {
        case 0:{
            SearchViewController *search = [SearchViewController new];
            search.title = _dataSource[indexPath.row];
            //返回选中搜索的结果
            [search didSelectedItem:^(NSString *item) {
                cell.detailTextLabel.text = item;
            }];
            [self.navigationController pushViewController:search animated:YES];
        }
            break;
        case 1:{
            AnotherSearchViewController *another = [AnotherSearchViewController new];
            //返回选中搜索的结果
            [another didSelectedItem:^(NSString *item) {
                cell.detailTextLabel.text = item;
            }];
            another.title = _dataSource[indexPath.row];
            [self.navigationController pushViewController:another animated:YES];
        }
            break;
        case 2:{
            EasySerachViewController *easy = [EasySerachViewController new];
            //返回选中搜索的结果
            [easy didSelectedItem:^(NSString *item) {
                cell.detailTextLabel.text = item;
            }];
            easy.title = _dataSource[indexPath.row];
            [self.navigationController pushViewController:easy animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
