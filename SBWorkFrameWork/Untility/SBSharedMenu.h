//
//  SBSharedMenu.h
//  SBWorkFrameWork
//
//  Created by pg on 16/5/27.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoModel.h"

static NSString *ServerIP = @"http://120.26.234.72:8010";

@interface SBSharedMenu : NSObject

@property (nonatomic,strong) NSString *serverIPAddress;
@property (nonatomic,strong) CustomNAVC *sharedNav;

+(SBSharedMenu *)sharedIntance; // 单例



/** 根据文字和字体大小获取宽度 PS:基于屏幕宽度和高度的范围 */
-(CGFloat)getWidthWithString:(NSString *)content andFontSize:(CGFloat)fontSize;

/** 根据文字和字体大小获取宽度 PS:基于限定高度 */
-(CGFloat)getWidthWithString:(NSString *)content andFontSize:(CGFloat)fontSize andMaxWidth:(CGFloat)maxWidth;

/** 根据文字和字体大小获取高度 PS:基于屏幕宽度和高度的范围*/
-(CGFloat)getHeightWithString:(NSString *)content andFontSize:(CGFloat)fontSize;


/** 根据文字和字体大小获取高度 PS:基于限定高度*/
-(CGFloat)getHeightWithString:(NSString *)content andFontSize:(CGFloat)fontSize andMaxHeight:(CGFloat)maxHeight;

/** 获取手机ip地址 */
-(NSString *)getIPForPhone;

/** 生成二维码 */
-(UIImage *) createQCodeWithURL:(NSString *)URLStr;

/** 当前应用版本号 */
-(NSString *) appVersion;

/** 当前应用名称 */
-(NSString *) appName;

/** 手机序列号 */
-(NSString *) identifierNumber;

/** 系统版本号 */
-(CGFloat) appSystemVersion;

/** 保存用户个人信息(NSUserDefault方法) */
-(void)saveLocalModel:(UserInfoModel *)userInfoModel;

/** 获取个人信息(NSUserDefault方法) */
-(UserInfoModel *)getLocalModel;

/** 
 判断用户是否登陆
    1.YES: 登陆
    2.NO : 未登录
 */
-(BOOL)isLogin;

/** 
 清除缓存
 1.Document目录
 2.SDWebImage缓存的图片
 3.Caches目录
 */
+(void)clearCache;

/**
    删除文件夹下的所有文件
 */
+(void)removeFileWithPath:(NSString *)folderPath;

@end
