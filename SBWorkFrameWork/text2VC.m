//
//  text2VC.m
//  SBWorkFrameWork
//
//  Created by pg on 16/6/16.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import "text2VC.h"

@interface text2VC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (nonatomic,strong) CustomTableView *tableView;
@property (nonatomic,strong) CustomTextView *textView;
@end

@implementation text2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[CustomTableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView addRefreshControllerWithType:TDownPull PullBack:^{
        SBLog(@"下拉");
    } and:^{
        SBLog(@"上拉");
    }];
    //[self.view addSubview:_tableView];
    
    
//    typeof(self) weakSelf = self;
    [SBNetWork downloadImageWithURL:@"http://7xrx6o.com1.z0.glb.clouddn.com/XGD-6116a27a-bd78-48c7-829a-5a925d6e2f11_7_0_USER20130317041524278.jpg" progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        
        UIImageView *v = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, 300, 300)];
        v.backgroundColor = [UIColor redColor];
        v.image = image;
        
        //关于视图的设置需要会到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view addSubview:v];
        });
        
    }];
    
    CustomTextView *textView = [[CustomTextView alloc] initWithFrame:CGRectMake(0, 340, 300, 100)];
    textView.delegate = self;
    textView.placeHolder = @"测试textView的默认文字";
    _textView = textView;
    [self.view addSubview:textView];
    
}


//开始编辑
-(void)textViewDidBeginEditing:(UITextView *)textView{
    [_textView textViewDidBeginEditing:textView];
}

//结束编辑
-(void)textViewDidEndEditing:(UITextView *)textView{
    [_textView textViewDidEndEditing:textView];
}

//textView改变内容
-(void)textViewDidChange:(UITextView *)textView{
    [_textView textView:textView LimitLength:12];
}

//点击空白处
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_textView endEditing:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  0;
}
@end
