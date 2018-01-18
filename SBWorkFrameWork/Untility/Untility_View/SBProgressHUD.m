//
//  SBProgressHUD.m
//  SBWorkFrameWork
//
//  Created by pg on 16/5/30.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import "SBProgressHUD.h"

@implementation SBProgressHUD

+(SBProgressHUD *)sharedIntance{
    static SBProgressHUD *sharedManager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

//设置默认类型
+(void)setDefaultMaskType:(SBProgressHUDMaskType)type{
    if (type == SBProgressHUDMaskTypeDefault) {
        
    }else{
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    }
    [SVProgressHUD setFont:[UIFont systemFontOfSize:13]];
}

+(void)show{
    [SVProgressHUD show];
}

+(void)showWithStatus:(NSString *)status{
    [SVProgressHUD showWithStatus:status];
}

+(void)showSuccessWithStatus:(NSString *)status{
    [SVProgressHUD showSuccessWithStatus:status];
}

+(void)showErrorWithStatus:(NSString *)status{
    [SVProgressHUD showErrorWithStatus:status];
}

+(void)dissmiss{
    [SVProgressHUD dismiss];
}

+(void)setMinimumDismissTimeInterval:(NSTimeInterval)interval{
    [SVProgressHUD setMinimumDismissTimeInterval:interval];
}

@end
