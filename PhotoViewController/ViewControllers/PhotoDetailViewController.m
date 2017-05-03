//
//  PhotoDetailViewController.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/5/2.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "PhotoDetailViewController.h"
#import "PhotoDetailCell.h"


@interface PhotoDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * photoView;
@property (nonatomic, strong) NSMutableArray * dataArray;
@property (nonatomic, strong) NSNumber * photoid;

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
//- (void)viewDidDisappear:(BOOL)animated{
//    [super viewDidDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self creatTestUI];
    [self creatUI];
    // Do any additional setup after loading the view.
}
- (void)creatTestUI{
    UIView * test = [BYFactory creatViewWithColor:[UIColor redColor]];
    test.frame = CGRectMake(0, 0, UI_WIDTH, UI_HEGIHT);
    [self.view addSubview:test];
}

- (void)creatUI{
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
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return self.dataArray.count;
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoDetailCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photocell" forIndexPath:indexPath];
    return cell;
}



@end
