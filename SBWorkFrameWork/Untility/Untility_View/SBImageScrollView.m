//
//  SBImageScrollView.m
//
//
//  Created by pg on 16/6/24.
//  Copyright © 2016年 zeluli. All rights reserved.
//


#import "SBImageScrollView.h"
#import "CustomScrollView.h"
#import "CustomPageControl.h"
#import "CustomImageView.h"


@interface SBImageScrollView()<UIScrollViewDelegate>

@property (nonatomic,strong) CustomScrollView *scrollView;
@property (nonatomic, weak) CustomPageControl *pageControl;
@property (nonatomic, assign) CGFloat imgW;
@property (nonatomic, assign) CGFloat imgH;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSArray *imageViews;
@property (nonatomic, assign) NSInteger imageCount;


@end

@implementation SBImageScrollView


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blueColor];
        CustomScrollView *scrollView = [[CustomScrollView alloc] init];
        self.scrollView = scrollView;
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.backgroundColor = [UIColor whiteColor];
        [self addSubview:scrollView];
        self.imgW = frame.size.width;
        self.imgH = frame.size.height;
        [self setNeedsLayout];
        
        CustomPageControl *pageControl = [[CustomPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height - 10, ScreenWidth, 10)];
        self.pageControl = pageControl;
        self.pageControl.numberOfPages = 1;
        self.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        [self addSubview:pageControl];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        
    }
    
    return self;
    
}

- (void)nextImage{
    NSInteger page = self.pageControl.currentPage;
    page = self.pageControl.currentPage + 1;
    CGPoint offset = CGPointMake((1 + page) * self.imgW, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}

- (void)setupImageViews{
    
    for (int i = 0; i < self.images.count + 2; i++) {
        CustomImageView *imageView = [[CustomImageView alloc] init];
        CGFloat imageX = i * self.imgW;
        CGFloat imageY = 0;
        CGFloat imageW = self.imgW;
        CGFloat imageH = self.imgH;
        imageView.frame = CGRectMake(imageX, imageY, imageW,imageH);
        [self.scrollView insertSubview:imageView atIndex:0];
    }
    
}

- (NSArray *)imageViews{
    
    if (_imageViews == nil) {
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i < self.images.count + 2; i++) {
            CustomImageView *imageView = [[CustomImageView alloc] init];
            CGFloat imageX = i * self.imgW;
            CGFloat imageY = 0;
            CGFloat imageW = self.imgW;
            CGFloat imageH = self.imgH;
            imageView.frame = CGRectMake(imageX, imageY, imageW,imageH);
            [self.scrollView insertSubview:imageView atIndex:0];
            [arr addObject:imageView];
        }
        _imageViews = arr;
    }
    
    return _imageViews;
    
}


- (void)setImages:(NSArray *)images{
    
    _images = images;
    self.imageCount = images.count;
    self.pageControl.numberOfPages = self.imageCount;
    [self addPics];
    
}

- (void)addPics{
    
    for (int i = 0; i < self.images.count + 2; i++) {
        CustomImageView *imageView = self.imageViews[i];
        if (i == 0) {
            imageView.image = [UIImage imageNamed:[self.images lastObject]];
        }else if(i == self.images.count + 1){
            imageView.image = [UIImage imageNamed:[self.images firstObject]];
        }else{
            imageView.image = [UIImage imageNamed:self.images[i-1]];
        }
    }
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    self.scrollView.contentSize = CGSizeMake((self.imageCount + 2) * self.imgW, 0);
    [self.scrollView setContentOffset:CGPointMake(self.imgW, 0) animated:NO];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop ] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x == self.imgW * (self.imageCount + 1)) {
        [self.scrollView setContentOffset:CGPointMake(self.imgW, 0) animated:NO];
    }else if(scrollView.contentOffset.x == 0){
        [self.scrollView setContentOffset:CGPointMake(self.imgW * (self.imageCount), 0) animated:NO];
    }
    
    self.pageControl.currentPage = (self.scrollView.contentOffset.x + self.imgW * 0.5f) / self.imgW - 1;
    
}
@end
