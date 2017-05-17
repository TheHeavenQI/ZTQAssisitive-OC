//
//  ZTQAssisitiveButtonView.m
//  ZTQAssisitive
//
//  Created by Ztq on 2017/3/15.
//  Copyright © 2017年 jiafakeji. All rights reserved.
//

#import "ZTQAssisitiveButtonView.h"
#import "ZTQAssisitiveDetailView.h"
#import "ZTQAssisitiveButtonView+changeToClose.h"
#import "NSObject+ZTQAdd.h"

@interface ZTQAssisitiveButtonView () <ZTQAssisitiveDetailViewDelegate>

@property (strong, nonatomic) ZTQAssisitiveDetailView *detailView;

@end

@implementation ZTQAssisitiveButtonView

{
    CGFloat _gestureStartX;
    CGFloat _gestureStartY;
}

#pragma mark - public methods

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ZTQObserveNameOfVCShowAndDissAppear object:nil];
}

+ (instancetype)assisitiveView {
    static ZTQAssisitiveButtonView *view;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        view = [[ZTQAssisitiveButtonView alloc] initWithFrame:CGRectMake(0, 80, 40, 40)];
        [self configView:view];
        [self addPanGestureWithView:view];
        [self addTheObserveWithTarget:view];
    });
    
    return view;
}

+ (void)showAssisitiView {
    
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    
    if ([rootWindow.subviews containsObject:[ZTQAssisitiveButtonView assisitiveView]]) {
        return;
    }
    
    [ZTQAssisitiveButtonView assisitiveView].alpha = 0;
    [rootWindow addSubview:[ZTQAssisitiveButtonView assisitiveView]];
    
    [UIView animateWithDuration:0.3 animations:^{
        [ZTQAssisitiveButtonView assisitiveView].alpha = 1;
    }];
}

+ (void)dissmiss {
    if ([ZTQAssisitiveButtonView assisitiveView].superview) {
        
        [UIView animateWithDuration:0.3 animations:^{
            [ZTQAssisitiveButtonView assisitiveView].alpha = 0;
        } completion:^(BOOL finished) {
            [[ZTQAssisitiveButtonView assisitiveView] removeFromSuperview];
        }];
    }
}

#pragma mark - private methods

+ (void)addPanGestureWithView:(ZTQAssisitiveButtonView *)view {
    // pan
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:view action:@selector(panGesture:)];
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:pan];
    
    // tap
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(tapGesture:)];
    [view addGestureRecognizer:tap];
}

- (void)showTheDetailView {
    
    [self.detailView startAnimationToShowTheDetailViewWithAssisitiveViewCenter:self.center finished:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }];
}

#pragma mark -- ZTQAssisitiveDetailViewDelegate

- (void)assisitiveDetailViewDidDissappear {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
        }];
    });
}

#pragma mark - pangesture

- (void)panGesture:(UIPanGestureRecognizer *)gesture {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    CGPoint assisitiveViewFrame = [gesture.view convertPoint:[gesture translationInView:self] toView:window];
    if (gesture.state == UIGestureRecognizerStateChanged) {
        self.frame = CGRectMake(assisitiveViewFrame.x, assisitiveViewFrame.y, 40, 40);
    }
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        
        NSTimeInterval time = 0.8;
        
        if (assisitiveViewFrame.x <= 0) {
            time = 0.5;
        }else if (self.center.x >= (ZTQSCREENWIDTH / 2)) {
            time = (ZTQSCREENWIDTH - assisitiveViewFrame.x) / (ZTQSCREENWIDTH / 2) * 0.5;
        }else if (self.center.x < (ZTQSCREENWIDTH / 2) && assisitiveViewFrame.x > 0) {
            time = assisitiveViewFrame.x / (ZTQSCREENWIDTH / 2) * 0.5;
        }
        
        if (self.center.x >= ZTQADAPTIVEWIDTH(ZTQSCREENWIDTH /2)) {
            [UIView animateWithDuration:time animations:^{
                self.frame = CGRectMake(ZTQSCREENWIDTH - 40, assisitiveViewFrame.y, 40, 40);
            }];
        }else {
            [UIView animateWithDuration:time animations:^{
                self.frame = CGRectMake(0, assisitiveViewFrame.y, 40, 40);
            }];
        }
    }
    [gesture setTranslation:CGPointMake(0, 0) inView:self];
}

#pragma mark - tapgesture

- (void)tapGesture:(UITapGestureRecognizer *)tapGesture {
    if (tapGesture.view == self) {
        
        if (self.isChangeTheEvent) {
            UIViewController *vc = [self findCurrentViewController];
            if (vc) {
                [vc dismissViewControllerAnimated:YES completion:nil];
            }
        }else {
            [self showTheDetailView];
        }
    }
}


#pragma mark - getter

- (ZTQAssisitiveDetailView *)detailView {
    if (!_detailView) {
        _detailView = ({
            ZTQAssisitiveDetailView *v = [[ZTQAssisitiveDetailView alloc] init];
            v.delegate = self;
            v;
        });
    }
    return _detailView;
}

@end
