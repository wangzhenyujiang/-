//
//  AddFoodViewController.h
//  哎呀吃什么
//
//  Created by 王振宇 on 14/12/1.
//  Copyright (c) 2014年 王振宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddFoodViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)NSDictionary *oneFoodInfoDictionary;
@property(nonatomic,copy)NSString *foodName;
@property(nonatomic,strong)NSData *data;

@property (weak, nonatomic) IBOutlet UITextField *addFoodNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *addFoodImageView;
- (IBAction)addFoodButtonAction:(id)sender;

- (IBAction)cancelButtonAction:(id)sender;

- (IBAction)saveButtonAction:(id)sender;


@end
