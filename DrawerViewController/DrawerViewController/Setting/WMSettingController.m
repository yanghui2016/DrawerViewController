//
//  WMSettingController.m
//  DrawerViewController
//
//  Created by JunJW on 2019/9/11.
//  Copyright © 2019年 JunJW. All rights reserved.
//

#import "WMSettingController.h"
#import "Masonry.h"

@interface WMSettingController ()

@property (nonatomic ,strong) UIImageView *icon;
@property (nonatomic ,strong) UILabel *name;

@end

@implementation WMSettingController

- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
        _icon.image = [UIImage imageNamed:@"header"];
    }
    return _icon;
}

- (UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc]init];
        _name.textColor = [UIColor blackColor];
        _name.font = [UIFont systemFontOfSize:15];
        _name.text = @"iOS开发者";
    }
    return _name;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.icon];
    [self.view addSubview:self.name];
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.offset(64+16);
        make.width.height.offset(50);
    }];
    
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(8);
        make.centerY.equalTo(self.icon);
    }];
}

@end
