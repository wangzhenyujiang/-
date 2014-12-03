
//
//  configTableViewController.m
//  哎呀吃什么
//
//  Created by 王振宇 on 14/12/2.
//  Copyright (c) 2014年 王振宇. All rights reserved.
//

#import "configTableViewController.h"
#import "UMFeedback.h"

@interface configTableViewController ()

@end

@implementation configTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
@end
