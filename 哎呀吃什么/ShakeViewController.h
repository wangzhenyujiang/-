//
//  ShakeViewController.h
//  哎呀吃什么
//
//  Created by 王振宇 on 14/12/1.
//  Copyright (c) 2014年 王振宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShakeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *shakeFoodNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shakeFoodImageView;

@property(strong,nonatomic)NSMutableArray *shakeFoodInfoList;
@end
