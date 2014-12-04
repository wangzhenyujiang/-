//
//  LoginViewController.m
//  哎呀吃什么
//
//  Created by 王振宇 on 14/12/2.
//  Copyright (c) 2014年 王振宇. All rights reserved.
//

#import "LoginViewController.h"
#import "DXAlertView.h"
#import "JGProgressHUD.h"

@interface LoginViewController ()
{

    JGProgressHUD *indicator;          //用户等待指示器
}

@end

@implementation LoginViewController

@synthesize  userNameField=_userNameField;
@synthesize  userPasField=_userPasField;
@synthesize  m_data=_m_data;




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _userNameField.delegate=self;
    indicator = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];     //初始化指示器
    indicator.textLabel.text=@"登录中请稍等...";
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 登录按钮执行的方法。
 */
- (IBAction)loginButtonAction:(id)sender {
     NSLog(@"button执行");
    
    if([_userNameField.text length]!=0 && [_userPasField.text length]!=0)
    {
        [indicator showInView:self.view];   //添加活动指示器
        
        NSString * s_url = [[NSString alloc]initWithFormat:@"http://1.ingeatwhat.sinaapp.com/login.php?username=%@&password=%@",_userNameField.text,_userPasField.text];
        NSURL *url = [[NSURL alloc]initWithString:s_url];
      
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];           //创建请求对象
        NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];          //开始请求登录
        
        if (connection) {
            
             _m_data = [[NSMutableData alloc]init];//如果连接成功，初始化一个data用来存放返回的数据
            NSLog(@"connection创建成功过");
            
        }else
        {
            NSLog(@"connection创建失败");
        }
    }else
    {
        
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"用户名或者密码不能为空哦 >_<" leftButtonTitle:nil rightButtonTitle:@"朕知道了"];
        
        [alert show];
        
    }
    
   
}

/*返回configTableViewController界面*/

- (IBAction)loginBackBarButtonAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
 把view改成control后，调用touch方法隐藏键盘
 */

- (IBAction)hiddenKeyBoard:(id)sender {
    
    [_userNameField resignFirstResponder];
    [_userPasField resignFirstResponder];
}



#pragma NSURLConnectionDelegate

/*
  NSURLConnectionDelegate方法，数据接收过程中调用这个方法。
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.m_data appendData:data];
    NSLog(@"didReceiveData");
}
/*
 NSURLConnectionDelegate方法，当数据接收完毕后调用这个方法
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading");
    
    NSString *s_result = [[NSString alloc]initWithData:_m_data encoding:NSUTF8StringEncoding];
    
        if([s_result length]==0)
    {
        NSLog(@"没有数据");
    }else
    {
        NSLog(s_result);
    }
    
    if ([s_result rangeOfString:@"OK"].length>0)
    {

        
        NSDictionary *userInfoDictionary=[[NSDictionary alloc]initWithObjectsAndKeys:_userNameField.text,@"userName", nil];
        

         [[NSNotificationCenter defaultCenter] postNotificationName:@"getUserName" object:nil userInfo:userInfoDictionary];
        [indicator dismiss];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        
    }
    else
    {
        [indicator dismiss];
        
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"登陆失败" leftButtonTitle:nil rightButtonTitle:@"朕知道了"];
        
        [alert show];
        NSLog(@"login faile");
    }

}
/*
 NSURLConnectionDelegate的方法，当出现网络错误的时候就会调用次方法
 */

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [indicator dismiss];
    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"网络错误" leftButtonTitle:nil rightButtonTitle:@"朕马上解决"];
    
    [alert show];
    NSLog(@"数据接受失败，失败原因：%@",[error localizedDescription]);
}
/*
 判断用户输入的字数是否合法，textFieldDelegate的方法
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location>=10)
    {
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"没有这么长的昵称哦 >_<" leftButtonTitle:nil rightButtonTitle:@"朕知道了"];
        [alert show];
        return  NO;
    }
    else
    {
        return YES;
    }
}

@end
