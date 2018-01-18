//
//  CustomNAVC.m
//  QWLProject
//
//  Created by pg on 16/3/11.
//  Copyright © 2016年 shiwenbin. All rights reserved.
//

#import "CustomNAVC.h"

@interface CustomNAVC ()

@end

@implementation CustomNAVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"PJLNa"] forBarMetrics:UIBarMetricsDefault];
    id navigationTitleAttribute = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationBar.titleTextAttributes = navigationTitleAttribute;
    UIImageView *navigationImageView = [self hairlineImageViewInNavigationBar:self.navigationController.navigationBar];
    navigationImageView.hidden = true;//隐藏黑线，如需开启，请改为false
    self.navigationBar.shadowImage = [UIImage new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIImageView *)hairlineImageViewInNavigationBar:(UIView *)view {
    if ([view isKindOfClass:[UIImageView class]] && view.bounds.size.height <= 1) {
        return (UIImageView *)view;
    }
    NSArray *subviews = view.subviews;
    for (UIView *subview in subviews) {
        UIImageView *imageView = [self hairlineImageViewInNavigationBar:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
@end
