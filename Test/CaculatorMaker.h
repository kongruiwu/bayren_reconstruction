//
//  CaculatorMaker.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/3/31.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CaculatorMaker : NSObject
@property (nonatomic) int result;

- (CaculatorMaker *(^)(int))add;
- (CaculatorMaker *(^)(int))sub;
- (CaculatorMaker *(^)(int))muilt;
- (CaculatorMaker *(^)(int))divide;



@end
@interface Caculator : NSObject

+ (int)makeCaculators:(void (^)(CaculatorMaker * maker))CacultorMaker;
- (Caculator *)caculator:(int(^)(int result))caculator;
- (Caculator *)equle:(BOOL(^)(int result))operation;
@end
