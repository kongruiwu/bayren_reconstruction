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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)creatUI{
    self.backgroundColor = [UIColor clearColor];
    self.teamerOne = [[HomeTeamerView alloc]init];
    self.teamerTwo = [[HomeTeamerView alloc]init];
    
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
}
@end
