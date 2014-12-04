//
//  userFigTableViewController.m
//  哎呀吃什么
//
//  Created by 王振宇 on 14/12/4.
//  Copyright (c) 2014年 王振宇. All rights reserved.
//

#import "userFigTableViewController.h"

@interface userFigTableViewController ()

@end

@implementation userFigTableViewController
@synthesize selfLoginSwitch=_selfLoginSwitch;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    [_selfLoginSwitch setOn:[userDefaults boolForKey:@"selfLoginBool"]];
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
    
}

- (IBAction)cancelUserButtonAction:(id)sender {
    
}
@end
