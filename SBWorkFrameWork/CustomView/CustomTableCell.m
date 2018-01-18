//
//  CustomTableCell.m
//  QWLProject
//
//  Created by pg on 16/3/11.
//  Copyright © 2016年 shiwenbin. All rights reserved.
//

#import "CustomTableCell.h"

@interface CustomTableCell()
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UIView *bottomView;

 //自定义滑动删除效果
@property (strong, nonatomic) UIView *moveView;
@end


@implementation CustomTableCell

-(UIView *)moveView {
    if (!_moveView) {
        _moveView = [[UIView alloc] init];
        _moveView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    }
    return _moveView;
}

-(UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]init];
    }
    return _topView;
}
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
    }
    return _bottomView;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setCellBottomLineSpace:(CGFloat)leftSpace andRight:(CGFloat)rightSpace{
    CGRect frame = self.bottomView.frame;
    frame.origin.x = leftSpace;
    frame.size.width = ScreenWidth - leftSpace - rightSpace;
    self.bottomView.frame = frame;
}


-(void)setCustomLineColorWithTop:(UIColor *)topLineColor andBottom:(UIColor *)bottomColor andCellHeight:(CGFloat)height andLineHeigt:(CGFloat)lineHeight{
    if (topLineColor != nil){
        self.topView.frame = CGRectMake(0, 0, [UIApplication sharedApplication].keyWindow.frame.size.width, lineHeight);
        self.topView.backgroundColor = topLineColor;
        [self addSubview:self.topView];
    }
    if (bottomColor != nil){
        self.bottomView.frame = CGRectMake(0, height - lineHeight, [UIApplication sharedApplication].keyWindow.frame.size.width, lineHeight);
        self.bottomView.backgroundColor = bottomColor;
        [self addSubview:self.bottomView];
    }
    
}

-(void)setCustomSwipeDeleteAnimate {
    //添加左滑手势
    UISwipeGestureRecognizer *swipLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swip:)];
    swipLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.moveView addGestureRecognizer:swipLeft];
    //添加右滑手势
    UISwipeGestureRecognizer *swipRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swip:)];
    swipRight.direction=UISwipeGestureRecognizerDirectionRight;
    [self.moveView addGestureRecognizer:swipRight];
}


- (void)swip:(UISwipeGestureRecognizer *)swipe{
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        // 打开
        [self openMenu];
        
        // 将其他已打开的关闭
        if( self.mySwipeBlock ){
            self.mySwipeBlock();
        }
    }else if (swipe.direction == UISwipeGestureRecognizerDirectionRight){
        // 关闭
        [self closeMenu];
    }
}

- (IBAction)deleteAction:(UIButton *)sender {
    if(sender.tag == 666){
        // 取消
        [self closeMenu];
        
    }else if (sender.tag == 777){
        // 删除
        if(self.myDeleteBlock){
            self.myDeleteBlock();
        }
        
    }
}

- (void)openMenu{
    if (self.isOpen) {
        return;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.moveView.center = CGPointMake(self.moveView.center.x - 130, self.moveView.center.y);
    }completion:^(BOOL finished) {
        if(finished){
            self.isOpen = YES;
        }
    }];
}

/**关闭左滑菜单*/
-(void)closeMenu
{
    if(!_isOpen)
        return;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.moveView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, self.moveView.center.y);
    }completion:^(BOOL finished) {
        if (finished) {
            self.isOpen = NO;
        }
    }];
    
}

@end
