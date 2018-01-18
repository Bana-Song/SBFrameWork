//
//  SBPhotoBrowser.h
//  SBImageViewer
//  图片浏览器
//  Created by pg on 16/6/13.
//  Copyright © 2016年 Bana. All rights reserved.
//

/********************
 
 用法：
 
         NSMutableArray *photos = [NSMutableArray array];
         
         for (int i=0; i<self.imageViews.count; i++) {
         
         UIImageView *child = self.imageViews[i];
         [photos addObject:child];
         
         }
         
         self.photoBrowser = [[SBPhotoBrowser alloc] init];
         self.photoBrowser.photos =  photos;
         [self.photoBrowser show:self.imgV];
 

 
 *********************/


#import <UIKit/UIKit.h>

@interface SBPhotoBrowser : UIView

/**
 *  存放图片的数组
 */
@property (nonatomic,strong) NSArray *originPhotos;



/**
 *  显示图片浏览器
 */
-(void)show:(UIImageView *)selectedView;

@end
