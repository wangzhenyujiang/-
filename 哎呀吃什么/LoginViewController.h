//
//  LoginViewController.h
//  哎呀吃什么
//
//  Created by 王振宇 on 14/12/2.
//  Copyright (c) 2014年 王振宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userNameField;


@property (weak, nonatomic) IBOutlet UITextField *userPasField;
- (IBAction)loginButtonAction:(id)sender;

@end
