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
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"出现了");
        [ZTQAssisitiveButtonView showAssisitiView];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
