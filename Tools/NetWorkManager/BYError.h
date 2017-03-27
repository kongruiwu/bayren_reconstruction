//
//  BYError.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYError : NSObject
@property (nonatomic, strong) NSString * errorCode;
@property (nonatomic, strong) NSString * errorMessage;
@end
