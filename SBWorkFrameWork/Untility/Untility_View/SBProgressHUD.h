//
//  SBProgressHUD.h
//  SBWorkFrameWork
//
//  Created by pg on 16/5/30.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    SBProgressHUDMaskTypeDefault,
    SBProgressHUDMaskTypeBlack
}SBProgressHUDMaskType;

@interface SBProgressHUD : NSObject

+(SBProgressHUD *)sharedIntance; // 单例

+ (void)setDefaultMaskType:(SBProgressHUDMaskType)type;//设置默认的遮盖层颜色
+ (void)show; //没有loading提示文字
+ (void)showWithStatus:(NSString*)status; //有loading提示文字
+ (void)dissmiss;//结束HUD
+ (void)showSuccessWithStatus:(NSString*)status; //提示成功
+ (void)showErrorWithStatus:(NSString*)status;  //提示失败
+ (void)setMinimumDismissTimeInterval:(NSTimeInterval)interval;

@end
