//
//  MainViewController.h
//  哎呀吃什么
//
//  Created by 王振宇 on 14/12/1.
//  Copyright (c) 2014年 王振宇. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MainViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(strong,nonatomic)NSMutableArray * foodInfoList;
@property(nonatomic)int selectFoodIndex;

@end
