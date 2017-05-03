//
//  RightViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/24.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "RightViewController.h"
#import "FixtureTableViewCell.h"
#import "RightStandingCell.h"
#import "RightHeadScoreCell.h"
#import "RightStandModel.h"
#import "FixtureModel.h"
#import "FixtureViewController.h"
#import "ScoresViewController.h"
#import "NewsDetailViewController.h"
#import "PhotoDetailViewController.h"

#import "AppDelegate.h"
#import "StandingViewController.h"
#import "FixtureViewController.h"
@interface RightViewController ()<UITableViewDelegate,UITableViewDataSource,FixtureCellDelegate>

@property (nonatomic, strong) UITableView * tabview;
//积分
@property (nonatomic, strong) NSMutableArray * standings;
//赛程
@property (nonatomic, strong) NSMutableArray * matchs;
@end

@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    [self requestData];
}
- (void)creatUI{
    self.view.backgroundColor = [UIColor blackColor];
    self.standings = [NSMutableArray new];
    self.matchs = [NSMutableArray new];
    self.tabview = [BYFactory creatTabviewWithFrame:CGRectMake(UI_WIDTH * 0.1, 0, UI_WIDTH * 0.9, UI_HEGIHT) style:UITableViewStyleGrouped];
    self.tabview.delegate = self;
    self.tabview.dataSource = self;
    [self.view addSubview:self.tabview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (self.matchs.count>2) {
            return 2;
        }else{
            return self.matchs.count;
        }
    }
    return self.standings.count+1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return Anno750(400);
    }
    return Anno750(100);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return Anno750(120);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Anno750(128);
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString * title = @"比赛中心";
    if (section == 1) {
        title = @"积分榜";
    }
    UIView * headView = [BYFactory creatViewWithColor:[UIColor clearColor]];
    headView.frame = CGRectMake(0, 0, UI_WIDTH * 0.9, Anno750(128));
    UILabel * titleLabel = [BYFactory creatLabelWithText:title fontValue:font750(30)
                                               textColor:BYColor_Main textAlignment:NSTextAlignmentCenter];
    titleLabel.font = [UIFont boldSystemFontOfSize:font750(32)];
    [headView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(@(10));
    }];
    UIView * line = [BYFactory creatViewWithColor:BYColor_Main];
    [headView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@1);
    }];
    return headView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * footer = [BYFactory creatViewWithColor:[UIColor clearColor]];
    NSString * title = @"查看完整积分榜";
    if (section == 0) {
        title = @"查看完整赛程";
    }
    UIButton * button = [BYFactory creatButtonWithTitle:title
                                        backGroundColor:[UIColor clearColor] textColor:BYColor_Main
                                               textSize:font750(30)];
    [button addTarget:self action:@selector(footerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = Anno750(30);
    button.layer.borderColor = BYColor_Main.CGColor;
    button.layer.borderWidth = 1.0f;
    [footer addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(@0);
        make.height.equalTo(@(Anno750(60)));
        make.width.equalTo(@(Anno750(340)));
    }];
    
    footer.frame = CGRectMake(0, 0, UI_WIDTH * 0.9, Anno750(90));
    return footer;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString * cellid = @"matchCell";
        FixtureTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[FixtureTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        [cell cellUpdateWithModel:self.matchs[indexPath.row]];
        [cell updateTheColor];
        cell.delegtae = self;
        return cell;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {//RightHeadScoreCell
            static NSString * headCell = @"headCell";
            RightHeadScoreCell * cell = [tableView dequeueReusableCellWithIdentifier:headCell];
            if (cell == nil) {
                cell = [[RightHeadScoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headCell];
            }
            return cell;
        }else{
            static NSString * cellid = @"standingcell";
            RightStandingCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (!cell) {
                cell = [[RightStandingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
            }
            [cell updateWithTeamRankModel:self.standings[indexPath.row -1]];
            
            return cell;
        }
    }
    return nil;
}
- (void)requestData{
    
    [[NetWorkManger manager] sendRequest:Page_Right_Rank route:Route_Fixture withParams:@{} complete:^(NSDictionary *result) {
        NSArray * arr = result[@"data"];
        for (int i = 0; i<arr.count; i++) {
            NSDictionary * dic = arr[i];
            RightStandModel * model = [[RightStandModel alloc]initWithDictionary:dic];
            [self.standings addObject:model];
        }
        [self.tabview reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
    } error:^(BYError *byerror) {
        
    }];
    
    [[NetWorkManger manager] sendRequest:Page_Right_Sched route:Route_Fixture withParams:@{} complete:^(NSDictionary *result) {
        NSArray * arr = result[@"data"];
        for (int i = 0; i<arr.count; i++) {
            NSDictionary * dic = arr[i];
            FixtureModel * model = [[FixtureModel alloc]initWithDictionary:dic];
            [self.matchs addObject:model];
        }
        [self.tabview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    } error:^(BYError *byerror) {
        
    }];
}
- (void)checkNewsDetail:(NSNumber *)newsid{
    NewsDetailViewController * vc = [[NewsDetailViewController alloc]initWithNewsid:newsid];
    vc.backType = SelectorBackTypeDismiss;
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController * vc1 = delegate.sidePaneVC.centerPanel;
    [vc1 presentViewController:[[UINavigationController alloc]initWithRootViewController:vc] animated:YES completion:nil];
}
- (void)checkPicsDetail:(NSNumber *)picid{
    PhotoDetailViewController * vc = [[PhotoDetailViewController alloc]initWithPhotoDetailid:picid];
    vc.backType = SelectorBackTypeDismiss;
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController * vc1 = delegate.sidePaneVC.centerPanel;
    [vc1 presentViewController:[[UINavigationController alloc]initWithRootViewController:vc] animated:YES completion:nil];
//    if ([vc1 isKindOfClass:[UINavigationController class]]) {
//        [(UINavigationController *)vc1 pushViewController:vc animated:NO];
//        [delegate.sidePaneVC showCenterPanelAnimated:YES];
//    }
}
- (void)footerButtonClick:(UIButton *)btn{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController * vc = delegate.sidePaneVC.centerPanel;
    if ([btn.titleLabel.text isEqualToString:@"查看完整积分榜"]) {
        StandingViewController * score = [StandingViewController new];
        score.isPush = YES;
        score.backType = SelectorBackTypeDismiss;
        [vc presentViewController:[[UINavigationController alloc] initWithRootViewController:score] animated:YES completion:nil];
    }else{
        FixtureViewController * fix = [FixtureViewController new];
        fix.isPush = YES;
        fix.backType = SelectorBackTypeDismiss;
        [vc presentViewController:[[UINavigationController alloc] initWithRootViewController:fix] animated:YES completion:nil];
    }
    
    
    

}
@end
