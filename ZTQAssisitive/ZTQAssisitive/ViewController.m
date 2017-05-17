//
//  ViewController.m
//  ZTQAssisitive
//
//  Created by Ztq on 2017/3/15.
//  Copyright © 2017年 jiafakeji. All rights reserved.
//

#import "ViewController.h"
#import "ZTQAssisitiveButtonView.h"

@interface ViewController ()

@end

@implementation ViewController

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super init]) {
        // do something
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addButton];
    [self dissMissButton];
}

#pragma mark - private methods

- (void)dissMissButton {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 60, 30);
    button.center = CGPointMake(self.view.center.x, self.view.center.y);
    button.backgroundColor = [UIColor clearColor];
    [button setTitle:@"移除" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dissmissTheAssisitive) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)addButton {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, 60, 30);
    button.center = CGPointMake(self.view.center.x, self.view.center.y + 40);
    button.backgroundColor = [UIColor clearColor];
    [button setTitle:@"添加" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addTheAssisitive) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

#pragma mark - event

- (void)dissmissTheAssisitive {
    [ZTQAssisitiveManager dissmissAssisitiView];
}

- (void)addTheAssisitive {
    [ZTQAssisitiveManager showAssisitiView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
