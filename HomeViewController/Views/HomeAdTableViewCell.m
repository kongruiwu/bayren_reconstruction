//
//  HomeAdTableViewCell.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/25.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "HomeAdTableViewCell.h"

@implementation HomeAdTableViewCell

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
    self.backImg = [BYFactory creatImageViewWithImage:@"banner_defult"];
    [self addSubview:self.backImg];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.top.equalTo(@0);
        make.bottom.equalTo(@0);
        make.right.equalTo(@(-Anno750(24)));
    }];
}
- (void)updateWithImageUrlStr:(NSString *)imageUlr{
    [self.backImg sd_setImageWithURL:[NSURL URLWithString:imageUlr] placeholderImage:[UIImage imageNamed:@"banner_defult"]];
}
@end
