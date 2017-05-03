//
//  HomeTeamerTableViewCell.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/25.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "HomeTeamerTableViewCell.h"

@implementation HomeTeamerTableViewCell

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
        self.userInteractionEnabled = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)creatUI{
    self.backgroundColor = [UIColor clearColor];
    self.teamerOne = [[HomeTeamerView alloc]init];
    self.teamerTwo = [[HomeTeamerView alloc]init];
    self.teamerTwo.tag = 2;
    self.teamerOne.tag = 1;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellteamerClick:)];
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cellteamerClick:)];
    [self.teamerOne addGestureRecognizer:tap];
    [self.teamerTwo addGestureRecognizer:tap1];
    [self addSubview:self.teamerTwo];
    [self addSubview:self.teamerOne];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.teamerOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.width.equalTo(@(Anno750(341)));
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    [self.teamerTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.width.equalTo(@(Anno750(341)));
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}
- (void)updateWithArrays:(NSArray<HomeTeamerModel *> *)arr{
    [self.teamerOne updateWithModel:arr[0]];
    [self.teamerTwo updateWithModel:arr[1]];
    self.dataArray = arr;
}
- (void)cellteamerClick:(UITapGestureRecognizer *)tap{
    UIView * view = tap.view;
    NSInteger index = view.tag;
    
    if ([self.delegate respondsToSelector:@selector(homeTeamerClickWithTeamerid:isTeamer:)]) {
        HomeTeamerModel * model = self.dataArray[index - 1];
        [self.delegate homeTeamerClickWithTeamerid:model.player_id isTeamer:!model.is_coach];
    }
}
@end
