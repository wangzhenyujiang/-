//
//  AddFoodViewController.m
//  哎呀吃什么
//
//  Created by 王振宇 on 14/12/1.
//  Copyright (c) 2014年 王振宇. All rights reserved.
//

#import "AddFoodViewController.h"
#import "DXAlertView.h"

@interface AddFoodViewController ()
{
    UIActionSheet *MyActionsheet;
}

@end

@implementation AddFoodViewController

@synthesize addFoodNameLabel=_addFoodNameLabel;
@synthesize addFoodImageView=_addFoodImageView;
@synthesize oneFoodInfoDictionary=_oneFoodInfoDictionary;
@synthesize foodName=_foodName;
@synthesize data=_data;


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

- (IBAction)addFoodButtonAction:(id)sender {
    
    MyActionsheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"打开相机",@"打开相册", nil];
    
    [MyActionsheet showInView:self.view];
    
}

- (IBAction)cancelButtonAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButtonAction:(id)sender {
    
    self.foodName=[[NSString alloc]initWithString:self.addFoodNameLabel.text];
    
    if ([self.foodName length]==0) {
        
//        UIAlertView *alterView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"美食名不能为空" delegate:self cancelButtonTitle:@"朕知道了" otherButtonTitles:nil, nil];
//        
//        [alterView show];
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"美食名不能为空奥 >_<" leftButtonTitle:nil rightButtonTitle:@"朕知道了"];
        [alert show];
        alert.rightBlock = ^() {
            NSLog(@"right button clicked");
        };
        alert.dismissBlock = ^() {
            NSLog(@"Do something interesting after dismiss block");
        };

        
    }else
    {
        if (self.data==nil) {        //如果他没有添加照片，那么就初始化一个m默认图片的data。
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"pic_default" ofType:@"png"];
            self.data = [[NSData alloc] initWithContentsOfFile:filePath];
        }
        self.OneFoodInfoDictionary=[NSDictionary dictionaryWithObjectsAndKeys:self.data,@"imageData",self.foodName,@"foodName", nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addFoodCompletionNotification" object:nil userInfo:_oneFoodInfoDictionary];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }

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
        
        self.data=UIImageJPEGRepresentation(image, 0.5);
        
        _addFoodImageView.layer.cornerRadius=30.0f;
        _addFoodImageView.clipsToBounds=YES;
        
        _addFoodImageView.image=image;
        
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



@end
