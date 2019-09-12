//
//  WMDrawerViewController.m
//  DrawerViewController
//
//  Created by JunJW on 2019/9/11.
//  Copyright © 2019年 JunJW. All rights reserved.
//

#import "WMDrawerViewController.h"

#define kMaxOffsetY 100.0
#define kMaxRightX 280.0
#define kMaxLeftX  -220.0

typedef enum : NSUInteger {
    DragTypeDraging,
    DragTypeDragEnd
} DragType;

@interface WMDrawerViewController ()

/**
 *拖动状态
 */
@property (nonatomic ,assign) DragType dragType;

/**
 *是否正在动画
 */
@property (nonatomic, assign, getter=isAnimation) BOOL isAnimation;

@end

@implementation WMDrawerViewController

- (void)loadView {
    self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UIImageView *rootBgimg = [[UIImageView alloc]initWithFrame:self.view.bounds];
    rootBgimg.image = [UIImage imageNamed:@"Rectangle"];
    [self.view addSubview:rootBgimg];
    
    //设置视图
    self.settingView = [[UIView alloc]initWithFrame:self.view.bounds];
    self.settingView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.settingView];
    
    //导航视图
    self.navView = [[UIView alloc]initWithFrame:self.view.bounds];
    self.navView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.navView];
    
    self.rootView = [[UIView alloc]initWithFrame:self.view.bounds];
    self.rootView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.rootView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

// 修改状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    return  UIStatusBarStyleDefault;
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    //rootView监听frame改变
    [self.rootView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    // 如果用动画来设置frame，KVO不会调整视图
    if (self.isAnimation) {
        return;
    }
    
    // self.rootView.frame.origin.x > 0  向右滑动
    if(self.rootView.frame.origin.x > 0){
        // 显示导航视图
        self.navView.hidden = NO;
        self.settingView.hidden = YES;
    } else {
        // 显示设置视图
        self.navView.hidden = YES;
        self.settingView.hidden = NO;
    }
}

#pragma mark - 触摸事件

/**
 使用偏移的X值，来计算主视图目标的位置frame
 */
- (CGRect)rectWithOffsetX:(CGFloat)x {
    // 窗口大小
    CGSize windowSize = [UIScreen mainScreen].bounds.size;

    //计算Y
    CGFloat y = x * kMaxOffsetY / windowSize.width;
    //计算缩放的比例大小
    CGFloat scale = (windowSize.height - 2 * y) / windowSize.height;
    //x<0时,计算的scale大于1;
    if (self.rootView.frame.origin.x < 0) {
        scale = 2 - scale;
    }
    
    //根据缩放的比例来计算rootView的新的frame
    CGRect newFrame = self.rootView.frame;
    //用缩放的比例来计算宽高
    newFrame.size.width = newFrame.size.width * scale;
    newFrame.size.height = newFrame.size.height * scale;
    newFrame.origin.x += x;
    newFrame.origin.y = (windowSize.height - newFrame.size.height) * 0.5;
    
    return newFrame;
}

/**
 拖动事件
 */
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 记录拖动状态
    self.dragType = DragTypeDraging;
    NSLog(@"%ld",touches.allObjects.firstObject.type);
    //取出触摸
    UITouch *touch = touches.anyObject;
    //取出当前的触摸点
    CGPoint currentLocation = [touch locationInView:self.view];
    //取出之前的触摸点
    CGPoint previouLocation = [touch previousLocationInView:self.view];
    //计算水平的偏移量
    CGFloat offsetX = currentLocation.x - previouLocation.x;
    //设置视图的位置
    self.rootView.frame = [self rectWithOffsetX:offsetX];
}

// 抬起手指时，让主视图定位
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //点击关闭抽屉模式,恢复原位置
    if (self.dragType == DragTypeDragEnd && self.rootView.frame.origin.x != 0) {
        [self resetLocation];
        return;
    }
    
    //当 frame.origin.x > windowSize * 0.3,让主视图移动到右边(要用到目标的X值)
    //当 CGRectGetMaxX(frame) < windowSize * 0.7,让主视图移动到左边(要用到目标的X值)
    CGRect frame = self.rootView.frame;
    CGSize windowSize = [UIScreen mainScreen].bounds.size;
    
    CGFloat targetX = 0;
    if (frame.origin.x > windowSize.width * 0.5){
        targetX = kMaxRightX;
    } else if(CGRectGetMaxX(frame) < windowSize.width * 0.5) {
        targetX = kMaxLeftX;
    }
    // 计算出水平的偏移量
    CGFloat offsetX = targetX - frame.origin.x;
    
    self.isAnimation = YES;
    [UIView animateWithDuration:0.25 animations:^{
        if (targetX != 0){
            self.rootView.frame = [self rectWithOffsetX:offsetX];
        } else {
            self.rootView.frame = self.view.bounds;
        }
    } completion:^(BOOL finished) {
        self.dragType = DragTypeDragEnd;
        self.isAnimation = NO;
    }];
}

// 恢复原来的位置
- (void)resetLocation {
    self.isAnimation = YES;
    [UIView animateWithDuration:0.25 animations:^{
        
        self.rootView.frame = self.view.bounds;
    } completion:^(BOOL finished) {
        self.isAnimation = NO;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
