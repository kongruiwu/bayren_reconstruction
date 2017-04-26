//
//  TeamerModel.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "TeamerModel.h"

@implementation TeamerModel
- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super initWithDictionary:dic];
    if(self){
        self.teamerTitles = @[@"出生日期",@"出生地点",@"星座",@"身高/体重/鞋码",@"婚姻状况",@"学历"];
        NSString * info = [NSString stringWithFormat:@"%@/%@/%@",self.height,self.weight,self.shoesize];
        self.teamerDescs = @[self.birthday,self.birthplace,self.zodiac,info,self.family,self.edu];
    }
    return self;
}
@end
