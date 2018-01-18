//
//  ViewController.m
//  SBWorkFrameWork
//
//  Created by pg on 16/5/27.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import "ViewController.h"
#import "testVC.h"
#import "SBPickerView.h"
#import "SBCutomLabelMember.h"


@interface ViewController ()<SBPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) CustomTextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //1.自定义输出日志方法
    SBLog(@"测试文件内容%@",@"参数1")
    SBLog(@"测试%d",111)
    
    NSTimeInterval secondsPerDay = -24*60*60*3;
    
    
    SBLog(@"%@",[NSDate stringFromTimeInterval:secondsPerDay format:@"yyyy-MM-dd HH:mm:ss"]);
    SBLog(@"%ld",[NSDate judgeFromStringDateToAge:@"1999-02-05" andFormat:@"yyyy-MM-dd"]);
    SBLog(@"%@",[NSDate  judgeFromStringDate:@"1999-02-05" andFormat:@"yyyy-MM-dd"]);
    
    
    
//  self.view.backgroundColor = SBColorWithRGV(244 , 213 , 12 , 0.5); //自定义RGB设置颜色方法
//  self.view.backgroundColor = SBColorWith0xRGB(0xffd50c,0.5); //自定义十六进制转颜色方法，例如：0x + 十六进制
    self.view.backgroundColor = [UIColor whiteColor];
    
    //2.自定义label
    CustomLabel *label = [[CustomLabel alloc] init];
    label.frame = CGRectMake(0, 20, 100, 30);
    label.backgroundColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:12];
    
    [self.view addSubview:label];
    
//  label.text = @"啊123213insdaa去哦ID女青年我 in 去哦你欠我嗯哦弄恶趣味年轻哦温暖哦难为情哦你欠我嗯去我那哦那请问哦你去哦你请问哦企鹅哦乾我呢哦乾你";
//  [label setFitToWidthWithFont:12 andMaxWidth:200]; //自适应宽度
//  [label setFitToHeightWithFont:12 andMaxHeight:100]; //自适应高度
//  [label sizeToFit]; //自适应高度和宽度，系统自带
    [label setLine:[UIColor redColor] andLineType:SBCustomLabelLineTypeMiddle]; //设置横线，例如：这边是中划线
    
    SBCutomLabelMember *m1 = [[SBCutomLabelMember alloc] init];
    m1.font  = [UIFont systemFontOfSize:12];
    m1.textColor = [UIColor redColor];
    m1.text = @"测试";
    
    SBCutomLabelMember *m2 = [[SBCutomLabelMember alloc] init];
    m2.font  = [UIFont systemFontOfSize:16];
    m2.textColor = [UIColor blueColor];
    m2.text = @"特效";
    
    SBCutomLabelMember *m3 = [[SBCutomLabelMember alloc] init];
    m3.font  = [UIFont systemFontOfSize:12];
    m3.textColor = [UIColor blackColor];
    m3.text = @"效果";
    
    [label setCustomStyleWithModelsAry:@[m1,m2,m3]]; //设置各种文字特效
    
    
    CustomLabel *lab2 = [CustomLabel labelWithFrame:CGRectMake(120, 10, 100, 30) textColor:[UIColor redColor] font:[UIFont systemFontOfSize:12] context:@"label创建方法"];
    [self.view addSubview:lab2];
    
    

    //3.自定义button
    CustomButton *btn = [[CustomButton alloc] init];
    [btn setTitle:@"测试带阴影的btn" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    btn.frame = CGRectMake(0, 60, 120, 20);
    
    btn.backgroundColor = [UIColor whiteColor];
    btn.backgroundColor = [UIColor whiteColor];
    
    [btn setShadowOffset:CGSizeMake(0, 3) andAphla:0.5 andColor:nil andRadius:3]; //设置阴影
    
    [btn addTarget:self action:@selector(tempClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //4.自定义textView增加了设置自带placeHolder （不完善）
    CustomTextView *textView = [[CustomTextView alloc] init];
    self.textView = textView;
    textView.frame = CGRectMake(0, 90, ScreenWidth, ScreenHeight);
    textView.placeHolder = @"请输入";
    [self.view addSubview:textView];
    
    
    
    CustomButton *picBtn = [CustomButton buttonWithType:UIButtonTypeSystem];
    picBtn.frame = CGRectMake(0, 120, 100, 30);
    [picBtn setTitle:@"自定义picerView" forState:UIControlStateNormal];
    [picBtn addTarget:self action:@selector(clickPickerView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:picBtn];
    
    
    //5.字符串扩展方法
    NSString *str = @"";
    if ([NSString isBlankString:str]) {
        SBLog(@"字符串为空");
    };
    NSString *str2 = nil;
    if ([NSString isBlankString:str2]) {
        SBLog(@"字符串为空");
    };
    str = @"sdddasoind";
    if (![NSString isBlankString:str]) {
       
        SBLog(@"字符串不为空，32位加密后为：%@\r\n 16位加密后：%@", [NSString md5StrFor32:str],[NSString md5StrFor16:str]);
    };
    
//    if (![NSString isCorrectForamt:str andType:SBFormatTypeEmail]) {
//        [SBProgressHUD setDefaultMaskType:SBProgressHUDMaskTypeBlack];
//        [SBProgressHUD showErrorWithStatus:@"不是正确的邮箱"];
//    }
   // [NSString isCorrectForamt:str andType:SBFormatTypeEmail andAlertMsg:@"邮箱格式错误"];
//    [NSString isCorrectForamt:str andType:SBFormatTypeUserName andAlertMsg:@"用户名格式错误"];
    //[NSString isCorrectForamt:str andType:SBFormatTypeIP andAlertMsg:@"IP格式错误"];
    str = @"192.168.32.4";
    [NSString isCorrectForamt:str andType:SBFormatTypeIP andAlertMsg:@"IP格式错误"];
    
    //6.系统相关
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    NSString *appCurName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    
    SBLog(@"手机序列号:%@",[[SBSharedMenu sharedIntance] identifierNumber]);
    
    NSString *date = [NSDate transitionTimeString:@"2016-06-07 14:34:23" fromFormat:@"yyyy-MM-dd HH:mm:ss" toFormat:@"yyyy:MM:dd-hh:mm:ss"];
    SBLog(@"时间格式转换%@",date);
    
    
    
    
    //7.UIImage扩展 (将view转换为image，类似于截图)
    UIImage *img = [UIImage imageWithView:lab2];
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.frame = CGRectMake(120, 100, 200, 150);
    imgView.backgroundColor = [UIColor greenColor];
    //等比例缩放图片:按照宽度
    imgView.image = [img resizeImageWithMaxWidth:ScreenWidth];
    imgView.contentMode = UIViewContentModeCenter;
    
    [self.view addSubview:imgView];
    
    
    
    //8.数据持久化，NSUserDefault
    UserInfoModel *model = [[UserInfoModel alloc] init];
    model.userName = @"测试";
    model.passWord = @"2313";
    [[SBSharedMenu sharedIntance] saveLocalModel:model];
    
    UserInfoModel *getModel = [[SBSharedMenu sharedIntance] getLocalModel];
    SBLog(@"本地数据为：%@",getModel.userName);
    
    BOOL flag = [[NSUserDefaults standardUserDefaults] boolForKey:@"flag"];
    if (flag) {
        //登录
    }
}

-(void)clickPickerView {
    //自定义pickerview，添加了取消和确定方法
    SBPickerView *pickerView = [[SBPickerView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 400, ScreenWidth, 400)];
    pickerView.dataAry = @[@"12",@"23",@"34",@"35",@"46",@"57",@"68"];
    pickerView.pickerViewDelegate = self;
    [self.view addSubview:pickerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.textView endEditing:YES];
}

#pragma mark -- SBPickerView Delegate
-(void)SBPickerView:(SBPickerView *)pickerView anddidSelectedIndex:(NSInteger)index anddidSelectedContent:(NSString *)content{
    SBLog(@"选择行%ld,选择内容%@",index,content);
    
}


-(void) tempClick {
    testVC *t = [[testVC alloc] init];
    [self presentViewController:t animated:YES completion:nil];

}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
}


@end
