//
//  NewsListModel.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/24.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface NewsListModel : BaseModel

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, strong) NSString * pic;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * date;
@property (nonatomic, retain) NSNumber * cont_type;
@end

