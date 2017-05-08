//
//  PhotoDetailModel.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/5/4.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface PhotoDetailModel : BaseModel

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSMutableArray * pics;
@property (nonatomic, strong) NSMutableArray * descs;
@property (nonatomic, assign) NSInteger count;

@end
