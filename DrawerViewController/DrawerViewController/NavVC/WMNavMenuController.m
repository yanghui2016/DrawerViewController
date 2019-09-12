//
//  WMNavMenuController.m
//  DrawerViewController
//
//  Created by JunJW on 2019/9/11.
//  Copyright © 2019年 JunJW. All rights reserved.
//

#import "WMNavMenuController.h"
#import "WMNavMenuTableCell.h"

@interface WMNavMenuController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *myTableView;

@property (nonatomic ,strong) NSArray *headTitleArr;
@property (nonatomic ,strong) NSArray *headImageArr;

@property (nonatomic ,strong) NSArray *menuVcListArr;

@end

@implementation WMNavMenuController

- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.estimatedRowHeight = 200;
        _myTableView.rowHeight = UITableViewAutomaticDimension;
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.bounces = NO;
    }
    return _myTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.menuVcListArr = @[@"WMNavMenuMusicController",@"WMNavMenuNewController",@"WMNavMenuFocusController",];
    self.headTitleArr = @[@"音乐",@"新闻",@"关注"];
    self.headImageArr = @[@"sidebar_nav_audio",@"sidebar_nav_news",@"sidebar_nav_focus"];
    
    [self setupUI];
}

- (void)setupUI {
    [self.view addSubview:self.myTableView];
    if (@available(iOS 11.0, *)) {
        UITableView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.centerY.equalTo(self.view);
        make.height.offset(66*self.headTitleArr.count);
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *className = self.menuVcListArr[indexPath.row];
    
    NSDictionary *dict = @{
                           @"className":className,
                           @"isExist":[NSString stringWithFormat:@"%ld",indexPath.row],
                           @"title":self.headTitleArr[indexPath.row]
                           };
    
    // 发送通知 切换控制器
    [[NSNotificationCenter defaultCenter]postNotificationName:@"MenuViewControllerSelectedItem" object:dict];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.headTitleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *UITableViewCellID = @"UITableViewCellID";
    WMNavMenuTableCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCellID];
    if (!cell) {
        cell = [[WMNavMenuTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:UITableViewCellID];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.icon.image = [UIImage imageNamed:self.headImageArr[indexPath.row]];
    cell.title.text = self.headTitleArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CGFLOAT_MIN)];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CGFLOAT_MIN)];
    return view;
}

@end
