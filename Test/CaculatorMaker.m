//
//  CaculatorMaker.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/31.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "CaculatorMaker.h"


@implementation CaculatorMaker
- (CaculatorMaker *(^)(int))add{
    return ^CaculatorMaker * (int value){
        _result += value;
        return self;
    };
}
- (CaculatorMaker *(^)(int))sub{
    return ^CaculatorMaker *(int value){
        _result -= value;
        return self;
    };
}


@end

@implementation Caculator

+ (int)makeCaculators:(void (^)(CaculatorMaker * maker))CacultorMakerblock{
    CaculatorMaker * maker = [[CaculatorMaker alloc]init];
    CacultorMakerblock(maker);
    return maker.result;
}

@end
