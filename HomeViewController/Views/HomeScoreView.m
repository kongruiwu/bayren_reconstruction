//
//  HomeScoreView.m
//  Bayern
//
//  Created by 吴孔锐 on 16/9/18.
//  Copyright © 2016年 Wusicong. All rights reserved.
//

#import "HomeScoreView.h"

@implementation HomeScoreView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
- (void)creatUI{
    self.dayTimeLable = [BYFactory creatLabelWithText:@"2015-3-11"
                                            fontValue:font750(26)
                                            textColor:[UIColor whiteColor]
                                        textAlignment:NSTextAlignmentCenter];
    self.homeIcon = [BYFactory creatImageViewWithImage:@"logoDefalut"];
    self.awayIcon = [BYFactory creatImageViewWithImage:@"logoDefalut"];
    self.homeLabel = [BYFactory creatLabelWithText:@"拜仁慕尼黑"
                                         fontValue:font750(26)
                                         textColor:[UIColor whiteColor]
                                     textAlignment:NSTextAlignmentCenter];
    self.awayLabel = [BYFactory creatLabelWithText:@"尤文图斯"
                                         fontValue:font750(26)
                                         textColor:[UIColor whiteColor]
                                     textAlignment:NSTextAlignmentCenter];
    self.scoreLabel = [BYFactory creatLabelWithText:@"5:0"
                                          fontValue:font750(50)
                                          textColor:[UIColor whiteColor]
                                      textAlignment:NSTextAlignmentCenter];
    self.halfScoreLabel = [BYFactory creatLabelWithText:@"3:0"
                                              fontValue:font750(26)
                                              textColor:[UIColor whiteColor]
                                          textAlignment:NSTextAlignmentCenter];
    self.detailButton = [BYFactory creatButtonWithTitle:@"本场战报"
                                        backGroundColor:BYColor_Main
                                              textColor:[UIColor whiteColor]
                                               textSize:font750(30)];
    self.detailButton.layer.cornerRadius = Anno750(30);
    
    self.infoLabel = [BYFactory creatLabelWithText:@"CCTV  虎扑体育  五星体育"
                                         fontValue:font750(26)
                                         textColor:[UIColor whiteColor]
                                     textAlignment:NSTextAlignmentCenter];
    self.newsButton = [BYFactory creatButtonWithTitle:@"战报" backGroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textSize:font750(30)];
    self.picButton = [BYFactory creatButtonWithTitle:@"图集" backGroundColor:[UIColor clearColor] textColor:[UIColor whiteColor] textSize:font750(30)];
    self.newsButton.layer.cornerRadius = Anno750(30);
    self.picButton.layer.cornerRadius = Anno750(30);
    self.newsButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.picButton.layer.borderColor = [UIColor whiteColor].CGColor;
    self.newsButton.layer.borderWidth = 1.0f;
    self.picButton.layer.borderWidth = 1.0f;
    
    self.infoLabel.hidden = YES;
    self.detailButton.hidden = YES;
    self.newsButton.hidden = YES;
    self.picButton.hidden = YES;
    
    self.bottomLine = [BYFactory creatLineView];
    [self addSubview:self.dayTimeLable];
    [self addSubview:self.homeLabel];
    [self addSubview:self.homeIcon];
    [self addSubview:self.awayLabel];
    [self addSubview:self.awayIcon];
    [self addSubview:self.scoreLabel];
    [self addSubview:self.halfScoreLabel];
    [self addSubview:self.detailButton];
    [self addSubview:self.infoLabel];
    [self addSubview:self.newsButton];
    [self addSubview:self.picButton];
    [self addSubview:self.bottomLine];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.dayTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(@(Anno750(20)));
    }];
    
    [self.homeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.scoreLabel.mas_left).offset(-Anno750(80));
        make.top.equalTo(self.dayTimeLable.mas_bottom).offset(Anno750(20));
        make.width.height.equalTo(@(Anno750(100)));
    }];
    [self.awayIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scoreLabel.mas_right).offset(Anno750(80));
        make.top.equalTo(self.dayTimeLable.mas_bottom).offset(Anno750(20));
        make.width.height.equalTo(@(Anno750(100)));
    }];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.centerY.equalTo(self.awayIcon.mas_centerY);
    }];
    [self.homeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.homeIcon.mas_centerX);
        make.top.equalTo(self.homeIcon.mas_bottom).offset(Anno750(20));
    }];
    [self.awayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.awayIcon.mas_centerX);
        make.top.equalTo(self.awayIcon.mas_bottom).offset(Anno750(20));
    }];
    [self.halfScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.homeLabel.mas_centerY);
        make.centerX.equalTo(@0);
    }];
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.homeLabel.mas_bottom).offset(Anno750(40));
        make.centerX.equalTo(@0);
    }];
    [self.detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.homeLabel.mas_bottom).offset(Anno750(20));
        make.centerX.equalTo(@0);
        make.width.equalTo(@(Anno750(300)));
        make.height.equalTo(@(Anno750(60)));
    }];
    [self.newsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_centerX).offset(-Anno750(20));
        make.top.equalTo(self.homeLabel.mas_bottom).offset(Anno750(20));
        make.width.equalTo(@(Anno750(200)));
        make.height.equalTo(@(Anno750(60)));
    }];
    [self.picButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(Anno750(20));
        make.top.equalTo(self.homeLabel.mas_bottom).offset(Anno750(20));
        make.width.equalTo(@(Anno750(200)));
        make.height.equalTo(@(Anno750(60)));
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(Anno750(20)));
        make.right.equalTo(@(-Anno750(20)));
        make.bottom.equalTo(@0);
        make.height.equalTo(@1);
    }];
}
- (void)updateWithHomeGameModel:(FixtureModel *)model{
    [self.homeIcon sd_setImageWithURL:[NSURL URLWithString:model.home_logo] placeholderImage:[UIImage imageNamed:@"logoDefalut"]];
    [self.awayIcon sd_setImageWithURL:[NSURL URLWithString:model.away_logo] placeholderImage:[UIImage imageNamed:@"logoDefalut"]];
    NSDate *postDate = [NSDate dateWithTimeIntervalSince1970:[model.match_date_cn doubleValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd   HH:mm"];
    NSString *dateStr = [dateFormatter stringFromDate:postDate];
    self.dayTimeLable.text =[NSString stringWithFormat:@"%@    %@",model.league_title,dateStr];
    self.homeLabel.text = model.home_name;
    self.awayLabel.text = model.away_name;
    self.scoreLabel.text = [NSString stringWithFormat:@"%@ : %@",model.home_score,model.away_score];
    self.halfScoreLabel.text = [NSString stringWithFormat:@"(%@)",model.half_score];
    self.infoLabel.text = model.relay_info;
    BOOL isOver = [self isGameOverWithDate:model.match_date_cn];
    if (isOver) {
        if([model.news_link intValue]>0){
            if ([model.album_link intValue]>0) {
                self.picButton.hidden = NO;
                self.newsButton.hidden = NO;
                self.detailButton.hidden = YES;
                self.infoLabel.hidden = YES;
            }else{
                self.detailButton.hidden = NO;
                self.picButton.hidden = YES;
                self.newsButton.hidden = YES;
                self.infoLabel.hidden = YES;
            }
        }
    }else{
        self.detailButton.hidden = YES;
        self.newsButton.hidden = YES;
        self.picButton.hidden = YES;
        self.infoLabel.hidden = NO;
    }
}
- (BOOL)isGameOverWithDate:(NSString *)dateStr {
    
    NSDate *postDate = [NSDate dateWithTimeIntervalSince1970:[dateStr doubleValue]];
    NSDate *nowDate = [NSDate date];
    
    if ([postDate compare:nowDate] == NSOrderedAscending) {
        //比赛结束
        return YES;
    } else if ([postDate compare:nowDate] == NSOrderedSame || [postDate compare:nowDate] == NSOrderedDescending) {
        return NO;
    }
    return YES;
}@end
