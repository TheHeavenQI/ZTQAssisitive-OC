//
//  ZTQAssisitiveButtonView+changeToClose.m
//  ZTQAssisitive
//
//  Created by Ztq on 2017/3/17.
//  Copyright © 2017年 jiafakeji. All rights reserved.
//

#import "ZTQAssisitiveButtonView+changeToClose.h"
#import <objc/runtime.h>

@implementation ZTQAssisitiveButtonView (changeToClose)

+ (void)changeTheTouchEvent {
    [self changeTheBackgroundImage];
}

+ (void)configView:(ZTQAssisitiveButtonView *)view {
    view.layer.contents = (__bridge id _Nonnull)[UIImage imageNamed:@"Control.png"].CGImage;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:view.frame.size];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = view.bounds;
    layer.path = path.CGPath;
    view.layer.mask = layer;
}

+ (void)addTheObserveWithTarget:(id)target {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:target selector:@selector(observeWithNotification:) name:ZTQObserveNameOfVCShowAndDissAppear object:nil];
}

+ (void)changeTheBackgroundImage {
    ZTQAssisitiveButtonView *view = [ZTQAssisitiveButtonView assisitiveView];
    view.layer.contents = (__bridge id _Nonnull)[UIImage imageNamed:@"ZTQClose_Assisitive"].CGImage;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:view.frame.size];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = view.bounds;
    layer.path = path.CGPath;
    view.layer.mask = layer;
}

- (void)observeWithNotification:(NSNotification *)notification {
    
    NSDictionary *dic = notification.userInfo;
    
    NSArray *a = dic.allKeys;
    if (![a containsObject:ZTQObserveKey]) {
        return;
    }
    
    BOOL isChange = [[dic objectForKey:ZTQObserveKey] boolValue];
    self.isChangeTheEvent = isChange;
    if (isChange) {
        [ZTQAssisitiveButtonView changeTheTouchEvent];
    }else {
        [ZTQAssisitiveButtonView configView:[ZTQAssisitiveButtonView assisitiveView]];
    }
    
}

- (void)setIsChangeTheEvent:(BOOL)isChangeTheEvent {
    objc_setAssociatedObject(self, _cmd, @(isChangeTheEvent), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)isChangeTheEvent {
    return [objc_getAssociatedObject(self, @selector(setIsChangeTheEvent:)) boolValue];
}

@end
