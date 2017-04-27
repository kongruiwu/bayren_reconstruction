//
//  UserCenterViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/27.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "UserCenterViewController.h"
#import "UserCenterHeadview.h"
#import "HomeViewController.h"
#import "LeftViewController.h"
#import "UserCenterCell.h"
#import "SetProViewController.h"
#import "SetCityViewController.h"
#import "SetBrithViewController.h"
#import "SetGenerViewController.h"

@interface UserCenterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) UserCenterHeadview * headView;
@property (nonatomic, strong) NSArray * titles;
@property (nonatomic, strong) NSArray * images;
@property (nonatomic, strong) NSArray * descStrs;

@end

@implementation UserCenterViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.descStrs = @[[UserManager manager].user.gender,[UserManager manager].user.birth,[UserManager manager].user.area,[UserManager manager].user.email];
    [self.tabview reloadData];
    [[UserManager manager] getUserInfo];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self setNavUnAlpha];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavAlpha];
    [self creatUI];
    [self drawMainTabItem];
}
- (void)creatUI{
    self.view.backgroundColor = BYColor_Ground;
    
    self.titles = @[@"性    别",@"生    日",@"所 在 地",@"电子邮箱"];
    self.images = @[@"porfile_sex",@"porfile_birthday",@"porfile_location",@"porfile_email"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabview = [BYFactory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT) style:UITableViewStyleGrouped];
    self.tabview.delegate = self;
    self.tabview.dataSource = self;
    [self.view addSubview:self.tabview];
    self.headView = [[UserCenterHeadview alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(460)+ 64)];
    [self.headView updateUI];
    self.tabview.tableHeaderView = self.headView;
    
    [self creatFooterView];
}
- (void)creatFooterView{
    UIView * footer = [BYFactory creatViewWithColor:[UIColor whiteColor]];
    footer.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(88 + 140));

    UIButton * button = [BYFactory creatButtonWithTitle:@"退出登陆"
                                        backGroundColor:[UIColor clearColor]
                                              textColor:BYColor_Tag
                                               textSize:font750(28)];
    [footer addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(590)));
        make.height.equalTo(@(Anno750(88)));
    }];
    [button addTarget:self action:@selector(userLogOut) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = Anno750(44);
    button.layer.borderWidth = 1.0f;
    button.layer.borderColor = BYColor_Line.CGColor;
    self.tabview.tableFooterView = footer;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Anno750(100);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return Anno750(20);
    }
    return 0.001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, Anno750(20))];
        view.backgroundColor = BYColor_Ground;
        return view;
    }
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"UserCenterCell";
    UserCenterCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UserCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (indexPath.row == 3) {
        [cell hideArrowIcon:YES];
    }
    [cell configUIwithTitle:self.titles[indexPath.row] imageName:self.images[indexPath.row] descText:self.descStrs[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self setGenerChoose];
    }else if (indexPath.row == 2) {
        [self.navigationController pushViewController:[SetProViewController new] animated:YES];
    }else if(indexPath.row == 1){
        [self.navigationController pushViewController:[SetBrithViewController new] animated:YES];
    }
    
}
- (void)setGenerChoose{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您正在进行性别修改，您想修改成" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * manAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self setGenerRequestWithSex:@"男"];
    }];
    UIAlertAction * womenAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self setGenerRequestWithSex:@"女"];
    }];
    UIAlertAction * cannceAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:manAction];
    [alert addAction:womenAction];
    [alert addAction:cannceAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)setGenerRequestWithSex:(NSString *)sex{
    NSDictionary * params = @{@"uid":[UserManager manager].user.uid,
                              @"callback_verify":[UserManager manager].token,
                              @"field_name":@"gender",
                              @"field_value":sex};
    [[NetWorkManger manager] sendRequest:Page_ChangeUserInfo route:Route_User withParams:params complete:^(NSDictionary *result) {
        [UserManager manager].user.gender = sex;
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"修改成功" duration:1.0f];
        self.descStrs = @[[UserManager manager].user.gender,[UserManager manager].user.birth,[UserManager manager].user.area,[UserManager manager].user.email];
        [self.tabview reloadData];
    } error:^(BYError *byerror) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:1.0f];
    }];
}
- (void)userLogOut{
    [[NetWorkManger manager] sendRequest:Page_LogOut route:Route_User withParams:@{} complete:^(NSDictionary *result) {
        [UserManager manager].user = nil;
        LeftViewController * leftvc = (LeftViewController *)self.sidePanelController.leftPanel;
        leftvc.index = 1;
        [leftvc.tabview reloadData];
        if (self.isPush) {
            [super doBack];
        }else{
            UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:[HomeViewController new]];
            [self.sidePanelController setCenterPanel:nvc];
        }
    } error:^(BYError *byerror) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"网络请求超时，请重试" duration:1.0f];
    }];
}
@end
