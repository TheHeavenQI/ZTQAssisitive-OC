//
//  ZTQAssisitiveInfoViewController.m
//  ZTQAssisitive
//
//  Created by Ztq on 2017/3/17.
//  Copyright © 2017年 jiafakeji. All rights reserved.
//

#import "ZTQAssisitiveInfoViewController.h"
#import "ZTQAssisitiveButtonView+changeToClose.h"
#import "ZTQASL.h"
#import "AssisitiveTableView.h"

@interface ZTQAssisitiveInfoViewController ()

@property (strong, nonatomic) AssisitiveTableView *tableView;

@end

@implementation ZTQAssisitiveInfoViewController

{
    BOOL _notificationValue;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self navLeft];
    [self configTheDebugViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _notificationValue = YES;
    [self postNotification];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _notificationValue = NO;
    [self postNotification];
}

#pragma mark - private methods

- (void)navLeft {
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(backButton)];
    [self.navigationItem setLeftBarButtonItem:left];
}

- (void)postNotification {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:ZTQObserveNameOfVCShowAndDissAppear object:nil userInfo:@{ZTQObserveKey: @(_notificationValue)}];
}

- (void)configTheDebugViews {
    
    switch (self.type) {
        case AssisitiveButtonTypeNativeLog:
            break;
        case AssisitiveButtonTypeJSLog:
            break;
        case AssisitiveButtonTypeBattery:
            break;
        case AssisitiveButtonTypeMemery:
            break;
        case AssisitiveButtonTypeCustom:
            break;
        default:
            break;
    }
    [self.view addSubview:self.tableView];
    NSMutableArray <NSString *> *arr = [NSMutableArray array];
    
    [[ZTQASL allLogMessagesForCurrentProcess] enumerateObjectsUsingBlock:^(SystemLogMessage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [arr addObject:[obj displayedTextForLogMessage]];
    }];
    
    [self.tableView updateTheDataSource:arr];
}

#pragma mark - callBack and event



- (void)backButton {
    _notificationValue = NO;
    [self postNotification];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getter

- (AssisitiveTableView *)tableView {
    if (!_tableView) {
        _tableView = ({
            AssisitiveTableView *view = [[AssisitiveTableView alloc] init];
            view;
        });
    }
    return _tableView;
}

#pragma mark memory waring

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
