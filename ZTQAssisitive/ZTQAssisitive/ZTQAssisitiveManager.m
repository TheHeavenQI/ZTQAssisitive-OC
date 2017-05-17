//
//  ZTQAssisitiveManager.m
//  ZTQAssisitive
//
//  Created by Ztq on 2017/3/21.
//  Copyright © 2017年 jiafakeji. All rights reserved.
//

#import "ZTQAssisitiveManager.h"
#import "ZTQAssisitiveButtonView.h"

NSString *const parentIconIdKey = @"iconIdentifier";
NSString *const parentIconNameKey = @"iconName";
NSString *const parentIconClassKey = @"iconClass";
NSString *const parentIconTitleKey = @"iconTitle";
NSString *const subIconsKey = @"subIcons";

@interface ZTQAssisitiveManager ()

@property (copy, readwrite, nonatomic) NSMutableArray <NSMutableDictionary *> *iconControl;

@end

@implementation ZTQAssisitiveManager

+ (instancetype)assisitiveView {
    static ZTQAssisitiveManager *a;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        a = [[ZTQAssisitiveManager alloc] init];
    });
    return a;
}

+ (void)showAssisitiView {
    [ZTQAssisitiveButtonView showAssisitiView];
}

+ (void)dissmissAssisitiView {
    [ZTQAssisitiveButtonView dissmiss];
}

- (void)addTheParentIconWithId:(NSString *)identifer className:(NSString *)className title:(NSString *)title iconName:(NSString *)iconName {
    
    NSMutableDictionary *dic = @{parentIconIdKey:identifer, parentIconNameKey:iconName, parentIconTitleKey:title}.mutableCopy;
    
    if (className && NSClassFromString(className)) {
        [dic setObject:className forKey:parentIconClassKey];
    }
    [self.iconControl addObject:dic];
    
}

- (void)addTheSubViewIconWithId:(NSString *)identifier parentIdentifier:(NSString *)parentIdentifier className:(NSString *)className title:(NSString *)title iconName:(NSString *)iconName {
    
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    NSDictionary *dic = @{parentIdentifier:identifier,
                          parentIconClassKey:className,
                          parentIconNameKey:iconName,
                          parentIconTitleKey:title};
    
    [self.iconControl enumerateObjectsUsingBlock:^(NSMutableDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([obj isEqualToString:parentIdentifier]) {
                [d setObject:[NSString stringWithFormat:@"%ld", idx] forKey:@"idx"];
                return;
            }
        }];
    }];
    
    if ([d objectForKey:@"idx"]) {
        // 说明父标识符存在
        NSMutableArray *arr = [[self.iconControl objectAtIndex:[[d objectForKey:@"idx"] integerValue]] objectForKey:subIconsKey];
        if (!arr) {
            arr = [NSMutableArray array];
        }
        [arr addObject:dic];
        [[self.iconControl objectAtIndex:[[d objectForKey:@"idx"] integerValue]] setObject:arr forKey:subIconsKey];
    }
    
}

#pragma mark - getter

- (NSMutableArray<NSMutableDictionary *> *)iconControl {
    if (!_iconControl) {
        _iconControl = [NSMutableArray array];
    }
    return _iconControl;
}

@end
