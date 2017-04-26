//
//  HomeVideoFocusModel.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/25.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface HomeVideoFocusModel : BaseModel
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * pic;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, retain) NSNumber * show_type;
@property (nonatomic, retain) NSNumber * show_id;
@end
