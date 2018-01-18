//
//  SBNetWork.h
//  SBWorkFrameWork
//
//  Created by pg on 16/5/30.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import <Foundation/Foundation.h>

#define notJson @"notJson"

typedef enum {
    SBUploadFileTypeImage,
    SBUploadFileTypeOther
}SBUploadFileType;

@interface SBNetWork : NSObject

/** 网络请求 
 1.params:参数
 2.apiName:api名称
 3.serverURL:服务器地址
 4.isGet:get还是post请求方法
 5.isNeedHud:是否需要转圈提示
 6.loadTitle:转圈提示文字
 7.sucessTitle:转圈结束成功提示文字
 8.failTItle:转圈结束失败提示文字
 9.sucess:请求成功回调方法
 10.fail:请求失败回调方法
 11.flag:其它标志（用来处理特殊情况）
 */
-(void)SBRequestWithParams:(NSDictionary *)params //参数
                andApiName:(NSString *)apiName //api名称
                andBaseURL:(NSString *)serverURL //服务器地址
                andIsGet:(BOOL)isGet    //get还是post请求方法
                andNeedHUD:(BOOL)isNeedHUD  //是否需要转圈提示
        andHUDLoadingTitle:(NSString *)loadTitle    //转圈提示文字
         andHUDSucessTitle:(NSString *)sucessTitle  //转圈结束成功提示文字
           andHUDFailTitle:(NSString *)failTitle    //转圈结束失败提示文字
                 netSucess:(void (^)(NSString *ApiName,id responseObject, NSString *otherFlag))sucess //请求成功回调方法
                   netFail:(void (^)(NSString *ApiName,id responseObject,NSString *otherFlag))fail //请求失败回调方法
             andOtherFlag:(NSString *)flag; //其它标志（用来处理特殊情况）


/** 上传文件
 1.目前暂时支持图片，其它以后优化，方法类似 
 2.URLStr:服务器地址
 3.data:文件内容
 4.type:文件类型，枚举
 5.flag:防止重用添加的flag
 6.sucess:成功回调
 7.fail:失败回调
 */
-(void)UploadFileWithURL:(NSString *)URLStr andData:(NSData *)data andType:(SBUploadFileType *)type andOtherFlag:(NSString *)flag andSucess:(void (^)(NSString *fileName,NSString *otherFlag,NSString *result))sucess andFail:(void (^)(NSString *fileName,NSString *otherFlag,NSString *result,NSError *error))fail;

/** 下载图片
    用的SDWebImage中的方法
 */

+(void)downloadImageWithURL:(NSString *)imgURL progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageDownloaderCompletedBlock)completedBlock;

@end
