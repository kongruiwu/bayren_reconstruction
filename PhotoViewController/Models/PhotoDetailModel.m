//
//  PhotoDetailModel.m
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/5/4.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "PhotoDetailModel.h"

@implementation PhotoDetailModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.pics = [NSMutableArray new];
        self.descs = [NSMutableArray new];
    }
    return self;
}

@end
