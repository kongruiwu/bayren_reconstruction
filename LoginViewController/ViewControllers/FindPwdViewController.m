//
//  FindPwdViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/14.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "FindPwdViewController.h"
#import "FindPwdTableViewCell.h"
@interface FindPwdViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) UITextField * emailT;
@property (nonatomic, strong) UITextField * nameT;
@end

@implementation FindPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"找回密码"];
    [self creatBackGroundImage];
    [self drawBackButton];
    [self creatUI];
}
- (void)creatUI{
    self.tabview = [BYFactory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) style:UITableViewStylePlain];
    self.tabview.delegate = self;
    self.tabview.dataSource = self;
    [self.view addSubview:self.tabview];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(880);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"findpwdCell";
    FindPwdTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[FindPwdTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    self.nameT = cell.nameTextf;
    self.emailT = cell.emailTextf;
    [cell.findButton addTarget:self action:@selector(sendRequest) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)sendRequest{
    NSDictionary * dic = @{
                           @"email":self.emailT.text,
                           @"username":self.nameT.text
                           };
    [[NetWorkManger manager] sendRequest:Page_GetRecode route:Route_User withParams:dic complete:^(NSDictionary *result) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"验证邮件已发送至您的邮箱，请查收!" duration:2.0f];
    } error:^(BYError *byerror) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:1.0f];
    }];
}
@end
