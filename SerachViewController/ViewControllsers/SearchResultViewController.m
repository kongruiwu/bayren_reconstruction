//
//  SearchResultViewController.m
//  Bayern
//
//  Created by 吴孔锐 on 16/9/26.
//  Copyright © 2016年 Wusicong. All rights reserved.
//

#import "SearchResultViewController.h"
#import "SeachBar.h"
#import "SearchResultModel.h"
#import "SearchInfoModel.h"
#import "VideoListTableViewCell.h"
#import "NewsListTableViewCell.h"
#import "PhotoListTableViewCell.h"
#import "NewsDetailViewController.h"
#import "MainWebViewController.h"
#import "PhotoDetailViewController.h"

@interface SearchResultViewController()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) UITableView * tabview;
@property (nonatomic, strong) UITableView * cateTab;//搜索种类所在tab
@property (nonatomic, strong) SeachBar * searchView;
@property (nonatomic, strong) NSMutableArray<SearchResultModel *> * resultArray;
@property (nonatomic, strong) SearchInfoModel * infoModel;
@property (nonatomic, strong) NSMutableArray * cateArray;

@end
@implementation SearchResultViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setFristValue];
    [self creatUI];
    [self RefreshSetting];
    [self creatNullView];
    [self loadData];
}
- (void)setFristValue{
    self.cateArray = [NSMutableArray new];
    NSArray * types = @[@"news",@"video",@"album"];
    NSArray * names = @[@"新闻",@"视频",@"图集"];
    NSArray * images = @[@"search_news",@"search_videos",@"search_fixtures"];
    NSArray * selects = @[@0,@0,@0];
    for (int i = 0; i<names.count; i++) {
        SearchCateModel * model = [[SearchCateModel alloc]init];
        model.name = names[i];
        model.imageName = images[i];
        model.type = types[i];
        model.isSelect = [selects[i] boolValue];
        if ([model.name isEqualToString:self.searchTypeModel.name]) {
            model.isSelect = YES;
        }
        [self.cateArray addObject:model];
    }
}
- (void)creatUI{
    
    self.resultArray = [NSMutableArray new];
    self.infoModel = [[SearchInfoModel alloc]init];
    self.infoModel.search_count = @0;
    self.cateTab = [BYFactory creatTabviewWithFrame:CGRectMake(Anno750(30), 0, Anno750(170), 0) style:UITableViewStylePlain];
    self.cateTab.scrollEnabled = NO;
    self.cateTab.delegate = self;
    self.cateTab.dataSource = self;
    [self.view addSubview:self.cateTab];
    
    self.searchView = [[SeachBar alloc]init];
    [self.searchView.cateButton setTitle:self.searchTypeModel.name forState:UIControlStateNormal];
    self.searchView.frame = CGRectMake(0, 0, Anno750(600), Anno750(60));
    self.searchView.searchTF.returnKeyType = UIReturnKeySearch;
    self.searchView.searchTF.delegate = self;
    self.searchView.searchTF.text = self.searchWord;
    UIBarButtonItem * leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:self.searchView];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    [self.searchView.cateButton  addTarget:self action:@selector(showCateTab) forControlEvents:UIControlEventTouchUpInside];
    self.backType = SelectorBackTypePoptoRoot;
    UIBarButtonItem * rightBarBtn = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(doBack)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    
    self.tabview = [BYFactory creatTabviewWithFrame:CGRectMake(0, 0,UI_WIDTH,UI_HEGIHT - 64) style:UITableViewStyleGrouped];
    self.tabview.delegate = self;
    self.tabview.dataSource = self;
    [self.view addSubview:self.tabview];
    [self.view bringSubviewToFront:self.cateTab];
    self.refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    self.tabview.mj_header = self.refreshHeader;
    self.tabview.mj_footer = self.refreshFooter;

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView == self.tabview && section != self.resultArray.count -1 && [self.resultArray[0].cont_type intValue] == 2) {
        return Anno750(16);
    }
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.tabview && section == 0) {
        return Anno750(80);
    }
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.tabview && section== 0) {
        UIView * headerView = [BYFactory creatViewWithColor:BYColor_Ground];
        headerView.frame = CGRectMake(0, 0, UI_WIDTH, Anno750(80));
        UILabel * headLabel = [BYFactory creatLabelWithText:[NSString stringWithFormat:@"为您找到相关结果%@条",self.infoModel.search_count]
                                                  fontValue:font750(30)
                                                  textColor:BYColor_gray_6
                                              textAlignment:NSTextAlignmentLeft];
        [headerView addSubview:headLabel];
        [headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(Anno750(20)));
            make.centerY.equalTo(@0);
        }];
        return headerView;
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.cateTab) {
        return self.cateArray.count;
    }else{
        return self.resultArray.count;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.cateTab) {
        return Anno750(60);
    }
    SearchResultModel * model = self.resultArray[indexPath.section];
    if (model.cont_type.intValue == 1 ) {//新闻
        return Anno750(180);
    }else if(model.cont_type.intValue == 9){//视屏
        return Anno750(180);
    }else{//图集
        return Anno750(420);
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.cateTab) {
        static NSString * cellid = @"SearchCateTableViewCell";
        SearchCateTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[SearchCateTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        }
        SearchCateModel * model = self.cateArray[indexPath.section];
        [cell updateWithSearchCateModel:model];
        return cell;
    }else{
        SearchResultModel * model = self.resultArray[indexPath.section];
        if (model.cont_type.intValue == 1) {
            NSString * searchCellid = @"newsCell";
            NewsListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:searchCellid];
            if (cell == nil) {
                cell = [[NewsListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchCellid];
            }
            [cell updateWithSerachModel:model];
            return cell;
        }else if(model.cont_type.intValue == 9){
            NSString * searchCellid = @"videosCell";
            VideoListTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:searchCellid];
            if (!cell) {
                cell = [[VideoListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchCellid];
            }
            [cell updateWithSearchModel:model];
            return cell;
        }else{
            NSString * searchCellid = @"PictureCell";
            PhotoListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:searchCellid];
            if (cell == nil) {
                cell = [[PhotoListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchCellid];
            }
            [cell updateWithSearchModel:model];
            return cell;
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.cateTab) {
        for (int i = 0; i<self.cateArray.count; i++) {
            SearchCateModel * model = self.cateArray[i];
            if (i == indexPath.section) {
                model.isSelect = YES;
                self.searchTypeModel = model;
                [self.searchView.cateButton setTitle:model.name forState:UIControlStateNormal];
            }else{
                model.isSelect = NO;
            }
        }
        [self showCateList:NO];
    }else{
        SearchResultModel * model = self.resultArray[indexPath.section];
        if ([model.cont_type intValue] == 1) {
            NewsDetailViewController * vc = [[NewsDetailViewController alloc]initWithNewsid:model.id];
            [self.navigationController pushViewController:vc animated:YES];
        }else if([model.cont_type intValue] == 2){
            PhotoDetailViewController * vc = [[PhotoDetailViewController alloc]initWithPhotoDetailid:model.id];
            [self.navigationController pushViewController:vc animated:YES];
        }else if([model.cont_type intValue] == 9){
            MainWebViewController * vc = [[MainWebViewController alloc]initWithTitle:@"视屏" url:model.link andFromType:FromTypeVideo];
            [vc updateShareSettingWithTitle:model.title content:model.content image:@""];
            vc.isPush = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
}
- (void)showCateTab{
    [self showCateList:YES];
}
- (void)showCateList:(BOOL)isShow{
    __weak SearchResultViewController * weakSelf = self;
    float height = Anno750(180);
    if (!isShow) {
        height = 0;
    }
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.cateTab.frame = CGRectMake(Anno750(30), 0, Anno750(170), height);
    }];
    if (!isShow) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.cateTab reloadData];
        });
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length>0) {
        [self addSearchWord:textField.text];
        [self refreshData];
        [self.searchView.searchTF resignFirstResponder];
    }
    return YES;
}
- (BOOL)saveArrayToDocument:(NSMutableArray *)arr{
    NSArray * saveArray = [NSArray arrayWithArray:arr];
    NSString * documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject];
    NSString * newFielPath = [documentsPath stringByAppendingPathComponent:@"data.plist"];
    NSFileManager * manager = [NSFileManager defaultManager];
    [manager createFileAtPath:newFielPath contents:nil attributes:nil];
    
    BOOL isSuccess = [saveArray writeToFile:newFielPath atomically:YES];
    return isSuccess;
}
- (void)addSearchWord:(NSString *)string{
    for (int i = 0; i<self.hisArray.count; i++) {
        NSString * hisString = self.hisArray[i];
        if ([hisString isEqualToString:string]) {
            [self.hisArray removeObjectAtIndex:i];
        }
    }
    if (self.hisArray.count>9) {
        [self.hisArray removeLastObject];
    }
    [self.hisArray insertObject:string atIndex:0];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self saveArrayToDocument:self.hisArray];
    });
}
- (void)nullViewClick{
    [self refreshData];
}
- (void)refreshData{
    [self.resultArray removeAllObjects];
    [self loadData];
}
- (void)loadMoreData{
    [self loadData];
}
- (void)loadData{
    [SVProgressHUD show];
    NSString * idStr = @"";
    if (self.resultArray.lastObject.id ) {
        idStr = [NSString stringWithFormat:@"%@",self.resultArray.lastObject.id];
    }
    NSDictionary * params = @{@"search_word":self.searchView.searchTF.text,
                              @"search_type":self.searchTypeModel.type,
                              @"last_id":idStr,
                              };
    [[NetWorkManger manager] sendRequest:Page_Search route:Route_Else withParams:params complete:^(NSDictionary *result) {
        NSDictionary * infoDic = result[@"info"];
        self.infoModel = [[SearchInfoModel alloc]initWithDictionary:infoDic];
        
        [self nullViewHidden];
        NSArray *dataArr = result[@"data"];
        if (dataArr.count > 0) {
            for (int i = 0; i < dataArr.count; i ++) {
                NSDictionary * dic = dataArr[i];
                SearchResultModel * model = [[SearchResultModel alloc]initWithDictionary:dic];
                [self.resultArray addObject:model];
            }
        }
        if (self.resultArray.count>0 && dataArr.count == 0) {
            [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:@"没有更多了～～" duration:1.0f];
        }
        [self.tabview.mj_footer endRefreshing];
        [self.tabview.mj_header endRefreshing];
        [self.tabview reloadData];
    } error:^(BYError *byerror) {
        [self.tabview.mj_footer endRefreshing];
        [self.tabview.mj_header endRefreshing];
        [self nullviewShow];
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:1.0f];
    }];
}


@end
