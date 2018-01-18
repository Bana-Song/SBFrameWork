//
//  CustomAlertView.m
//  TempTest
//
//  Created by pg on 16/6/14.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import "CustomAlertView.h"

@interface CustomAlertView()

@property (nonatomic,strong) UIView *mainView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *messageLabel;
@property (nonatomic,strong) NSArray *actions;

@end


@implementation CustomAlertView

static CGFloat mainWith = 300;

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [self initView];
    }
    return self;
}


-(void)initView {
    _mainView = [[UIView alloc]init];
    _mainView.backgroundColor = [UIColor whiteColor];
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.frame = CGRectMake(0, 0, mainWith, 40);
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_mainView addSubview:_titleLabel];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    lineView.frame = CGRectMake(0, 40 , mainWith, 1);
    [_mainView addSubview:lineView];
    
    _messageLabel = [[UILabel alloc] init];
    _messageLabel.frame = CGRectMake(0, CGRectGetMaxY(_titleLabel.frame) + 1, mainWith, 1);
    _messageLabel.backgroundColor = [UIColor clearColor];
    [_mainView addSubview:_messageLabel];
    
    [self addSubview:_mainView];
}

-(void)showWithActionArray:(NSArray *)actions andTitle:(NSString *)title andMessage:(NSString *)message{
    CGRect rect = [[NSString stringWithFormat:@"%@",message] boundingRectWithSize:CGSizeMake(80, 300) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil];
    _titleLabel.text = title;
    _messageLabel.text = message;
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    _messageLabel.frame = CGRectMake(0, CGRectGetMaxY(_titleLabel.frame) + 1, mainWith, rect.size.height);
    _messageLabel.numberOfLines = 0;
    
    if (actions.count > 0) {
        _actions = actions;
        _mainView.frame = CGRectMake(0, 0, mainWith, rect.size.height + 81);
    }else{
        _mainView.frame = CGRectMake(0, 0, mainWith, rect.size.height + 41);
    }
    _mainView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2 - 100);
    
    [self addButtons:actions];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

-(void)addButtons:(NSArray *)actions{
    CGFloat width = (mainWith / actions.count);
    CGFloat x = 0;
    for (int i = 0 ; i < actions.count; i++ ) {
        x = i * width;
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:actions[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.backgroundColor = [UIColor clearColor];
        btn.frame = CGRectMake(x , CGRectGetMaxY(_messageLabel.frame), width, 40);
        btn.tag = i;
        
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_mainView addSubview:btn];
    }
}

-(void)clickBtn:(UIButton *)sender{
    NSString *title = _actions[sender.tag];
    if ([title isEqualToString:@"取消"] || [title isEqualToString:@"Cancel"]) {
        _actions = nil;
        [self removeFromSuperview];
        return;
    }
    
    [self.sbDelegate didSelectedIndex:sender.tag andAcion:title];
    _actions = nil;
    [self removeFromSuperview];

}



@end
