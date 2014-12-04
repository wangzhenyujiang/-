
//
//  configTableViewController.m
//  哎呀吃什么
//
//  Created by 王振宇 on 14/12/2.
//  Copyright (c) 2014年 王振宇. All rights reserved.
//

#import "configTableViewController.h"
#import "UMFeedback.h"
#import "JGProgressHUD.h"
#import "JGProgressHUDPieIndicatorView.h"
#import "JGProgressHUDRingIndicatorView.h"
#import "JGProgressHUDFadeZoomAnimation.h"

@interface configTableViewController ()
{
    JGProgressHUD *indicator;
}

@end

@implementation configTableViewController

@synthesize configUserNameLabel=_configUserNameLabel;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getUserName:) name:@"getUserName" object:nil];
    

    indicator = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleLight];
    indicator.userInteractionEnabled = YES;
    indicator.delegate = self;
    UIImageView *errorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jg_hud_success.png"]];
    indicator.textLabel.text = @"登录成功!";
    JGProgressHUDIndicatorView *ind = [[JGProgressHUDIndicatorView alloc] initWithContentView:errorImageView];
    indicator.progressIndicatorView = ind;
    indicator.square = YES;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (IBAction)userSayBackAction:(id)sender {
    
//    [self.navigationController pushViewController:[UMFeedback feedbackViewController]
//                                          animated:YES];
    [self presentModalViewController:[UMFeedback feedbackModalViewController]
                            animated:YES];
}

-(void)getUserName:(NSNotification *)notification
{
    NSDictionary *theData=[notification userInfo];

    NSString *userName=[theData objectForKey:@"userName"];
    
    _configUserNameLabel.text=userName;
    
    [indicator showInView:self.navigationController.view];
    [indicator dismissAfterDelay:1.0];
}
@end
