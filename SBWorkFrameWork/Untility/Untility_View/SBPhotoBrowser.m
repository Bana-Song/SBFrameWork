
//
//  SBPhotoBrowser.m
//  SBImageViewer
//
//  Created by pg on 16/6/13.
//  Copyright © 2016年 Bana. All rights reserved.
//


//#define ScreenWidth [UIScreen mainScreen].bounds.size.width
//#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define MYKeyWindow [UIApplication sharedApplication].keyWindow

#define bigScrollViewTag 1001

#import "SBPhotoBrowser.h"

@interface SBPhotoBrowser()<UIScrollViewDelegate,UIGestureRecognizerDelegate>


//新的图片数组
@property (nonatomic,strong) NSArray *photos;

/**
 *  底层滑动的scrollview
 */
@property (nonatomic,weak) UIScrollView *bigScrollView;

/**
 *  黑色背景view
 */
@property (nonatomic,weak) UIView *blackView;


/**
 *  当前的index
 */
@property (nonatomic,assign) NSInteger currentIndex;

@end

@implementation SBPhotoBrowser


-(void)setPhotos:(NSArray *)photos {
    NSMutableArray *mutAry = [NSMutableArray array];
    for (UIImageView *i in photos) {
        if ([i isKindOfClass:[UIImageView class]]) {
            UIImageView *photo = [[UIImageView alloc] init];
            photo.image = i.image;
            [mutAry addObject:photo];
        }
    }
    _photos = [mutAry mutableCopy];
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = MYKeyWindow.bounds;
        
        //设置背景色
        [self setupBlackView];
        
        //添加底部滚动视图
        [self addScrollView];
    }
    return self;
}

-(void)setupBlackView{
    
    UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    blackView.backgroundColor = [UIColor blackColor];
    [self addSubview:blackView];
    self.blackView = blackView;
    
}

-(void)addScrollView{
    UIScrollView *bigScrollView = [[UIScrollView alloc] init];
    bigScrollView.backgroundColor = [UIColor clearColor];
    bigScrollView.delegate = self;
    bigScrollView.tag = bigScrollViewTag;
    bigScrollView.pagingEnabled = YES;
    bigScrollView.bounces = YES;
    bigScrollView.showsHorizontalScrollIndicator = NO;
    CGFloat scrollViewX = 0;
    CGFloat scrollViewY = 0;
    CGFloat scrollViewW = ScreenWidth;
    CGFloat scrollViewH = ScreenHeight;
    bigScrollView.frame = CGRectMake(scrollViewX, scrollViewY, scrollViewW, scrollViewH);
    [self addSubview:bigScrollView];
    self.bigScrollView = bigScrollView;
}

-(void)show:(UIImageView *)selectedView{
    
    
    self.currentIndex = [self.originPhotos indexOfObject:selectedView];
    
    self.photos = self.originPhotos;
    
    //    1.添加视图
    [MYKeyWindow addSubview:self];
    
    //3.设置滚动距离
    self.bigScrollView.contentSize = CGSizeMake(ScreenWidth*self.photos.count, 0);
    self.bigScrollView.contentOffset = CGPointMake(ScreenWidth*self.currentIndex, 0);
    
    //4.创建子视图
    [self setupSmallScrollViews];
}


-(void)setupSmallScrollViews{
    for (int i=0; i<self.photos.count; i++) {
        
        UIScrollView *smallScrollView = [[UIScrollView alloc] init];
        smallScrollView.backgroundColor = [UIColor clearColor];
        smallScrollView.tag = i;
        smallScrollView.frame = CGRectMake(ScreenWidth*i, 0, ScreenWidth, ScreenHeight);
        smallScrollView.delegate = self;
        smallScrollView.maximumZoomScale=3.0;
        smallScrollView.minimumZoomScale=1;
        [self.bigScrollView addSubview:smallScrollView];
        
        UIImageView *photo = self.photos[i];
        CGFloat ratio = (double)photo.image.size.height/(double)photo.image.size.width;
        CGFloat bigH = ScreenWidth*ratio;
        if (bigH > ScreenHeight) {
            smallScrollView.contentSize = CGSizeMake(0,bigH);
        }
        photo.tag = i;
        photo.clipsToBounds = YES;
        photo.userInteractionEnabled  = YES;
        photo.contentMode = UIViewContentModeScaleAspectFill;
        
        //添加手势
        UITapGestureRecognizer *photoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)];
        UITapGestureRecognizer *zonmTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zonmTap:)];
        zonmTap.numberOfTapsRequired = 2;
        zonmTap.delegate = self;
        [photo addGestureRecognizer:photoTap];
        [photo addGestureRecognizer:zonmTap];
        
        [photoTap requireGestureRecognizerToFail:zonmTap];
        
        
        
        [smallScrollView addSubview:photo];
        [UIView animateWithDuration:0.3 animations:^{
            
            self.blackView.alpha = 0.5;
            
            CGFloat ratio = (double)photo.image.size.height/(double)photo.image.size.width;
            
            CGFloat bigW = ScreenWidth;
            CGFloat bigH = ScreenWidth*ratio;
            
            photo.bounds = CGRectMake(0, 0, bigW, bigH);
            
            if (bigH > ScreenHeight) {
                photo.center = CGPointMake(ScreenWidth/2, bigH/2);
            }else{
                photo.center = CGPointMake(ScreenWidth/2, ScreenHeight/2);
            }
            
        }];
    }
}


-(void)zonmTap:(UITapGestureRecognizer *)zonmTap{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        UIScrollView *smallScrollView = (UIScrollView *)zonmTap.view.superview;
        smallScrollView.zoomScale = 3.0;
        
    }];
    
}

-(void)photoTap:(UITapGestureRecognizer *)photoTap{
    
    UIImageView *photo = (UIImageView *)photoTap.view;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        photo.frame = CGRectMake(0, 0, 0, 0);
        self.blackView.alpha = 0;
        
        
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    
}


#pragma mark UIScrollViewDelegate

//告诉scrollview要缩放的是哪个子控件
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    
    if (scrollView.tag == bigScrollViewTag) {
        return nil;
    }
    
    UIImageView *photo = self.photos[scrollView.tag];
    
    return photo;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    if (scrollView.tag == bigScrollViewTag) {
        return;
    }
    
    UIImageView *photo = (UIImageView *)self.photos[scrollView.tag];
    
    CGFloat photoY = (ScreenHeight-photo.frame.size.height)/2;
    CGRect photoF = photo.frame;
    
    if (photoY>0) {
        
        photoF.origin.y = photoY;
        
    }else{
        
        photoF.origin.y = 0;
        
    }
    
    photo.frame = photoF;
    
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int currentIndex = scrollView.contentOffset.x/ScreenWidth;
    
    if (self.currentIndex!=currentIndex && scrollView.tag==bigScrollViewTag) {
        
        self.currentIndex = currentIndex;
        
        for (UIView *view in scrollView.subviews) {
            
            if ([view isKindOfClass:[UIScrollView class]]) {
                
                UIScrollView *scrollView = (UIScrollView *)view;
                scrollView.zoomScale = 1.0;
            }
            
        }
        
    }
}

#pragma mark 设置frame

-(void)setFrame:(CGRect)frame{
    
    frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    
    [super setFrame:frame];
    
}

#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

@end
