//
//  ZTQAssisitiveDetailView.h
//  ZTQAssisitive
//
//  Created by Ztq on 2017/3/16.
//  Copyright © 2017年 jiafakeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZTQAssisitiveDetailViewDelegate <NSObject>

@required
- (void)assisitiveDetailViewDidDissappear;

@optional
- (void)assisitiveDetailViewDidAppear;

@end

@interface ZTQAssisitiveDetailView : UIView

@property (assign, nonatomic) id<ZTQAssisitiveDetailViewDelegate> delegate;

- (void)startAnimationToShowTheDetailViewWithAssisitiveViewCenter:(CGPoint)center finished:(void(^)(BOOL finished))animationFinished;

- (void)startAnimationToCloseTheDetailViewfinished:(void(^)(BOOL finished))animationFinished;

@end
