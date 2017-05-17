//
//  ZTQAssisitiveDetailView.m
//  ZTQAssisitive
//
//  Created by Ztq on 2017/3/16.
//  Copyright © 2017年 jiafakeji. All rights reserved.
//

#define DefaultFrameOfTheAssisitiveDetailView [UIScreen mainScreen].bounds
#define DetailsViewTag  23333

#define buttonsLeftSpace 40
#define buttonsRightSpace 40
#define buttonsTopSpace 20
#define buttonsButtomSpace 20
#define buttonsWidth 40
#define buttonsHeigth 60

#import "ZTQAssisitiveDetailView.h"
#import "ZTQAssisitiveInfoViewController.h"
#import "NSObject+ZTQAdd.h"

@interface ZTQAssisitiveDetailView ()

@property (strong, nonatomic) UIButton *nativeLogButton;

@property (strong, nonatomic) UIButton *jsLogButton;

@property (strong, nonatomic) UIButton *batteryButton;

@property (strong, nonatomic) UIButton *memoryButton;

@property (copy, nonatomic) NSArray <UIButton *> *buttonsArray;;

@property (strong, nonatomic) UIView *buttonsBackgroundView;

@end

@implementation ZTQAssisitiveDetailView

{
    CGPoint _assisitiveViewCenter;
    NSInteger _customButtonBaseTag;
}

- (void)dealloc {
    NSLog(@"dealloc");
}

- (instancetype)init {
    return [self initWithFrame:DefaultFrameOfTheAssisitiveDetailView];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _customButtonBaseTag = 4;
        [self configTheAssisitiveDetailViewSubviews];
        
    }
    return self;
}

#pragma mark - private methods

- (void)configTheAssisitiveDetailViewSubviews {
    
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;
    [self addSubview:self.buttonsBackgroundView];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:self];
    
    for (UIButton *btn in self.buttonsArray) {
        [self.buttonsBackgroundView addSubview:btn];
    }
}

- (void)controlTheFrameOfTheSubviewsWithAnimationStart {
    
    self.buttonsBackgroundView.alpha = 0;
    
    self.buttonsBackgroundView.frame = CGRectMake(0, 0, 40, 40);
    self.buttonsBackgroundView.center = CGPointMake(_assisitiveViewCenter.x, _assisitiveViewCenter.y);
    
    for (UIButton *btn in self.buttonsArray) {
        btn.frame = CGRectMake(0, 0, buttonsWidth, buttonsHeigth);
        btn.center = CGPointMake(self.buttonsBackgroundView.bounds.size.width / 2, self.buttonsBackgroundView.bounds.size.height / 2);
        btn.alpha = 0;
    }
}

- (void)controlTheFrameOfTheSubviewsWithAnimationEnd {
    
    self.buttonsBackgroundView.alpha = 1;
    
    self.buttonsBackgroundView.frame = CGRectMake(10, (ZTQSCREENHEIGHT - (ZTQSCREENWIDTH - 20)) / 2, ZTQSCREENWIDTH - 20, ZTQSCREENWIDTH - 20);
    [self showAnimationEnd];
}

- (void)callBackWithViewDidAppear {
    if (self.delegate && [self.delegate respondsToSelector:@selector(assisitiveDetailViewDidAppear)]) {
        [self.delegate assisitiveDetailViewDidAppear];
    }
}

- (void)callBackWithViewDidDissappear {
    if (self.delegate && [self.delegate respondsToSelector:@selector(assisitiveDetailViewDidDissappear)]) {
        [self.delegate assisitiveDetailViewDidDissappear];
    }
}

- (void)showAnimationEnd {
//    CGFloat buttonsViewWidth = self.buttonsBackgroundView.bounds.size.width;
//    CGFloat buttonsViewheight = self.buttonsBackgroundView.bounds.size.height;
//    
//    [self.buttonsArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        
//        obj.frame = CGRectMake(0, 0, buttonsWidth, buttonsHeigth);
//        
//        NSInteger index = idx + 1;
//        
//        if (index % 2 == 1) {
//            obj.center = CGPointMake(buttonsViewWidth / 2, buttonsViewheight /2 + (buttonsViewheight / 2 - buttonsHeigth / 2 - buttonsTopSpace) * (index -2));
//        }else {
//            obj.center = CGPointMake(buttonsViewWidth / 2 + (buttonsViewWidth / 2 - buttonsWidth /2 - buttonsLeftSpace) * (index - 3), buttonsViewheight / 2);
//        }
//        obj.alpha = 1;
//    }];
    if (self.buttonsArray.count == 4) {
        [self fourButtonsView];
    }
}

#pragma mark - four buttons frame

- (void)fourButtonsView {
    CGFloat buttonsViewWidth = self.buttonsBackgroundView.bounds.size.width;
    CGFloat buttonsViewheight = self.buttonsBackgroundView.bounds.size.height;
    [self.buttonsArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.frame = CGRectMake(0, 0, buttonsWidth, buttonsHeigth);
        
        NSInteger index = idx + 1;
        
        if (index % 2 == 1) {
            obj.center = CGPointMake(buttonsViewWidth / 2, buttonsViewheight /2 + (buttonsViewheight / 2 - buttonsHeigth / 2 - buttonsTopSpace) * (index -2));
        }else {
            obj.center = CGPointMake(buttonsViewWidth / 2 + (buttonsViewWidth / 2 - buttonsWidth /2 - buttonsLeftSpace) * (index - 3), buttonsViewheight / 2);
        }
        obj.alpha = 1;
    }];
}

#pragma mark - six buttons frame

#pragma mark - creat custom button

- (UIButton *)customButtonWithInfo:(NSDictionary *)info {
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    [b setTitle:[NSString stringWithFormat:@"%@", [info objectForKey:parentIconTitleKey]] forState:UIControlStateNormal];
    b.tag = DetailsViewTag + _customButtonBaseTag;
    [b addTarget:self action:@selector(buttonsTapEvent:) forControlEvents:UIControlEventTouchUpInside];
    _customButtonBaseTag += 1;
    return b;
}

#pragma mark - public methods

- (void)startAnimationToShowTheDetailViewWithAssisitiveViewCenter:(CGPoint)center finished:(void(^)(BOOL finished))animationFinished {
    
    if (!self.superview) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self];
    }
    
    _assisitiveViewCenter = center;
    
    [self callBackWithViewDidAppear];
    
    [self controlTheFrameOfTheSubviewsWithAnimationStart];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        [self controlTheFrameOfTheSubviewsWithAnimationEnd];
        
    } completion:^(BOOL finished) {
        if (animationFinished) {
            animationFinished(finished);
        }
    }];
}

- (void)startAnimationToCloseTheDetailViewfinished:(void(^)(BOOL finished))animationFinished {
 
    [UIView animateWithDuration:0.5 animations:^{
        [self controlTheFrameOfTheSubviewsWithAnimationStart];
        [self callBackWithViewDidDissappear];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (animationFinished) {
            animationFinished(finished);
        }
    }];
}

#pragma mark touch event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self startAnimationToCloseTheDetailViewfinished:nil];
    
}

- (void)buttonsTapEvent:(UIButton *)button {
    
    ZTQAssisitiveInfoViewController *vc = [[ZTQAssisitiveInfoViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self startAnimationToCloseTheDetailViewfinished:nil];
    
    switch (button.tag) {
        case DetailsViewTag:
            vc.type = AssisitiveButtonTypeNativeLog;
            break;
        case DetailsViewTag + 1:
            vc.type = AssisitiveButtonTypeJSLog;
            break;
        case DetailsViewTag + 2:
            vc.type = AssisitiveButtonTypeBattery;
            break;
        case DetailsViewTag + 3:
            vc.type = AssisitiveButtonTypeMemery;
            break;
        default:
            vc.type = AssisitiveButtonTypeCustom;
            break;
    }
    
    UIViewController *currentVC = [self findCurrentViewController];
    if (!currentVC) {
        return;
    }
    [currentVC presentViewController:nav animated:YES completion:nil];
}


#pragma mark - getter

- (UIView *)buttonsBackgroundView {
    if (!_buttonsBackgroundView) {
        _buttonsBackgroundView = ({
            UIView *v = [[UIView alloc] initWithFrame:CGRectMake(10, (ZTQSCREENHEIGHT - (ZTQSCREENWIDTH - 20)) / 2, ZTQSCREENWIDTH - 20, ZTQSCREENWIDTH - 20)];
            {
                v.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75];
                v.layer.cornerRadius = 20;
            }
            v;
        });
    }
    return _buttonsBackgroundView;
}

- (UIButton *)nativeLogButton {
    if (!_nativeLogButton) {
        _nativeLogButton = ({
            UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
            [b setTitle:@"n" forState:UIControlStateNormal];
            b.tag = DetailsViewTag;
            [b addTarget:self action:@selector(buttonsTapEvent:) forControlEvents:UIControlEventTouchUpInside];
            b;
        });
    }
    return _nativeLogButton;
}

- (UIButton *)jsLogButton {
    if (!_jsLogButton) {
        _jsLogButton = ({
            UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
            [b setTitle:@"j" forState:UIControlStateNormal];
            b.tag = DetailsViewTag + 1;
            [b addTarget:self action:@selector(buttonsTapEvent:) forControlEvents:UIControlEventTouchUpInside];
            b;
        });
    }
    return _jsLogButton;
}

- (UIButton *)batteryButton {
    if (!_batteryButton) {
        _batteryButton = ({
            UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
            [b setTitle:@"b" forState:UIControlStateNormal];
            b.tag = DetailsViewTag + 2;
            [b addTarget:self action:@selector(buttonsTapEvent:) forControlEvents:UIControlEventTouchUpInside];
            b;
        });
    }
    return _batteryButton;
}

- (UIButton *)memoryButton {
    if (!_memoryButton) {
        _memoryButton = ({
            UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
            [b setTitle:@"m" forState:UIControlStateNormal];
            b.tag = DetailsViewTag + 3;
            [b addTarget:self action:@selector(buttonsTapEvent:) forControlEvents:UIControlEventTouchUpInside];
            b;
        });
    }
    return _memoryButton;
}

- (NSArray <UIButton *>*)buttonsArray {
    if (!_buttonsArray) {
        _buttonsArray = ({
            NSArray <UIButton *>*a = @[self.nativeLogButton, self.jsLogButton, self.batteryButton, self.memoryButton];
            a;
        });
    }
    return _buttonsArray;
}

@end
