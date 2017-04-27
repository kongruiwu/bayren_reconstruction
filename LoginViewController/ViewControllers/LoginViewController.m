//
//  LoginViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/5.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "LoginViewController.h"
#import "LogModelCell.h"
#import "FindPwdViewController.h"
#import "RegisterViewController.h"
#import "UserManager.h"
#import "LeftViewController.h"
#import "HomeViewController.h"
@interface LoginViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) RACSubject * subject;
@property (nonatomic, strong) UITextField * nameT;
@property (nonatomic, strong) UITextField * pwdTextf;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationTitle:@"登录"];
    [self drawMainTabItem];
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
    return Anno750(940);
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellid = @"logModelCell";
    LogModelCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[LogModelCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.subJect = [RACSubject subject];
    @weakify(self);
    [cell.subJect subscribeNext:^(NSString * str) {
        @strongify(self);
        if ([str isEqualToString:@"找回密码"]) {
            FindPwdViewController * vc = [FindPwdViewController new];
            vc.isPresent = self.isPresent;
            [self.navigationController pushViewController:vc animated:YES];
        }else if([str isEqualToString:@"注册"]){
            RegisterViewController * vc = [RegisterViewController new];
            vc.isPresent = self.isPresent;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
    self.nameT = cell.nameTextf;
    self.pwdTextf = cell.pwdTextf;
    [cell.loginButton addTarget:self action:@selector(userLogin) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)userLogin{
    [self.view endEditing:YES];
    
    NSDictionary * params = @{
                              @"username":self.nameT.text,
                              @"password":self.pwdTextf.text
                              };
    [[NetWorkManger manager] sendRequest:Page_login route:Route_User withParams:params complete:^(NSDictionary *result) {
        NSDictionary * dic = result[@"data"];
        [UserManager manager].user = [[UserModel alloc]initWithDictionary:dic];
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"登陆成功" duration:1.0f];
        LeftViewController * leftvc = (LeftViewController *)self.sidePanelController.leftPanel;
        leftvc.index = 1;
        [leftvc.tabview reloadData];
        if (self.isPresent) {
            [super doBack];
        }else{
            UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:[HomeViewController new]];
            [self.sidePanelController setCenterPanel:nvc];
        }
    } error:^(BYError *byerror) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:2.0f];
    }];
}

@end
