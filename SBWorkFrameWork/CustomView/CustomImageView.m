//
//  CustomImageView.m
//  QWLProject
//
//  Created by pg on 16/3/15.
//  Copyright © 2016年 shiwenbin. All rights reserved.
//

#import "CustomImageView.h"
#import "SBPhotoBrowser.h"
#import "SDWebImageManager.h"

@implementation CustomImageView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(void)showImageViews:(NSArray *)imageViews andSelectedView:(UIImageView *)selectedView{
    
    SBPhotoBrowser *photoBrowser = [[SBPhotoBrowser alloc] init];
    if (imageViews == nil) {
        photoBrowser.originPhotos = @[selectedView];
    }else{
        photoBrowser.originPhotos = imageViews;
    }
    [photoBrowser show:selectedView];
}

-(void)setImageWithURL:(NSString *)imgURL{
    NSString* encodedString = [imgURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self sd_setImageWithURL:[NSURL URLWithString:encodedString]];
}

-(void)setImageWithURL:(NSString *)imgURL andPlaceHolder:(NSString *)placeholder{
    NSString* encodedString = [imgURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString* encodedString2 = [placeholder stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self sd_setImageWithURL:[NSURL URLWithString:encodedString] placeholderImage:[UIImage imageNamed:encodedString2]];
}

-(void)setimageUrl:(NSString *)imgURL andPlaceHolder:(NSString *)placeHolder andComplete:(SDWebImageCompletionBlock)completedBlock{
    NSString* encodedString = [imgURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString* encodedString2 = [placeHolder stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self sd_setImageWithURL:[NSURL URLWithString:encodedString] placeholderImage:[UIImage imageNamed:encodedString2] completed:completedBlock];
}

+(void)loadImageCache:(NSString *)imgURL{
    SDWebImageManager *mananger = [SDWebImageManager sharedManager];
    [mananger downloadImageWithURL:[NSURL URLWithString:imgURL] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
    }];
}

+(void)saveImageToCache:(UIImage *)img andURL:(NSString *)imgURL {
    SDImageCache *cache = [SDImageCache sharedImageCache];
    [cache storeImage:img forKey:imgURL toDisk:YES];
}



+(UIImage *)cahedImgWithURL:(NSString *)url {
    
    SDImageCache *cache = [SDImageCache sharedImageCache];
    if ([cache diskImageExistsWithKey:url]) {
        return [cache imageFromDiskCacheForKey:url];
    }
    return nil;
}


+(UIImage *)cahedImgWithURL:(NSString *)url andCompletion:(SDWebImageCheckCacheCompletionBlock)complete{
    SDImageCache *cache = [SDImageCache sharedImageCache];
    [cache diskImageExistsWithKey:url completion:complete];
    return nil;
}

-(void)addSBGesture:(id)delegate action:(SEL)selector{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:delegate action:selector];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}
+(UIImage *)imageFromMemoryCacheForKey:(NSString *)url{
    SDImageCache *cache = [SDImageCache sharedImageCache];
    return [cache imageFromMemoryCacheForKey:url];
}

@end
