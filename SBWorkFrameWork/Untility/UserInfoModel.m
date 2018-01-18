//
//  UserInfoModel.m
//  SBWorkFrameWork
//
//  Created by pg on 16/6/14.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.passWord forKey:@"passWord"];
    [aCoder encodeInteger:self.userId forKey:@"userId"];
    [aCoder encodeBool:self.isLogin forKey:@"isLogin"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.userName = [aDecoder decodeObjectForKey:@"userName"];
        self.passWord = [aDecoder decodeObjectForKey:@"passWord"];
        self.userId = [aDecoder decodeIntegerForKey:@"userId"];
        self.isLogin  = [aDecoder decodeBoolForKey:@"isLogin"];
    }
    return  self;
}

@end
