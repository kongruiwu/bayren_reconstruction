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
@interface LoginViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) RACSubject * subject;
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
            [self.navigationController pushViewController:[FindPwdViewController new] animated:YES];
        }else if([str isEqualToString:@"注册"]){
            [self.navigationController pushViewController:[RegisterViewController new] animated:YES];
        }
    }];
    return cell;
}


@end
