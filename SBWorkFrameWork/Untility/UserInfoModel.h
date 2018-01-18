//
//  UserInfoModel.h
//  SBWorkFrameWork
//
//  Created by pg on 16/6/14.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import "SBModel.h"

@interface UserInfoModel : NSObject<NSCoding>

@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *passWord;
@property (nonatomic,assign) NSInteger userId;
@property (nonatomic,assign) BOOL isLogin;

@end
