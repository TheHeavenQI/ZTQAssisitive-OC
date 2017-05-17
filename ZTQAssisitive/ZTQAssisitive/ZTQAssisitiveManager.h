//
//  ZTQAssisitiveManager.h
//  ZTQAssisitive
//
//  Created by Ztq on 2017/3/21.
//  Copyright © 2017年 jiafakeji. All rights reserved.
//

#import <Foundation/Foundation.h>

// 当前icon的标识符
extern NSString * _Nonnull const parentIconIdKey;
// 当前icon的图片 (当前只支持本地包内图片文件)
extern NSString * _Nonnull const parentIconNameKey;
// 当前icon需要展示的类名
extern NSString * _Nonnull const parentIconClassKey;
// 当前icon的文字
extern NSString * _Nonnull const parentIconTitleKey;
// 获取当前icon的子类
extern NSString * _Nonnull const subIconsKey;

@interface ZTQAssisitiveManager : NSObject

/*
 *  iconControl 数据结构：
 *  [
 *      {
 *         parentIconIdKey        : @""
 *         parentIconNameKey      : @""
 *         parentIconClassKey     : @""
 *         parentIconTitleKey     : @""
 *         subIconsKey            : []
 *       },
 *      {
 *         parentIconIdKey        : @""
 *         parentIconNameKey      : @""
 *         parentIconClassKey     : @""
 *         parentIconTitleKey     : @""
 *         subIconsKey            : []
 *      },
 *  ]
 * @pragma subIcons: subIcons 数据结构类似于iconControl (只能获取到自定义添加的icon)
 */

@property (copy, readonly, nonatomic) NSMutableArray <NSMutableDictionary *> * _Nonnull iconControl;

+ (instancetype _Nonnull)assisitiveView;

// 展现AssisitiveView
+ (void)showAssisitiView;

// 隐藏AssisitiveView
+ (void)dissmissAssisitiView;

/*
 *  添加第一层元素
 *  @pragma identifier   需要添加控件的唯一标识符
 *  @pragma className    需要展示的视图 （如果添加了子视图, 不会再显示该视图）
 *  @pragma title        需要展示文字
 *  @pragma iconName     icon的文件名
 *
 */

- (void)addTheParentIconWithId:(NSString * _Nonnull)identifer
                     className:(NSString * _Nullable)className
                         title:(NSString * _Nonnull)title
                      iconName:(NSString * _Nonnull)iconName;

/*
 *  添加第二层元素
 *  @pragma identifier          需要添加控件的唯一标识符
 *  @pragma parentIdentifier    需要添加控件的父标识符
 *  @pragma className           需要展示的视图
 *  @pragma title               需要展示的文字
 *  @pragma iconName            icon的文件名
 *
 */

- (void)addTheSubViewIconWithId:(NSString * _Nonnull)identifier
               parentIdentifier:(NSString * _Nonnull)parentIdentifier
                      className:(NSString * _Nonnull)className
                          title:(NSString * _Nonnull)title
                       iconName:(NSString * _Nonnull)iconName;

@end
