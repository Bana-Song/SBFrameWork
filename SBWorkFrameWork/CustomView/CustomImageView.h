//
//  CustomImageView.h
//  QWLProject
//
//  Created by pg on 16/3/15.
//  Copyright © 2016年 shiwenbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomImageView : UIImageView

/**
 设置图片浏览器数据
 */
-(void)showImageViews:(UIImageView *)imageViews andSelectedView:(UIImageView *)selectedView;


/** 设置图片 */
-(void)setImageWithURL:(NSString *)imgURL;

/** 设置图片
 1.图片地址
 2.默认图片
 */
-(void)setImageWithURL:(NSString *)imgURL andPlaceHolder:(NSString *)placeholder;

/** 设置图片
 1.图片地址
 2.默认图片
 3.完成后回调
 */
-(void)setimageUrl:(NSString *)imgURL andPlaceHolder:(NSString *)placeHolder andComplete:(SDWebImageCompletionBlock)completedBlock;

/**
 缓存图片
 */
+(void)loadImageCache:(NSString *)imgURL;


/**
 保存图片缓存
 */
+(void)saveImageToCache:(UIImage *)img andURL:(NSString *)imgURL;



/**
 获取当前url 的图片缓存
 */
+(UIImage *)cahedImgWithURL:(NSString *)url;



/**
 获取当前url 的图片缓存
 */
+(UIImage *)cahedImgWithURL:(NSString *)url andCompletion:(SDWebImageCheckCacheCompletionBlock)complete;

+(UIImage *)imageFromMemoryCacheForKey:(NSString *)url;

-(void)addSBGesture:(id)delegate action:(SEL)selector;

@end
