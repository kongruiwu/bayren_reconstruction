//
//  SettingViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingCell.h"
#import "ChagePwdViewController.h"
@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, strong) NSArray * descs;
@property (nonatomic, strong) NSArray * bools;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"设置"];
    [self drawMainTabItem];
    [self creatUI];
    [self creatNullView];
}
- (void)creatUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self reloadData];
    self.tabview = [BYFactory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) style:UITableViewStylePlain];
    self.tabview.delegate = self;
    self.tabview.dataSource = self;
    [self.view addSubview:self.tabview];
    [self creatFootView];
}
- (void)reloadData{
    self.titles = @[@"修改密码",@"清除缓存",@"版本"];
    SDImageCache *cache = [SDImageCache sharedImageCache];
    NSUInteger cachesize = [cache getSize];
    NSString *stringInt = [NSString stringWithFormat:@"%lu",(unsigned long)cachesize];
    CGFloat foa = [stringInt floatValue]/1024/1024;
    if (cachesize<1.0) {
        stringInt = [NSString stringWithFormat:@"%0.1f KB",foa * 1000];
    }else{
        stringInt = [NSString stringWithFormat:@"%0.2f MB", foa];
    }
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    self.descs = @[@"",stringInt,appVersion];
    self.bools = @[@0,@0,@1];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(88);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"settingCell";
    SettingCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[SettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    [cell updateWithTitle:self.titles[indexPath.row] desc:self.descs[indexPath.row] rec:[self.bools[indexPath.row] boolValue]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        [[SDImageCache sharedImageCache] clearMemory];
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:@"缓存已清除" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:sureAction];
            [self presentViewController:alert animated:YES completion:nil];
            [self reloadData];
            [self.tabview reloadData];
        }];
    }else if(indexPath.row == 0){
        [self.navigationController pushViewController:[ChagePwdViewController new] animated:YES];
    }
}
- (void)creatFootView{
    BOOL rec = [self isAllowedNotification];
    UIView * view = [BYFactory creatViewWithColor:[UIColor whiteColor]];
    if (rec) {
        view.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(100));
    }else{
        view.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(130));
    }
    NSString * status = @"已关闭";
    if (rec) {
        status = @"已开启";
    }
    UILabel * titleLabel = [BYFactory creatLabelWithText:@"消息通知"
                                               fontValue:font750(28)
                                               textColor:BYColor_Title
                                           textAlignment:NSTextAlignmentLeft];
    UILabel * descLabel = [BYFactory creatLabelWithText:@"请在手机“设置”-“通知”中修改"
                                              fontValue:font750(26)
                                              textColor:BYColor_Tag textAlignment:NSTextAlignmentLeft];
    UILabel * statusLabel = [BYFactory creatLabelWithText:status
                                                fontValue:font750(30)
                                                textColor:BYColor_Tag
                                            textAlignment:NSTextAlignmentRight];
    UIView * line = [BYFactory creatLineView];
    [view addSubview:titleLabel];
    [view addSubview:descLabel];
    [view addSubview:statusLabel];
    [view addSubview:line];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        if (rec) {
            make.centerY.equalTo(@0);
        }else{
            make.top.equalTo(@(Anno750(25)));
        }
    }];
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.centerY.equalTo(@0);
    }];
    [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.top.equalTo(titleLabel.mas_bottom).offset(Anno750(10));
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
    self.tabview.tableFooterView = view;

}

#pragma mark - 检测是否开启推送服务
-(BOOL)isAllowedNotification
{
    if ([self isSystemVersioniOS8]) {// system is iOS8
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone != setting.types) {
            return YES;
        }
    } else {//iOS7
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if(UIRemoteNotificationTypeNone != type)
            return YES;
    }
    return NO;
}
-(BOOL)isSystemVersioniOS8
{
    UIDevice *device = [UIDevice currentDevice];
    float sysVersion;
    sysVersion = [device.systemVersion floatValue];
    if (sysVersion >= 8.0f) {
        return YES;
    }
    return NO;
}
@end
