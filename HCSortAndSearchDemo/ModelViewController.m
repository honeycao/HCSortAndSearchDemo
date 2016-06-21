//
//  ModelViewController.m
//  HCSortAndSearchDemo
//
//  Created by Caoyq on 16/6/17.
//  Copyright © 2016年 Caoyq. All rights reserved.
//

#import "ModelViewController.h"
#import "ModelCell.h"
#import "HCSortString.h"
#import "ZYPinYinSearch.h"
#import <objc/runtime.h>

#define kColor          [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];

@implementation Student

+ (NSMutableArray *)getModelData {
    NSMutableArray *ary = [NSMutableArray new];
    NSArray *ary1 = @[@"张三",@"李四",@"托马斯",@"angel",@"12-谈",@"520",@"****",@"Linda",];
    NSArray *ary2 = @[@"12",@"16",@"20",@"8",@"80",@"22",@"11",@"20"];
    
    for (NSInteger index = 0; index < ary1.count;index++){
        Student *stu = [Student new];
        stu.img = [UIImage imageNamed:@"name"];
        stu.name = ary1[index];
        stu.age = [ary2[index] integerValue];
        [ary addObject:stu];
    }
    return ary;
}

@end

@interface ModelViewController ()<UISearchResultsUpdating>

@property (strong, nonatomic) Student *student;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) NSArray *ary;
@property (strong, nonatomic) NSMutableArray *dataSource;/**<排序前的整个数据源*/
@property (strong, nonatomic) NSDictionary *allDataSource;/**<排序后的整个数据源*/
@property (strong, nonatomic) NSMutableArray *searchDataSource;/**<搜索结果数据源*/
@property (strong, nonatomic) NSArray *indexDataSource;/**<索引数据源*/

@end

@implementation ModelViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getData];
    self.tableView.backgroundColor = kColor;
    [self.tableView setTableHeaderView:self.searchController.searchBar];
}

#pragma mark - -------
- (void)getData {
    _dataSource = [Student getModelData];
    _allDataSource = [HCSortString sortAndGroupForArray:_dataSource PropertyName:@"name"];
    _indexDataSource = [HCSortString sortForStringAry:[_allDataSource allKeys]];
    _searchDataSource = [NSMutableArray new];
}

- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = YES;
        _searchController.searchBar.placeholder = @"搜索";
        [_searchController.searchBar sizeToFit];
    }
    return _searchController;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!self.searchController.active) {
        return _indexDataSource.count;
    }else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.searchController.active) {
        NSArray *value = [_allDataSource objectForKey:_indexDataSource[section]];
        return value.count;
    }else {
        return _searchDataSource.count;
    }
}
//头部索引标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (!self.searchController.active) {
        return _indexDataSource[section];
    }else {
        return nil;
    }
}
//右侧索引列表
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (!self.searchController.active) {
        return _indexDataSource;
    }else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ModelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ModelCell" forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    if (!self.searchController.active) {
        NSArray *value = [_allDataSource objectForKey:_indexDataSource[indexPath.section]];
        _student = value[indexPath.row];
    }else{
        _student = _searchDataSource[indexPath.row];
    }
    [cell configCellWithModel:_student];
    return cell;
}
//索引点击事件
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return index;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.searchController.active) {
        NSArray *value = [_allDataSource objectForKey:_indexDataSource[indexPath.section]];
        _student = value[indexPath.row];
    }else{
        _student = _searchDataSource[indexPath.row];
    }
    self.block(_student.name);
    self.searchController.active = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UISearchDelegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [_searchDataSource removeAllObjects];
    NSArray *ary = [NSArray new];
    //对排序好的数据进行搜索
    ary = [HCSortString getAllValuesFromDict:_allDataSource];
    
    if (searchController.searchBar.text.length == 0) {
        [_searchDataSource addObjectsFromArray:ary];
    }else {
        ary = [ZYPinYinSearch searchWithOriginalArray:ary andSearchText:searchController.searchBar.text andSearchByPropertyName:@"name"];
        [_searchDataSource addObjectsFromArray:ary];
    }
    [self.tableView reloadData];
}

#pragma mark - block
- (void)didSelectedItem:(SelectedItem)block {
    self.block = block;
}

@end
