//
//  PhotoDetailViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/5/2.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "PhotoDetailCell.h"
#import "PhotoDetailModel.h"
#import "ShareView.h"

@interface PhotoDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,PhotoDetailCellDelegate>

@property (nonatomic, strong) UICollectionView * photoView;
@property (nonatomic, strong) NSNumber * photoid;
@property (nonatomic, strong) PhotoDetailModel * photoModel;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * descLabel;
@property (nonatomic, strong) UILabel * pageLabel;
@property (nonatomic, strong) UIView * grayView;
@property (nonatomic, strong) UILabel * numLabel;
@property (nonatomic, strong) UIButton * downLoadBtn;
@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) ShareView * shareView;
@end

@implementation PhotoDetailViewController
- (instancetype)initWithPhotoDetailid:(NSNumber *)photoid{
    self = [super init];
    if (self) {
        self.photoid = photoid;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self creatUI];
    [self loadPhotoData];
}


- (void)creatUI{
    self.view.backgroundColor = [UIColor blackColor];
    self.photoModel = [[PhotoDetailModel alloc]init];
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize =CGSizeMake(UI_WIDTH, UI_HEGIHT);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.photoView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    [self.photoView registerClass:[PhotoDetailCell class] forCellWithReuseIdentifier:@"photocell"];
    self.photoView.backgroundColor = [UIColor clearColor];
    self.photoView.pagingEnabled = YES;
    self.photoView.delegate = self;
    self.photoView.dataSource = self;
    self.photoView.backgroundColor = [UIColor clearColor];
    self.photoView.showsVerticalScrollIndicator = NO;
    self.photoView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.photoView];
    self.photoView.userInteractionEnabled = YES;
    [self.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    //设置不需要系统调整布局
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIButton * leftButton = [BYFactory creatButtonWithNormalImage:@"back_2" selectImage:nil];
    UIButton * shareButton = [BYFactory creatButtonWithNormalImage:@"share" selectImage:nil];
    
    [self.view addSubview:leftButton];
    [self.view addSubview:shareButton];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.top.equalTo(@(Anno750(64)));
        make.width.equalTo(@(Anno750(100)));
        make.height.equalTo(@(Anno750(80)));
    }];
    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.centerY.equalTo(leftButton.mas_centerY);
        make.width.equalTo(@(Anno750(100)));
        make.height.equalTo(@(Anno750(60)));
    }];
    [self creatbottomLabel];
    
    [leftButton addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
    [shareButton addTarget:self action:@selector(doShare) forControlEvents:UIControlEventTouchUpInside];
    
    self.shareView = [[ShareView alloc]initWithFrame:CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT)];
    [self.view addSubview:self.shareView];
    [self.view bringSubviewToFront:self.shareView];
}

- (void)creatbottomLabel{
    
    self.grayView = [BYFactory creatViewWithColor:BYColor_Line];
    self.titleLabel = [BYFactory creatLabelWithText:@"我是标题"
                                          fontValue:font750(30)
                                          textColor:[UIColor whiteColor]
                                      textAlignment:NSTextAlignmentLeft];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:font750(34)];
    self.descLabel = [BYFactory creatLabelWithText:@""
                                         fontValue:font750(26)
                                         textColor:[UIColor whiteColor]
                                     textAlignment:NSTextAlignmentLeft];
    self.descLabel.numberOfLines = 0;
    self.pageLabel = [BYFactory creatLabelWithText:@"10/19"
                                         fontValue:font750(30)
                                         textColor:[UIColor whiteColor]
                                     textAlignment:NSTextAlignmentCenter];
    self.numLabel = [BYFactory creatLabelWithText:@"10/19"
                                        fontValue:font750(30)
                                        textColor:[UIColor whiteColor]
                                    textAlignment:NSTextAlignmentCenter];
    
    self.downLoadBtn = [BYFactory creatButtonWithNormalImage:@"download" selectImage:@""];
    [self.downLoadBtn addTarget:self action:@selector(downloadimage) forControlEvents:UIControlEventTouchUpInside];
    
    self.numLabel.hidden = YES;
    self.downLoadBtn.hidden = YES;
    
    [self.view addSubview:self.grayView];
    [self.grayView addSubview:self.titleLabel];
    [self.grayView addSubview:self.descLabel];
    [self.grayView addSubview:self.pageLabel];
    [self.view addSubview:self.numLabel];
    [self.view addSubview:self.downLoadBtn];
    
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.bottom.equalTo(@0);
        make.height.equalTo(@(UI_HEGIHT * 0.3));
    }];
    [self.pageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.top.equalTo(@(Anno750(24)));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.right.equalTo(@(-Anno750(100)));
        make.top.equalTo(@(Anno750(24)));
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(Anno750(24));
        make.left.equalTo(@(Anno750(24)));
        make.right.equalTo(@(-Anno750(24)));
    }];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.bottom.equalTo(@(Anno750(-20)));
    }];
    [self.downLoadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.width.equalTo(@(Anno750(60)));
        make.height.equalTo(@(Anno750(60)));
        make.bottom.equalTo(@(Anno750(-20)));
    }];

    
}
- (void)doShare{
    NSString * shareUrl = [NSString stringWithFormat:@"http://%@/photo/album/%@.html", Base_WebHost,self.photoid];
    NSInteger index = (self.photoView.contentOffset.x / UI_WIDTH);
    NSString * url = [NSString stringWithFormat:@"%@%@", Base_ImgHost, self.photoModel.pics[index]];
    [self.shareView updateShareInfoWithTitle:self.photoModel.title desc:self.photoModel.descs[index] contentUlr:shareUrl imageUrl:url];
    [self.shareView showWithNavtionBarHidden];
}
- (void)singleClick{
    self.grayView.hidden = !self.grayView.hidden;
    self.numLabel.hidden = !self.numLabel.hidden;
    self.downLoadBtn.hidden = !self.downLoadBtn.hidden;
}

- (void)downloadimage{
    UIImageWriteToSavedPhotosAlbum([self.imageView image], self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
-(void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    if (error) {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的“设置-隐私-照片”中允许访问您的照片" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    }else{
        [ToastView presentToastWithin:self.view withIcon:APToastIconSuccess text:@"保存成功" duration:1.0f];
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photoModel.pics.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoDetailCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photocell" forIndexPath:indexPath];
    [cell updateWithPic:self.photoModel.pics[indexPath.row]];
    cell.delegate =self;
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.photoView) {
        if (0<=scrollView.contentOffset.x<= UI_WIDTH * self.photoModel.pics.count) {
            NSInteger index = (scrollView.contentOffset.x / UI_WIDTH)+1;
            self.descLabel.text = self.photoModel.descs[index - 1];
            self.numLabel.text = [NSString stringWithFormat:@"%ld/%ld",index,self.photoModel.pics.count];
            self.pageLabel.text = self.numLabel.text;
        }
    }
}
- (void)loadPhotoData{
    NSDictionary * params = @{
                              @"id":self.photoid
                              };
    [[NetWorkManger manager] sendRequest:Page_PhotoDetail route:Route_Photo withParams:params complete:^(NSDictionary *result) {
        NSDictionary * titleDic = result[@"info"];
        self.photoModel.title = titleDic[@"album_title"];
        NSArray * dataArr = result[@"data"];
        for (int i = 0; i<dataArr.count; i++) {
            NSString * url = [NSString stringWithFormat:@"%@%@", Base_ImgHost, dataArr[i][@"pic"]];
            [self.photoModel.pics addObject:url];
            NSString * title = dataArr[i][@"title"];
            if (title.length == 0) {
                title =  self.photoModel.title;
            }
            [self.photoModel.descs addObject:title];
        }
        self.titleLabel.text = self.photoModel.title;
        self.descLabel.text = self.photoModel.descs[0];
        self.numLabel.text = [NSString stringWithFormat:@"1/%ld",self.photoModel.pics.count];
        self.pageLabel.text = self.numLabel.text;
        [self.photoView reloadData];
    } error:^(BYError *byerror) {
        [ToastView presentToastWithin:self.view withIcon:APToastIconNone text:byerror.errorMessage duration:1.0f];
    }];
}


@end
