//
//  SBDatePickerView.h
//  SBWorkFrameWork
//
//  Created by pg on 16/5/31.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBPickerView;
@protocol SBPickerViewDelegate <NSObject>

-(void)SBPickerView:(SBPickerView *)pickerView anddidSelectedIndex:(NSInteger)index anddidSelectedContent:(NSString *)content;

@end

@interface SBPickerView : UIView

@property (nonatomic,strong) UIPickerView *pickerView;
@property (nonatomic,strong) NSArray *dataAry;
@property (nonatomic,strong) UIButton *leftBtn;
@property (nonatomic,strong) UIButton *rightBtn;

@property (nonatomic,strong) id<SBPickerViewDelegate> pickerViewDelegate;


@end
