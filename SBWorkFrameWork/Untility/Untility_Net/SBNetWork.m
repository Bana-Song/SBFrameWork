//
//  SBNetWork.m
//  SBWorkFrameWork
//
//  Created by pg on 16/5/30.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import "SBNetWork.h"

@interface SBNetWork()


@end

@implementation SBNetWork

// 拼接字符串
static NSString *boundaryStr = @"--";   // 分隔字符串
static NSString *randomIDStr;           // 本次上传标示字符串
static NSString *uploadID;              // 接收文件字段

-(instancetype)init{
    self = [super init];
    if (self) {
        randomIDStr = @"itcast";
        uploadID = @"uploadFile";
    }
    return self;
}

#pragma mark -- 网络请求方法
-(void)SBRequestWithParams:(NSDictionary *)params andApiName:(NSString *)apiName andBaseURL:(NSString *)serverURL andIsGet:(BOOL)isGet andNeedHUD:(BOOL)isNeedHUD andHUDLoadingTitle:(NSString *)loadTitle andHUDSucessTitle:(NSString *)sucessTitle andHUDFailTitle:(NSString *)failTitle netSucess:(void (^)(NSString *, id, NSString *))sucess netFail:(void (^)(NSString *, id, NSString *))fail andOtherFlag:(NSString *)flag{
    
    if (serverURL == nil) {
        serverURL = [SBSharedMenu sharedIntance].serverIPAddress;
    }
    
    if (isNeedHUD) {
        [SBProgressHUD setDefaultMaskType:SBProgressHUDMaskTypeBlack];
        [SBProgressHUD setMinimumDismissTimeInterval:1];
        if (loadTitle == nil) {
            [SBProgressHUD show];
        }else{
            [SBProgressHUD showWithStatus:loadTitle];
        }
    }

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if ([flag isEqualToString:notJson]) {
        
    }else{
        //申明返回的结果是json类型
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //申明请求的数据是json类型
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
    }
//    //申明返回的结果是json类型
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    //申明请求的数据是json类型
//    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json", @"text/javascript",@"text/plain", nil];
    manager.requestSerializer.timeoutInterval = 30; //设置超时时间
//    [manager.requestSerializer setValue:@"12354513" forHTTPHeaderField:@"Json-Token"];//token看情况修改
    
    NSString *url = @"";
    
    if (apiName == nil) {
        url = serverURL;
    }else{
        url = [NSString stringWithFormat:@"%@/%@",serverURL,apiName];
    }
    if (isGet) {
        
        //GET
        [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (isNeedHUD) {
                    if (sucessTitle == nil) {
                        [SBProgressHUD dissmiss];
                    }else{
                        //没有查询到数据的时候，执行的提示方法（看情况需要添加）
//                        NSArray *getAry = [responseObject objectForKey:@"Result"];
//                        if (getAry.count == 0) {
//                            [SBProgressHUD showErrorWithStatus:@"没有查询到数据"];
//                            return;
//                        }
                        [SBProgressHUD showSuccessWithStatus:sucessTitle];
                    }
                }
            SBLog(@"请求结果:%@",responseObject);
                sucess(apiName,[responseObject objectForKey:@"Result"],flag);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (isNeedHUD) {
                if (failTitle == nil) {
                    [SBProgressHUD dissmiss];
                }else{
                    [SBProgressHUD showErrorWithStatus:failTitle];
                }
            }
            fail(apiName,error.userInfo,flag);
        }];
    }else{
        
        //POST
        [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (isNeedHUD) {
                    if (sucessTitle == nil) {
                        [SBProgressHUD dissmiss];
                    }else{
                        //没有查询到数据的时候，执行的提示方法（看情况需要添加）
                        //                        NSArray *getAry = [responseObject objectForKey:@"Result"];
                        //                        if (getAry.count == 0) {
                        //                            [SBProgressHUD showErrorWithStatus:@"没有查询到数据"];
                        //                            return;
                        //                        }
                        [SBProgressHUD showSuccessWithStatus:sucessTitle];
                    }
                }
                sucess(apiName,[responseObject objectForKey:@"Flag"],flag);
           
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (isNeedHUD) {
                if (failTitle == nil) {
                    [SBProgressHUD dissmiss];
                }else{
                    [SBProgressHUD showErrorWithStatus:failTitle];
                }
            }
            fail(apiName,error.userInfo,flag);
        }];
    }
}



#pragma mark -- 上传文件
-(void)UploadFileWithURL:(NSString *)URLStr andData:(NSData *)data andType:(SBUploadFileType *)type andOtherFlag:(NSString *)flag andSucess:(void (^)(NSString *, NSString *, NSString *))sucess andFail:(void (^)(NSString *, NSString *, NSString *, NSError *))fail{
    // 1> 数据体 (设置header文件内容)
    NSURL *url = [NSURL URLWithString:URLStr];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat = @"yyyyMMddhhmmss";
    NSString *localDate = [format stringFromDate:date];
    
    SBLog(@"%@",localDate);
    
    
    NSMutableData *dataM = [NSMutableData data];
    
    if (type == SBUploadFileTypeImage ) {
        //图片类型设置
        NSString *topStr = [self topStringWithMimeType:@"image/png" uploadFile:[NSString stringWithFormat:@"%@.png",localDate]];
        [dataM appendData:[topStr dataUsingEncoding:NSUTF8StringEncoding]];
    }else{
        //其它文件类型设置（暂无）（需注意文件的MimeType，每个文件的类型不一样）
        NSString *topStr = [self topStringWithMimeType:@"image/png" uploadFile:[NSString stringWithFormat:@"%@.png",localDate]];
        [dataM appendData:[topStr dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    
    NSString *bottomStr = [self bottomString];
    [dataM appendData:[bottomStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    [dataM appendData:data];
    
    // 1. Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:2.0f];
    
    // dataM出了作用域就会被释放,因此不用copy
    request.HTTPBody = dataM;
    
    // 2> 设置Request的头属性
    request.HTTPMethod = @"POST";
    
    // 3> 设置Content-Length
    NSString *strLength = [NSString stringWithFormat:@"%ld", (long)dataM.length];
    [request setValue:strLength forHTTPHeaderField:@"Content-Length"];
    
    // 4> 设置Content-Type
    NSString *strContentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", randomIDStr];
    [request setValue:strContentType forHTTPHeaderField:@"Content-Type"];
    
    // 3> 连接服务器发送请求
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        //回调
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        SBLog(@"%@", result);
        if (connectionError != nil) {
            fail(localDate,flag,result,connectionError);
        }else{
            sucess(localDate,flag,result);
        }
    }];

}

#pragma mark -- 上传文件私有方法
- (NSString *)topStringWithMimeType:(NSString *)mimeType uploadFile:(NSString *)uploadFile
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"%@%@\n", boundaryStr, randomIDStr];
    [strM appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\n", uploadID, uploadFile];
    [strM appendFormat:@"Content-Type: %@\n\n", mimeType];
    
    NSLog(@"%@", strM);
    return [strM copy];
}

- (NSString *)bottomString
{
    NSMutableString *strM = [NSMutableString string];
    
    [strM appendFormat:@"%@%@\n", boundaryStr, randomIDStr];
    [strM appendString:@"Content-Disposition: form-data; name=\"submit\"\n\n"];
    [strM appendString:@"Submit\n"];
    [strM appendFormat:@"%@%@--\n", boundaryStr, randomIDStr];
    
    NSLog(@"%@", strM);
    return [strM copy];
}

#pragma mark -- 下载图片
+(void)downloadImageWithURL:(NSString *)imgURL progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageDownloaderCompletedBlock)completedBlock{
    NSString* encodedString = [imgURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    
    SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
    [downloader downloadImageWithURL:[NSURL URLWithString:encodedString] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        progressBlock(receivedSize,expectedSize);
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        completedBlock(image,data,error,finished);
    }];
}


@end
