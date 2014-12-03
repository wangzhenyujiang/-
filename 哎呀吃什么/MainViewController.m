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
#import "ShowFoodViewController.h"
#import "DXAlertView.h"
//#import "EAIntroView.h"

@interface MainViewController ()
{
    int foodPosition;
}

@end

@implementation MainViewController

@synthesize collectionView=_collectionView;
@synthesize foodInfoList=_foodInfoList;
@synthesize selectFoodIndex=_selectFoodIndex;
- (void)viewDidLoad {
   // self.dataSource = self;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self showIntroWithCrossDissolve];
    foodPosition=-1;
    
    
    
    // _foodInfoList=[[NSMutableArray alloc]init];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addFoodCompletion:) name:@"addFoodCompletionNotification" object:nil];
    
    UILongPressGestureRecognizer *lpgr= [[UILongPressGestureRecognizer alloc]
                                         initWithTarget:self action:@selector(handleLongPress:)];
    
    lpgr.minimumPressDuration = .5; //seconds
    
    lpgr.delegate = self;
    
    [self.collectionView addGestureRecognizer:lpgr];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePath]])          //如果该文件存在
    {
        NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:[self dataFilePath]];
        
        _foodInfoList=array;
        
    }else
    {
        _foodInfoList=[[NSMutableArray alloc]init];
    }

    
    [self.collectionView reloadData];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqual:@"showDetail"]) {
        ShowFoodViewController *showController=segue.destinationViewController;
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
        _selectFoodIndex=indexPath.row;
        
        showController.foodIndex=_selectFoodIndex;
        
        
        showController.showFoodInfoList=_foodInfoList;
        
    }
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return [self.foodInfoList count]+1;
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AddCollectionViewCell *addFoodCell=[self.collectionView dequeueReusableCellWithReuseIdentifier:@"addFoodCell" forIndexPath:indexPath];
    
    InfoCollectionViewCell *infoCell=[self.collectionView dequeueReusableCellWithReuseIdentifier:@"foodInfoCell" forIndexPath:indexPath];
    
    if([_foodInfoList count]!=0)
    {
        
        BOOL b_addCell=(indexPath.row ==[_foodInfoList count]);
        
        if(!b_addCell)
        {
            NSDictionary *foodInfo=[_foodInfoList objectAtIndex:[indexPath row]];
            
            
            infoCell.infoFoodImageView.layer.cornerRadius=30.0f;
            infoCell.infoFoodImageView.clipsToBounds=YES; //设置imageView的layer的cornerRadius属性，呈现出圆形
            
            infoCell.infoFoodImageView.image=[[UIImage alloc]initWithData:[foodInfo objectForKey:@"imageData"]];
            
            infoCell.infoFoodNameLabel.text=[[NSString alloc]initWithString:[foodInfo objectForKey:@"foodName"]];
            
            return infoCell;
        }
        else
        {
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"add" ofType:@"png"];
            addFoodCell.addFoodNameLabel.image=[[UIImage alloc]initWithContentsOfFile:filePath];
        }
        
    }
    
    return addFoodCell;
    
}

/*
 通知中心调用方法，将传回来的数据放在foodInfoList中，并且实现collectionView的reloadData.
 */

-(void)addFoodCompletion:(NSNotification *)notification
{
    NSDictionary *theData=[notification userInfo];
    
    [_foodInfoList addObject:theData];
    
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    [userDefault setObject:_foodInfoList forKey:@"allInfo"];
    
    [_foodInfoList writeToFile:[self dataFilePath] atomically:YES];
    
    [self.collectionView reloadData];
    
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

#pragma marks -- UIGestureRecognizerDelegate --
/*
 长按处理的实现方法
 */

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    
    CGPoint p = [gestureRecognizer locationInView:self.collectionView];
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:p];
    
    if (indexPath == nil){
        NSLog(@"couldn't find index path");
    } else {
        
        foodPosition=indexPath.row;
        
        if(foodPosition != -1)
        {
            
            NSLog(@"%d",foodPosition) ;
            
            if(foodPosition!=[_foodInfoList count])
            {
//                UIAlertView *alterView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定要删除这个美食么" delegate:self cancelButtonTitle:@"饶它一命" otherButtonTitles:@"拖下斩了", nil];
//                
//                [alterView show];
                
                DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"Congratulations" contentText:@"您确定要删除这个美食么" leftButtonTitle:@"饶它一命" rightButtonTitle:@"拖下斩了"];
                [alert show];
                alert.leftBlock = ^() {
                    NSLog(@"left button clicked");
                };
                alert.rightBlock = ^() {
                    NSLog(@"right button clicked");
                     [self deleteFood:foodPosition];
                };
                alert.dismissBlock = ^() {
                    NSLog(@"Do something interesting after dismiss block");
                };
                
            }else
            {
                NSLog(@"皇上，您点击的是添加按钮");
            }
            
        }
        
    }
}


//#pragma marks -- UIAlertViewDelegate --
////根据被点击按钮的索引处理点击事件
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if(buttonIndex == alertView.firstOtherButtonIndex)
//    {
//       
//        NSLog(@"斩了");
//        
//    }
//    
//}
/*
 删除美食的方法
 */
-(void)deleteFood:(int)foodPosition
{
    
    [_foodInfoList removeObjectAtIndex:foodPosition];
    
    [_foodInfoList writeToFile:[self dataFilePath] atomically:YES];
    
    [self.collectionView reloadData];
}



@end
