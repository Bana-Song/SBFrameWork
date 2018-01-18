//
//  CustomTableCell.h
//  QWLProject
//
//  Created by pg on 16/3/11.
//  Copyright © 2016年 shiwenbin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^swipeBlock) ();
typedef void(^deleteBlock) ();
typedef void(^cancleBlock) ();


@interface CustomTableCell : UITableViewCell

//自定义侧滑删除
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, copy)swipeBlock mySwipeBlock;
@property (nonatomic, copy)deleteBlock myDeleteBlock;

/** 设置cell的底部或顶部线条 */
-(void)setCustomLineColorWithTop:(UIColor *)topLineColor andBottom:(UIColor *)bottomColor andCellHeight:(CGFloat)height andLineHeigt:(CGFloat)lineHeight;

/** 设置自定义滑动删除效果 */
-(void)setCustomSwipeDeleteAnimate;


/**  设置底部距离两遍 */
-(void)setCellBottomLineSpace:(CGFloat)leftSpace andRight:(CGFloat)rightSpace;


@end
