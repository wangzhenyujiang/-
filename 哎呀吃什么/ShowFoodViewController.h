//
//  ShowFoodViewController.h
//  哎呀吃什么
//
//  Created by 王振宇 on 14/12/1.
//  Copyright (c) 2014年 王振宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowFoodViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *showFoodNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *showFoodImageView;

@property(strong,nonatomic)NSData *showData;
@property(strong,nonatomic)NSMutableArray *showFoodInfoList;
@property(nonatomic)int foodIndex;
@property(nonatomic,copy)NSString *showFoodName;
- (IBAction)changeFoodImageViewAction:(id)sender;

- (IBAction)hiddenKeyBoard:(id)sender;

@end
