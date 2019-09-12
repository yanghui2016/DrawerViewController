//
//  WMDragRootController.m
//  DrawerViewController
//
//  Created by JunJW on 2019/9/11.
//  Copyright © 2019年 JunJW. All rights reserved.
//

#import "WMDragRootController.h"
#import "WMNavMenuMusicController.h"
#import "WMNavMenuController.h"
#import "WMSettingController.h"

@interface WMDragRootController ()

@property (nonatomic ,strong) UINavigationController *nav;

@property (nonatomic ,strong) NSString *isExist;

@end

@implementation WMDragRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WMNavMenuMusicController *musicVc = [[WMNavMenuMusicController alloc]init];
    musicVc.view.backgroundColor = [UIColor orangeColor];
    musicVc.title = @"音乐";
    self.nav = [[UINavigationController alloc]initWithRootViewController:musicVc];
    [self addChildViewController:self.nav];
    [self.rootView addSubview:self.nav.view];
    self.isExist = @"0";
    
    WMNavMenuController *menuVc = [[WMNavMenuController alloc]init];
    [self addChildViewController:menuVc];
    [self.navView addSubview:menuVc.view];
    
    WMSettingController *settingVc = [[WMSettingController alloc]init];
    [self addChildViewController:settingVc];
    [self.settingView addSubview:settingVc.view];
    
    // 添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedMenu:) name:@"MenuViewControllerSelectedItem" object:nil];
}

- (void)selectedMenu:(NSNotification *)obj {
    
    NSDictionary *dict = obj.object;
    NSLog(@"%@",dict);
    
    if (![dict[@"isExist"] isEqualToString:self.isExist]) {
        // 替换导航的根视图
        // 使用通知中的className来创建视图控制器
        UIViewController *vc = [[NSClassFromString(dict[@"className"]) alloc] init];
        vc.title = dict[@"title"];
        // 更改nav的根视图控制器
        self.isExist = dict[@"isExist"];
        self.nav.viewControllers = @[vc];
    }
    [self resetLocation];
}

@end
