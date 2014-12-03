//
//  ShakeViewController.m
//  哎呀吃什么
//
//  Created by 王振宇 on 14/12/1.
//  Copyright (c) 2014年 王振宇. All rights reserved.
//

#import "ShakeViewController.h"
#import "DXAlertView.h"

@interface ShakeViewController ()
{

    BOOL firstShake;
}

@end

@implementation ShakeViewController
@synthesize shakeFoodImageView=_shakeFoodImageView;
@synthesize shakeFoodNameLabel=_shakeFoodNameLabel;
@synthesize shakeFoodInfoList=_shakeFoodInfoList;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"viewDidLoad");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"shake" ofType:@"png"];
    _shakeFoodImageView.image=[[UIImage alloc]initWithContentsOfFile:filePath];
    
    _shakeFoodNameLabel.text=@"";
    
    firstShake=YES;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePath]]) {
        _shakeFoodInfoList = [[NSMutableArray alloc] initWithContentsOfFile:[self dataFilePath]];
    }
    else
    {
        _shakeFoodInfoList = [[NSMutableArray alloc]init];
    }
    
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

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (!firstShake) {
        
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"摇一摇" contentText:@"别摇了今天就吃它吧 >_<" leftButtonTitle:nil rightButtonTitle:@"就吃它了"];
        
        [alert show];
        
        return ;
    }
    
    if([_shakeFoodInfoList count]==0)          //如果用户菜的个数是0
    {
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"皇上，您先添加个菜吧 >_<" leftButtonTitle:nil rightButtonTitle:@"朕知道了"];
        
        [alert show];
        
    }else
    {
        if (motion == UIEventSubtypeMotionShake)
        {
            NSLog(@"摇啊摇");
            int ran = arc4random()%([_shakeFoodInfoList count]);
            NSString* recipeName = [[_shakeFoodInfoList objectAtIndex:ran]objectForKey:@"foodName"];
                        //展示出被选中的食物的图片和名字
            self.shakeFoodNameLabel.text = recipeName;
            NSData* data = [[_shakeFoodInfoList objectAtIndex:ran]objectForKey:@"imageData"];
            //设置圆角
            self.shakeFoodImageView.layer.cornerRadius = 29.0f;
            
            self.shakeFoodImageView.clipsToBounds=YES;
            //保证图片比例不变
            self.shakeFoodImageView.contentMode=UIViewContentModeScaleAspectFill;
            
            self.shakeFoodImageView.image = [[UIImage alloc]initWithData:data];
            
            firstShake=NO;
        }

        }
    }

@end
