//
//  SBSharedMenu.m
//  SBWorkFrameWork
//
//  Created by pg on 16/5/27.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import "SBSharedMenu.h"
#import <sys/socket.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>
#import <net/if.h>
#import <arpa/inet.h>

@implementation SBSharedMenu
+(SBSharedMenu *)sharedIntance{
    static SBSharedMenu *sharedManager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        
        sharedManager.serverIPAddress = [NSString stringWithFormat:@"%@",ServerIP];
        
    });
    return sharedManager;
}

/** 获取字符串的宽 */
-(CGFloat)getWidthWithString:(NSString *)content andFontSize:(CGFloat)fontSize{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGRect rect = [content boundingRectWithSize:CGSizeMake(ScreenWidth, ScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.width;
}

/** 获取字符串的高 */
-(CGFloat)getHeightWithString:(NSString *)content andFontSize:(CGFloat)fontSize{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGRect rect = [content boundingRectWithSize:CGSizeMake(ScreenWidth, ScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.height;
}


/** 获取字符串的宽,限定宽度 */
-(CGFloat)getWidthWithString:(NSString *)content andFontSize:(CGFloat)fontSize andMaxWidth:(CGFloat)maxWidth{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGRect rect = [content boundingRectWithSize:CGSizeMake(ScreenWidth, ScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    if (rect.size.width > maxWidth) {
        return maxWidth;
    }
    return rect.size.width;
}
/** 获取字符串的高,限定高度 */
-(CGFloat)getHeightWithString:(NSString *)content andFontSize:(CGFloat)fontSize andMaxHeight:(CGFloat)maxHeight{
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    CGRect rect = [content boundingRectWithSize:CGSizeMake(ScreenWidth, ScreenHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    if (rect.size.height > maxHeight) {
        return maxHeight;
    }
    return rect.size.height;
}

-(UIImage *)createQCodeWithURL:(NSString *)URLStr{
    UIImage *resultImg = [[UIImage alloc] init];
    
    // 1.创建滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.还原滤镜默认属性
    [filter setDefaults];
    
    // 3.设置需要生成二维码的数据到滤镜中
    // OC中要求设置的是一个二进制数据
    NSData *data = [URLStr dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"InputMessage"];
    
    // 4.从滤镜从取出生成好的二维码图片
    CIImage *ciImage = [filter outputImage];
    
    if (ciImage != nil) {
        resultImg = [self createNonInterpolatedUIImageFormCIImage:ciImage size: 108];
    }
    return resultImg;
}

//保存二维码为高清图片
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)ciImage size:(CGFloat)widthAndHeight
{
    CGRect extentRect = CGRectIntegral(ciImage.extent);
    CGFloat scale = MIN(widthAndHeight / CGRectGetWidth(extentRect), widthAndHeight / CGRectGetHeight(extentRect));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extentRect) * scale;
    size_t height = CGRectGetHeight(extentRect) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:ciImage fromRect:extentRect];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extentRect, bitmapImage);
    
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage]; // 黑白图片
}


//获取ip地址
-(NSString *)getIPForPhone{
    //通过socket获取ip地址
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd == 0) return @"";
    NSMutableArray *ips = [NSMutableArray array];
    int BUFFERSIZE = 4096;
    struct ifconf ifc;
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    struct ifreq *ifr, ifrcopy;
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) >= 0){
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            ifr = (struct ifreq *)ptr;
            int len = sizeof(struct sockaddr);
            if (ifr->ifr_addr.sa_len > len) {
                len = ifr->ifr_addr.sa_len;
            }
            ptr += sizeof(ifr->ifr_name) + len;
            if (ifr->ifr_addr.sa_family != AF_INET) continue;
            if ((cptr = (char *)strchr(ifr->ifr_name, ':')) != NULL) *cptr = 0;
            if (strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0) continue;
            memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            if ((ifrcopy.ifr_flags & IFF_UP) == 0) continue;
            NSString *ip = [NSString  stringWithFormat:@"%s", inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    //socket一定要关闭！
    close(sockfd);
    NSString *deviceIP = @"";
    for (int i=0; i < ips.count; i++)
    {
        if (ips.count > 0)
        {
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
        }
    }
    return deviceIP;
}

-(NSString *)appVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

-(NSString *)appName{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleDisplayName"];
}

-(NSString *)identifierNumber{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

-(CGFloat)appSystemVersion{
     return [[[UIDevice currentDevice] systemVersion] floatValue];
}

#pragma mark -- 用户基本数据
-(void)saveLocalModel:(UserInfoModel *)userInfoModel{
    [self saveLocalObject:userInfoModel];
}

-(UserInfoModel *)getLocalModel{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSData *getData = [defaults objectForKey:@"SBLocalModel"];
    UserInfoModel *getModel = [NSKeyedUnarchiver unarchiveObjectWithData:getData];
    if (getModel == nil) {
        getModel = [UserInfoModel new];
        getModel.isLogin = NO;
    }
    return getModel;
}

-(void)saveLocalObject:(UserInfoModel *)model{
    NSData *getData = [NSKeyedArchiver archivedDataWithRootObject:model];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:getData forKey:@"SBLocalModel"];
    [defaults synchronize];
}

-(BOOL)isLogin{
    UserInfoModel *model = [self getLocalModel];
    return model.isLogin;
}

+(void)clearCache {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *crashPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        [SBSharedMenu removeFileWithPath:crashPath];
        NSString *crashPath2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        [SBSharedMenu removeFileWithPath:crashPath2];
        
        [[SDImageCache sharedImageCache] clearDisk];
        [[SDImageCache sharedImageCache] clearMemory];//可有可无
    });
}

+(void)removeFileWithPath:(NSString *)folderPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:folderPath error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename
            = [e nextObject])) {
        [fileManager
         removeItemAtPath:[folderPath stringByAppendingPathComponent:filename] error:NULL];
    }

}


@end
