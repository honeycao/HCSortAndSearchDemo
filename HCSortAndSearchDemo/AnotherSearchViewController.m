//
//  AnotherSearchViewController.m
//
//  Created by Caoyq on 16/3/29.
//  Copyright (c) 2016年 Caoyq. All rights reserved.
//

#import "AnotherSearchViewController.h"
#import "ZYPinYinSearch.h"
#import "HCSortString.h"

#define kScreenWidth        [UIScreen mainScreen].bounds.size.width
#define kScreenHeight       [UIScreen mainScreen].bounds.size.height
#define kColor          [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1];

@interface AnotherSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (strong, nonatomic) UITableView *friendTableView;
@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) NSArray *dataSource;/**<排序前的整个数据源*/
@property (strong, nonatomic) NSDictionary *allDataSource;/**<排序后的整个数据源*/
@property (strong, nonatomic) NSMutableArray *searchDataSource;/**<搜索结果数据源*/
@property (strong, nonatomic) NSArray *indexDataSource;/**<索引数据源*/
@property (assign, nonatomic) BOOL isSearch;

@end

@implementation AnotherSearchViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
    [self.view addSubview:self.friendTableView];
    [self.view addSubview:self.searchBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Init
- (void)initData {
    _dataSource = @[@"九寨沟",@"鼓浪屿",@"香格里拉",@"千岛湖",@"西双版纳",@"+-*/",@"故宫",@"上海科技馆",@"东方明珠",@"外滩",@"CapeTown",@"The Grand Canyon",@"4567.com",@"长江",@"长江1号",@"&*>?",@"弯弯月亮",@"that is it ?",@"山水之间",@"倩女幽魂",@"疆土无边",@"荡秋千"];
    _searchDataSource = [NSMutableArray new];
    
    _allDataSource = [HCSortString sortAndGroupForArray:_dataSource PropertyName:@"name"];
    _indexDataSource = [HCSortString sortForStringAry:[_allDataSource allKeys]];
}

- (UITableView *)friendTableView {
    if (!_friendTableView) {
        _friendTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, kScreenWidth, kScreenHeight-44) style:UITableViewStylePlain];
        _friendTableView.backgroundColor = kColor;
        _friendTableView.delegate = self;
        _friendTableView.dataSource = self;
    }
    return _friendTableView;
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 44)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索";
        _searchBar.showsCancelButton = NO;
    }
    return _searchBar;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!_isSearch) {
        return _indexDataSource.count;
    }else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!_isSearch) {
        NSArray *value = [_allDataSource objectForKey:_indexDataSource[section]];
        return value.count;
    }else {
        return _searchDataSource.count;
    }
}
//头部索引标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (!_isSearch) {
        return _indexDataSource[section];
    }else {
        return nil;
    }
}
//右侧索引列表
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (!_isSearch) {
        return _indexDataSource;
    }else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    if (!_isSearch) {
        NSArray *value = [_allDataSource objectForKey:_indexDataSource[indexPath.section]];
        cell.textLabel.text = value[indexPath.row];
    }else{
        cell.textLabel.text = _searchDataSource[indexPath.row];
    }
    return cell;
}
//索引点击事件
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return index;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_isSearch) {
        NSArray *value = [_allDataSource objectForKey:_indexDataSource[indexPath.section]];
        self.block(value[indexPath.row]);
    }else{
        self.block(_searchDataSource[indexPath.row]);
    }
    [self searchBarCancelButtonClicked:self.searchBar];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [_searchDataSource removeAllObjects];
    NSArray *ary = [HCSortString getAllValuesFromDict:_allDataSource];
    
    if (searchText.length == 0) {
        _isSearch = NO;
        [_searchDataSource addObjectsFromArray:ary];
    }else {
        _isSearch = YES;
        ary = [ZYPinYinSearch searchWithOriginalArray:ary andSearchText:searchText andSearchByPropertyName:@"name"];
        [_searchDataSource addObjectsFromArray:ary];
    }
    [self.friendTableView reloadData];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [UIView animateWithDuration:0.3 animations:^{
        self.navigationController.navigationBarHidden = YES;
        _searchBar.frame = CGRectMake(0, 20, kScreenWidth, 44);
        _searchBar.showsCancelButton = YES;
    }];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    _searchBar.frame = CGRectMake(0, 64, kScreenWidth, 44);
    self.navigationController.navigationBarHidden = NO;
    _searchBar.showsCancelButton = NO;
    [_searchBar resignFirstResponder];
    _searchBar.text = @"";
    _isSearch = NO;
    [_friendTableView reloadData];
}

#pragma mark - block
- (void)didSelectedItem:(SelectedItem)block {
    self.block = block;
}

@end
