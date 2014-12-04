//
//  userFigTableViewController.m
//  哎呀吃什么
//
//  Created by 王振宇 on 14/12/4.
//  Copyright (c) 2014年 王振宇. All rights reserved.
//

#import "userFigTableViewController.h"
#import "DXAlertView.h"
#import "JGProgressHUD.h"
#import "JGProgressHUDPieIndicatorView.h"
#import "JGProgressHUDRingIndicatorView.h"
#import "JGProgressHUDFadeZoomAnimation.h"

@interface userFigTableViewController ()
{
    JGProgressHUD *indicator;
}

@end

@implementation userFigTableViewController
@synthesize selfLoginSwitch=_selfLoginSwitch;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    [_selfLoginSwitch setOn:[userDefaults boolForKey:@"selfLoginBool"]];
    
    indicator = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleLight];
    indicator.userInteractionEnabled = YES;
    indicator.delegate = self;
    UIImageView *errorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jg_hud_success.png"]];
    indicator.textLabel.text = @"清除成功!";
    JGProgressHUDIndicatorView *ind = [[JGProgressHUDIndicatorView alloc] initWithContentView:errorImageView];
    indicator.progressIndicatorView = ind;
    indicator.square = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selfLoginSwitchAction:(id)sender {
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
     BOOL setting;
   if([_selfLoginSwitch isOn])
   {
       setting =YES;
   }else
   {
       setting=NO;
   }
    [userDefaults setBool:setting forKey:@"selfLoginBool"];
}

- (IBAction)clearAllInfoButtonAction:(id)sender {
    
    if([[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePath]])          //如果该文件存在
    {
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"警告" contentText:@"您所有的美食信息都将被清除\n请谨慎操作" leftButtonTitle:@"取消" rightButtonTitle:@"清除"];
        alert.rightBlock = ^() {
            
            [[NSFileManager defaultManager] removeItemAtPath:[self dataFilePath] error:nil];
            [indicator showInView:self.navigationController.view];
            [indicator dismissAfterDelay:1.0];
        };
        [alert show];
        
    }else
    {
        
     DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"您没有缓存数据" leftButtonTitle:nil rightButtonTitle:@"知道了"];
        [alert show];
    }
    
}

- (IBAction)cancelUserButtonAction:(id)sender {
    
}


/*
 用来返回food.plist数据文件的完整路径名
 */

-(NSString *)dataFilePath
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *paths = [path objectAtIndex:0];
    
    return [paths stringByAppendingPathComponent:@"food.plist"];
    
}
@end
