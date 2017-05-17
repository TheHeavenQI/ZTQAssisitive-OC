//
//  AssisitiveTableView.m
//  ZTQAssisitive
//
//  Created by Ztq on 2017/3/18.
//  Copyright © 2017年 jiafakeji. All rights reserved.
//

#import "AssisitiveTableView.h"

static NSString *assisitiveTableViewCellIdentifier = @"assisitiveTableViewCellIdentifier";

@interface AssisitiveTableView () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *dataSourceOfTableView;

@end


@implementation AssisitiveTableView

- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame style:UITableViewStylePlain];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self configTheDataSourceAndDelegate];
    }
    return self;
}

#pragma mark public methods

- (void)updateTheDataSource:(NSArray<NSString *> *)dataSource {
    
    if (dataSource.count == 0) {
        return;
    }
    self.dataSourceOfTableView = dataSource.mutableCopy;
    
    [self reloadData];
}

#pragma mark private methods

- (void)configTheDataSourceAndDelegate {
    
    self.dataSource = self;
    self.delegate = self;
    self.backgroundColor = [UIColor whiteColor];
    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:assisitiveTableViewCellIdentifier];
}

#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceOfTableView.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:assisitiveTableViewCellIdentifier];
    if ([self.dataSourceOfTableView[indexPath.row] length] == 0) {
        cell.textLabel.text = self.dataSourceOfTableView[indexPath.row];
    }
    cell.textLabel.text = self.dataSourceOfTableView[indexPath.row];
    [cell.textLabel sizeToFit];
    return cell;
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
