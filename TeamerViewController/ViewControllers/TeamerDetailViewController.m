//
//  TeamerDetailViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamerDetailViewController.h"
#import "TeamerHeadCell.h"
#import "TeamerCenterCell.h"
#import "TeamerBottomCell.h"
#import "TeamerModel.h"
@interface TeamerDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) TeamerModel * model;
@end

@implementation TeamerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    [self creatNullView];
    [self loadData];
}
- (void)creatUI{
    self.tabview = [BYFactory creatTabviewWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT - 64) style:UITableViewStylePlain];
    self.tabview.delegate = self;
    self.tabview.dataSource = self;
    [self.view addSubview:self.tabview];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return self.model.teamerTitles.count;
    }
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return Anno750(480);
    }else if(indexPath.section == 2){
        CGSize size = [BYFactory getSize:self.model.desc maxSize:CGSizeMake(UI_WIDTH - Anno750(80), 99999) font:[UIFont boldSystemFontOfSize:font750(26)]];
        return Anno750(120)+ size.height;
    }
    return Anno750(60);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString * cellid = @"headCell";
        TeamerHeadCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[TeamerHeadCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        [cell updateWithModel:self.model];
        return cell;
    }else if(indexPath.section == 1){
        static NSString * cellid = @"centercell";
        TeamerCenterCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[TeamerCenterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        [cell updateWithTitle:self.model.teamerTitles[indexPath.row] descs:self.model.teamerDescs[indexPath.row]];
        return cell;
    }else if(indexPath.section == 2){
        static NSString * cellid = @"bottomCell";
        TeamerBottomCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell ) {
            cell = [[TeamerBottomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        NSString * title = @"教练介绍";
        if (self.isTeamer) {
            title = @"球员介绍";
        }
        [cell updateWithCate:title descStr:self.model.desc];
        return cell;
    }
    return nil;
}
- (void)loadData{
    NSDictionary * params = @{
                              @"id":self.teamerid,
                              @"is_coach":@(!self.isTeamer)
                              };
    [[NetWorkManger manager]sendRequest:Page_detail route:Route_Team withParams:params complete:^(NSDictionary *result) {
        NSDictionary * dic = result[@"data"];
        TeamerModel * model = [[TeamerModel alloc]initWithDictionary:dic];
        if (self.isTeamer) {
            model.is_coach = @1;
        }else{
            model.is_coach = @0;
        }
        self.model = model;
        [self.tabview reloadData];
        [self nullViewHidden];
    } error:^(BYError *byerror) {
        [self nullviewShow];
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"请求超时,请重试" duration:1.0f];
    }];
}
@end
