//
//  UIImage_Extension.h
//  SBWorkFrameWork
//
//  Created by pg on 16/6/8.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface  UIImage(CustomImage)

/** 等比例缩放图片 */
-(UIImage *)resizeImageWithSize:(CGSize)size;

/** 等比例缩放图片，宽度不能超出maxWidth */
- (UIImage*)resizeImageWithMaxWidth:(CGFloat)maxWidth;

/** 根据Color和Size生成Image */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/** UIView转换为Image */
+ (UIImage*)imageWithView:(UIView*)view;


/** 图片转base64 */
- (NSString *)base64String;
- (NSString *)sizeForServerToBase64String;
/** 修改图片透明度 */
- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;


/** 处理旋转90 的问题 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;
@end
