//
//  RegisterViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/14.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegitserTableViewCell.h"
#import "MainWebViewController.h"
#import "UserManager.h"
#import "LeftViewController.h"
#import "AppDelegate.h"
#import "HomeViewController.h"
@interface RegisterViewController ()<UITableViewDelegate,UITableViewDataSource,RegitserTableViewCellDelegate>
@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) UIButton * selectBtn;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"注册"];
    [self drawBackButton];
    [self creatBackGroundImage];
    [self creatUI];
}
- (void)creatUI{
    self.tabview = [BYFactory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) style:UITableViewStylePlain];
    self.tabview.delegate = self;
    self.tabview.dataSource = self;
    [self.view addSubview:self.tabview];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(1080);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"registerCell";
    RegitserTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[RegitserTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    self.selectBtn = cell.imageBtn;
    cell.delegate = self;
    return cell;
}
- (void)pushToProtocolViewController{
    MainWebViewController * web = [[MainWebViewController alloc]initWithTitle:@"协议详情" url:@"http://www.fcbayern.cn/terms_and_conditions?app=1" andFromType:FromTypeWeb];
    web.isPush = YES;
    [self.navigationController pushViewController:web animated:YES];
}
- (void)backToLoginViewController{
    [super doBack];
}
- (void)userRegisterWith:(NSString *)userName email:(NSString *)email password:(NSString *)pwd{
    if (!self.selectBtn.selected) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"您还没有同意中国官网服务协议，请阅读后勾选" duration:1.5f];
        return;
    }
    NSDictionary * params = @{
                              @"username":userName,
                              @"password":pwd,
                              @"email":email
                              };
    [[NetWorkManger manager] postRequest:Page_register route:Route_User withParams:params complete:^(NSDictionary *result) {
        NSDictionary * dic = result[@"data"];
        [UserManager manager].user = [[UserModel alloc]initWithDictionary:dic];
        [ToastView presentToastWithin:self.view.window withIcon:APToastIconNone text:@"登陆成功" duration:1.0f];
        AppDelegate * appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        LeftViewController * leftvc = (LeftViewController *)appdelegate.sidePaneVC.leftPanel;
        leftvc.index = self.index;
        if (self.isFromeLeft) {
            leftvc.index = 1;
        }
        [leftvc.tabview reloadData];
        if (self.isFromeLeft) {
            UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:[HomeViewController new]];
            [self.sidePanelController setCenterPanel:nvc];
        }else{
            [super doBack];
        }
    } error:^(BYError *byerror) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:1.0f];
    }];
}
@end
