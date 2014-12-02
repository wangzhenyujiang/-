//
//  MainViewController.m
//  哎呀吃什么
//
//  Created by 王振宇 on 14/12/1.
//  Copyright (c) 2014年 王振宇. All rights reserved.
//

#import "MainViewController.h"
#import "InfoCollectionViewCell.h"
#import "AddCollectionViewCell.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize collectionView=_collectionView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return 4;
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AddCollectionViewCell *addFoodCell=[self.collectionView dequeueReusableCellWithReuseIdentifier:@"addFoodCell" forIndexPath:indexPath];
    
    InfoCollectionViewCell *infoCell=[self.collectionView dequeueReusableCellWithReuseIdentifier:@"foodInfoCell" forIndexPath:indexPath];
    
    return addFoodCell;
    
}


@end
