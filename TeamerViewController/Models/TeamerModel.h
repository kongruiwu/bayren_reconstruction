//
//  TeamerModel.h
//  Bayern_Review
//
//  Created by 吴孔锐 on 2017/4/20.
//  Copyright © 2017年 wurui. All rights reserved.
//

#import "BaseModel.h"

@interface TeamerModel : BaseModel
@property(nonatomic,copy) NSString *birthday;
@property(nonatomic,copy) NSString *birthplace;
@property(nonatomic,copy) NSString *desc;
@property(nonatomic,copy) NSString *edu;
@property(nonatomic,copy) NSString *family;
@property(nonatomic,copy) NSString *height;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *name_en;
@property(nonatomic,copy) NSString *pic;
@property(nonatomic,copy) NSString *shoesize;
@property(nonatomic,copy) NSString *sns;
@property(nonatomic,copy) NSString *type;
@property(nonatomic,copy) NSString *weight;
@property(nonatomic,copy) NSString *zodiac;
@property(nonatomic,retain) NSNumber *gdcpid;
@property(nonatomic,retain) NSNumber *id;
@property(nonatomic,retain) NSNumber *is_coach;
@property(nonatomic,retain) NSNumber *No;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy) NSString *pic_width;
@property(nonatomic,copy) NSString *pic_height;

@property (nonatomic, strong) NSArray * teamerTitles;
@property (nonatomic, strong) NSArray * teamerDescs;
@end
