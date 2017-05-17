//
//  ZTQAssisitiveButtonView+changeToClose.h
//  ZTQAssisitive
//
//  Created by Ztq on 2017/3/17.
//  Copyright © 2017年 jiafakeji. All rights reserved.
//

#import "ZTQAssisitiveButtonView.h"

#define ZTQObserveNameOfVCShowAndDissAppear @"ZTQNOTIFICATIONFORVCSHOWANDCLOSE"
#define ZTQObserveKey @"observeKey"

@interface ZTQAssisitiveButtonView (changeToClose)

@property (assign, nonatomic) BOOL isChangeTheEvent;

+ (void)configView:(ZTQAssisitiveButtonView *)view;

+ (void)addTheObserveWithTarget:(id)target;

@end
