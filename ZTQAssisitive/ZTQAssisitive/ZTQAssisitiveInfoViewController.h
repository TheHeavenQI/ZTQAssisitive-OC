//
//  ZTQAssisitiveInfoViewController.h
//  ZTQAssisitive
//
//  Created by Ztq on 2017/3/17.
//  Copyright © 2017年 jiafakeji. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AssisitiveButtonType) {
    AssisitiveButtonTypeNativeLog   = 1,
    AssisitiveButtonTypeJSLog,
    AssisitiveButtonTypeBattery,
    AssisitiveButtonTypeMemery,
    AssisitiveButtonTypeCustom,
};

@interface ZTQAssisitiveInfoViewController : UIViewController

@property (assign, nonatomic) AssisitiveButtonType type;

@end
