//
//  WMDrawerViewController.h
//  DrawerViewController
//
//  Created by JunJW on 2019/9/11.
//  Copyright © 2019年 JunJW. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WMDrawerViewController : UIViewController

@property (nonatomic ,strong) UIView *rootView;
@property (nonatomic ,strong) UIView *settingView;
@property (nonatomic ,strong) UIView *navView;

- (void)resetLocation;

@end

NS_ASSUME_NONNULL_END
