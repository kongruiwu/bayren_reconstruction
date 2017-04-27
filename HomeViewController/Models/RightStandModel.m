//
//  RightStandModel.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/27.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "RightStandModel.h"

@implementation RightStandModel
- (instancetype)initWithDictionary:(NSDictionary *)Dictionary{
    self = [super initWithDictionary:Dictionary];
    if (self) {
        self.winString = [NSString stringWithFormat:@"%@/%@/%@",self.win,self.draw,self.lost];
        self.basllNumberStr = [NSString stringWithFormat:@"%@/%@",self.hits,self.miss];
    }
    return self;
}
@end
