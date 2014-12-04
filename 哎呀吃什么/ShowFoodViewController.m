//
//  ShowFoodViewController.m
//  哎呀吃什么
//
//  Created by 王振宇 on 14/12/1.
//  Copyright (c) 2014年 王振宇. All rights reserved.
//

#import "ShowFoodViewController.h"
#import "DXAlertView.h"

@interface ShowFoodViewController ()
{
    UIActionSheet *MyActionsheet;
    BOOL showDXAlertView;
}

@end

@implementation ShowFoodViewController

@synthesize showFoodImageView=_showFoodImageView;
@synthesize showFoodNameLabel=_showFoodNameLabel;
@synthesize showData=_showData;
@synthesize showFoodInfoList=_showFoodInfoList;
@synthesize foodIndex=_foodIndex;
@synthesize showFoodName=_showFoodName;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _showFoodNameLabel.delegate=self;
    
    NSString *name=[[_showFoodInfoList objectAtIndex:_foodIndex] objectForKey:@"foodName"];
    NSData *data=[[_showFoodInfoList objectAtIndex:_foodIndex] objectForKey:@"imageData"];
    _showData=data;
    _showFoodName=name;
    
    self.showFoodImageView.layer.cornerRadius=30.0f;
    self.showFoodImageView.clipsToBounds=YES;
    
    self.showFoodImageView.image=[[UIImage alloc] initWithData:data];
    self.showFoodNameLabel.text=name;
    
    showDXAlertView=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if([[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePath]])          //如果该文件存在
//    {
//        NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:[self dataFilePath]];
//        
//        _showFoodInfoList=array;
//        
//    }else
//    {
//        _showFoodInfoList=[[NSMutableArray alloc]init];
//    }

    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSString *name=_showFoodNameLabel.text;
    if([name length]==0)
    {
        name=_showFoodName;
    }
    
    NSDictionary *dictonary=[[NSDictionary alloc] initWithObjectsAndKeys:_showData, @"imageData",name,@"foodName", nil];
    [_showFoodInfoList replaceObjectAtIndex:_foodIndex withObject:dictonary];
    [_showFoodInfoList writeToFile:[self dataFilePath] atomically:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)changeFoodImageViewAction:(id)sender {
    
    MyActionsheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"打开相机",@"打开相册", nil];
    
    [MyActionsheet showInView:self.view];

}

- (IBAction)hiddenKeyBoard:(id)sender {
    [_showFoodNameLabel resignFirstResponder];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex == MyActionsheet.cancelButtonIndex)
    {
        NSLog(@"取消");
    }
    
    switch (buttonIndex) {
        case 0:
            //调用相机
            [self takePhoto];
            break;
        case 1:
            //调用相册
            [self localPhoto];
            break;
    }
}

/*
 打开照相机的方法
 */

-(void)takePhoto
{
    UIImagePickerControllerSourceType souceType=UIImagePickerControllerSourceTypeCamera;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker= [[UIImagePickerController alloc]init ];
        picker.delegate=self;
        //设置拍照后的图片可编辑
        picker.allowsEditing=YES;
        picker.sourceType=souceType;
        
        [self presentViewController:picker animated:YES completion:nil];
    }
}

/*
 打开本地相册的方法
 */

-(void)localPhoto
{
    UIImagePickerController *picker=[[UIImagePickerController alloc]init];
    
    picker.delegate=self;
    picker.allowsEditing=YES;
    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:nil];
}


/*
 图片选择完后调用didFinishPickingMediaWithInfo方法
 */

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type=[info objectForKey:UIImagePickerControllerMediaType];
    
    
    if([type isEqualToString:@"public.image"])
    {
        //先把图片转化成NSData
        UIImage *image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        _showData=UIImageJPEGRepresentation(image, 0.5);
        
        _showFoodImageView.layer.cornerRadius=30.0f;
        _showFoodImageView.clipsToBounds=YES;
        
        _showFoodImageView.image=image;
        
    }
}

/*
 这是在相册界面或者相机界面选择取消时调用的方法。
 */

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您选择了取消选择图片");
    [picker dismissViewControllerAnimated:YES  completion:nil];
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location>=8)
    {
        [_showFoodNameLabel resignFirstResponder];
       
        if (showDXAlertView) {
        
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"美食名字八个字以内哦 >_<" leftButtonTitle:nil rightButtonTitle:@"朕知道了"];
        
        alert.rightBlock = ^() {
            NSLog(@"right button clicked");
            showDXAlertView=YES;
        };
        alert.dismissBlock = ^() {
            NSLog(@"Do something interesting after dismiss block");
            showDXAlertView=YES;
        };
        
        showDXAlertView=NO;
        
        [alert show];
        
    }
        return  NO;
    }
    else
    {
        return YES;
    }
}


@end
