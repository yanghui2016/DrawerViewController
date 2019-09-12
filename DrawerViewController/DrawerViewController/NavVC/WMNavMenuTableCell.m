//
//  WMNavMenuTableCell.m
//  DrawerViewController
//
//  Created by JunJW on 2019/9/11.
//  Copyright © 2019年 JunJW. All rights reserved.
//

#import "WMNavMenuTableCell.h"

@implementation WMNavMenuTableCell

- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
    }
    return _icon;
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.textColor = [UIColor blackColor];
        _title.font = [UIFont systemFontOfSize:15];
    }
    return _title;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.title];
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(13);
        make.width.height.offset(26);
        make.top.offset(20);
        make.bottom.offset(-20);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(13);
        make.centerY.equalTo(self.icon);
        make.height.offset(20);
    }];
}

@end
