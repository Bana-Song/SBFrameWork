//
//  SBDatePickerView.m
//  SBWorkFrameWork
//
//  Created by pg on 16/5/31.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import "SBPickerView.h"

@interface SBPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>

@end

@implementation SBPickerView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectMake(0, 0, frame.size.width, ScreenHeight)];
    if (self) {
        self.backgroundColor = SBColorWithRGB(0, 0, 0, 0.3);
        [self addPickerView:frame];
    }
    return  self;
}

//添加系统PickerView
-(void)addPickerView:(CGRect)frame{
    
    UIView *topView = [[UIView alloc] initWithFrame:frame];
    topView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:topView];
    
    CGRect pickerFrame =  CGRectMake(frame.origin.x, frame.origin.y + 40, frame.size.width, frame.size.height - 40);
    _pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    _pickerView.backgroundColor = [UIColor whiteColor];
    [_pickerView selectRow:0 inComponent:0 animated:true];
    [self addSubview:_pickerView];
    
    
    
    //取消按钮
    _leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(frame.origin.x + 10, frame.origin.y + 10, 40, 20)];
    [_leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(cancelSelected) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_leftBtn];
    
    //确定按钮
    _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(frame.origin.x + frame.size.width - 10 - 40, frame.origin.y + 10, 40, 20)];
    [_rightBtn addTarget: self action:@selector(confirmSelected) forControlEvents:UIControlEventTouchUpInside];
    [_rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self addSubview:_rightBtn];
}

-(void)cancelSelected{
    //从父视图中移除
    [self removeFromSuperview];
}
-(void)confirmSelected {
    //确认的时候获得系统pickerview选中的行的内容，走代理
    NSInteger row = [_pickerView selectedRowInComponent:0];
    NSString *titleStr = self.dataAry[row];
    [self.pickerViewDelegate SBPickerView:self anddidSelectedIndex:row anddidSelectedContent:titleStr];
    [self removeFromSuperview];
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataAry.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *titleStr = self.dataAry[row];
    return titleStr;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *titleStr = self.dataAry[row];
    [self.pickerViewDelegate SBPickerView:self anddidSelectedIndex:row anddidSelectedContent:titleStr];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}

@end
