//
//  HomeFixtureCell.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/28.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "HomeFixtureCell.h"
#import "FixtureCollectionViewCell.h"
@implementation HomeFixtureCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)creatUI{
    self.groundView = [BYFactory creatViewWithColor:BYColor_Alpha_gray];
    self.leftBtn = [BYFactory creatButtonWithNormalImage:@"homeleft" selectImage:nil];
    self.rightBtn = [BYFactory creatButtonWithNormalImage:@"homeRight" selectImage:nil];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize =CGSizeMake(Anno750(602), Anno750(340));
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.fixtureView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    [self.fixtureView registerClass:[FixtureCollectionViewCell class] forCellWithReuseIdentifier:@"fixturecell"];
    self.fixtureView.backgroundColor = [UIColor clearColor];
    self.fixtureView.pagingEnabled = YES;
    self.fixtureView.delegate = self;
    self.fixtureView.dataSource = self;
    self.fixtureView.backgroundColor = [UIColor clearColor];
    self.fixtureView.showsVerticalScrollIndicator = NO;
    self.fixtureView.showsHorizontalScrollIndicator = NO;
    
    [self addSubview:self.groundView];
    [self.groundView addSubview:self.leftBtn];
    [self.groundView addSubview:self.rightBtn];
    [self.groundView addSubview:self.fixtureView];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.groundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.right.equalTo(@(-Anno750(24)));
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(@(Anno750(50)));
    }];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@0);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.width.equalTo(@(Anno750(50)));
    }];
    [self.fixtureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftBtn.mas_right);
        make.right.equalTo(self.rightBtn.mas_left);
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.fixtures.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FixtureCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"fixturecell" forIndexPath:indexPath];
    [cell updateWithHomeGameModel:self.fixtures[indexPath.row]];
    [cell.newsButton addTarget:self action:@selector(checkNewsDetail:) forControlEvents:UIControlEventTouchUpInside];
    [cell.picButton addTarget:self action:@selector(checkPhotoDetail:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)checkNewsDetail:(UIButton *)btn{
    UICollectionViewCell * cell = (UICollectionViewCell *)[btn superview];
    NSIndexPath * indeptah = [self.fixtureView indexPathForCell:cell];
    FixtureModel * model = self.fixtures[indeptah.row];
    if ([self.delegate respondsToSelector:@selector(checkNewDetailWithNewsid:)]) {
        [self.delegate checkNewDetailWithNewsid:model.news_link];
    }
}
- (void)checkPhotoDetail:(UIButton *)btn{
    UICollectionViewCell * cell = (UICollectionViewCell *)[btn superview];
    NSIndexPath * indeptah = [self.fixtureView indexPathForCell:cell];
    FixtureModel * model = self.fixtures[indeptah.row];
    if ([self.delegate respondsToSelector:@selector(checkPicDetailWithPicid:)]) {
        [self.delegate checkPicDetailWithPicid:model.album_link];
    }
}
- (void)updateWithFixtures:(NSArray *)fixtures andindex:(NSInteger)index{
    self.fixtures = fixtures;
    [self.fixtureView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.fixtureView.contentOffset = CGPointMake(index * Anno750(602), 0);
    });
    
}
@end
