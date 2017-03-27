//
//  VideoListTableViewCell.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "VideoListTableViewCell.h"
#import <UIImageView+WebCache.h>

@implementation VideoListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)creatUI{
    self.videoIcon = [[UIImageView alloc]init];
    self.videoIcon.backgroundColor = [UIColor redColor];
    self.tagLabel = [BYFactory creatLabelWithText:@"拜仁新闻"
                                        fontValue:font750(26)
                                        textColor:BYColor_Tag
                                    textAlignment:NSTextAlignmentLeft];
    self.nameLabel = [BYFactory creatLabelWithText:@"拜仁新闻"
                                         fontValue:font750(30)
                                         textColor:BYColor_Title
                                     textAlignment:NSTextAlignmentLeft];
    self.nameLabel.numberOfLines = 0;
    self.timeLabel = [BYFactory creatLabelWithText:@"03-07"
                                         fontValue:font750(24)
                                         textColor:BYColor_Tag
                                     textAlignment:NSTextAlignmentRight];
    self.playIcon = [BYFactory creatImageViewWithImage:@"videoPlay"];
    self.line = [BYFactory creatLineView];
    
    [self addSubview:self.videoIcon];
    [self addSubview:self.tagLabel];
    [self addSubview:self.nameLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.line];
    [self.videoIcon addSubview:self.playIcon];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.videoIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(24)));
        make.centerY.equalTo(@0);
        make.width.equalTo(@(Anno750(200)));
        make.height.equalTo(@(Anno750(140)));
    }];
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.videoIcon.mas_top);
        make.left.equalTo(self.videoIcon.mas_right).offset(Anno750(24));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tagLabel.mas_bottom).offset(Anno750(12));
        make.left.equalTo(self.tagLabel.mas_left);
        make.right.equalTo(@(-Anno750(24)));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-Anno750(24)));
        make.bottom.equalTo(self.videoIcon.mas_bottom);
    }];
    [self.playIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.videoIcon.mas_right).offset(-Anno750(10));
        make.bottom.equalTo(self.videoIcon.mas_bottom).offset(-Anno750(10));
        make.width.equalTo(@(Anno750(50)));
        make.height.equalTo(@(Anno750(50)));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0);
        make.left.equalTo(@(Anno750(24)));
        make.right.equalTo(@(Anno750(-24)));
        make.height.equalTo(@0.5);
    }];
}
- (void)updateWithModel:(VideoListModel *)model{
    NSURL * picUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Base_ImgHost,model.pic]];
    [self.videoIcon sd_setImageWithURL:picUrl placeholderImage:[UIImage imageNamed:@"news_defult"]];
    NSMutableString * tags = [[NSMutableString alloc]init];
    for (int i = 0; i<model.tags.count; i++) {
        if (i == 0) {
            [tags appendString:model.tags[i]];
        }else{
            [tags appendString:[NSString stringWithFormat:@"  %@",model.tags[i]]];
        }
    }
    self.tagLabel.text = tags;
    self.nameLabel.text = model.title;
    self.timeLabel.text = model.date;
}

@end
