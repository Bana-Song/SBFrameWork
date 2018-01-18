//
//  testVC.m
//  SBWorkFrameWork
//
//  Created by pg on 16/5/30.
//  Copyright © 2016年 Bana. All rights reserved.
//

#import "testVC.h"
#import "text2VC.h"
#import "testModel.h"

@interface testVC ()

@end

@implementation testVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self SBRequestWithParams:nil andApiName:nil andBaseURL:@"http://www.raywenderlich.com/demos/weather_sample/weather.php?format=json" andIsGet:YES andNeedHUD:YES andHUDLoadingTitle:@"加载中" andHUDSucessTitle:@"加载成功" andHUDFailTitle:@"加载失败" andOtherFlag:@"test"];
//    [self addRefreshControllerWithType:TAllPull PullBack:^{
//        SBLog(@"下拉");
//    } and:^{
//        SBLog(@"上拉");
//    }];
    testModel *testModels = [[testModel alloc] init];
    testModels.nickname = @"测试";
    testModels.password = @"1111";
    testModels.username = @"测试啊";
    testModels.gender = @"1";
    testModels.account = @"123";
    
    NSDictionary *userInfo = [testModels toDictionary];
    
    [self SBRequestWithParams:userInfo andApiName:nil andBaseURL:@"http://192.168.4.62:8080/SJ.Backend/app/user/register" andIsGet:NO andNeedHUD:YES andHUDLoadingTitle:@"加载中" andHUDSucessTitle:@"加载成功" andHUDFailTitle:@"加载失败" andOtherFlag:@"test"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)SBRequestSucess:(id)responseObject andApiName:(NSString *)ApiName andFlag:(NSString *)flag{
    SBLog(@"请求成功,标志符:%@",flag);
}

-(void)SBRequestFail:(id)error andApiName:(NSString *)ApiName andFlag:(NSString *)flag{
    SBLog(@"请求失败,error:%@,标志符:%@",ApiName,flag);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = @"点击";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    text2VC *t2 = [[text2VC alloc] init];
    [self presentViewController:t2 animated:YES completion:nil];
}

@end
