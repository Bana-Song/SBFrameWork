//
//  CustomTextView.h
//  SBWorkFrameWork
//
//  Created by pg on 16/5/31.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextView : UITextView<UITextViewDelegate>

@property (nonatomic,strong) NSString *placeHolder;


- (void)textViewDidBeginEditing:(UITextView *)textView; //开始编辑

- (void)textViewDidEndEditing:(UITextView *)textView; //结束编辑

- (void)textView:(UITextView *)textView LimitLength:(NSInteger)maxLength; //限制输入最大长度

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text; //回车收回键盘事件

/** 设置字体大小
 带默认字体
 */
-(void)fontWithSize:(CGFloat)size;

//限制输入数字
+ (BOOL)validateNumber:(NSString*)number;

//过滤表情
+ (BOOL)isContainsTwoEmoji:(NSString *)string;
+ (NSString *)disable_emoji:(NSString *)text;
@end
