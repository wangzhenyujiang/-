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

    JGProgressHUD *indicator;
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
    indicator = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    indicator.textLabel.text=@"登录中请稍等...";
    
   
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

- (IBAction)loginButtonAction:(id)sender {
     NSLog(@"button执行");
    
    if([_userNameField.text length]!=0 && [_userPasField.text length]!=0)
    {
        [indicator showInView:self.view];   //添加活动指示器
        
        NSString * s_url = [[NSString alloc]initWithFormat:@"http://1.ingeatwhat.sinaapp.com/login.php?username=%@&password=%@",_userNameField.text,_userPasField.text];
        NSURL *url = [[NSURL alloc]initWithString:s_url];
        //创建请求对象
       
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
        
                
        NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
        
        if (connection) {
             _m_data = [[NSMutableData alloc]init];
            NSLog(@"connection创建成功过");
        }else
        {
        
            NSLog(@"connection创建失败");
        }
        
        NSLog(@"执行");

    }else
    {
        
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"用户名或者密码不能为空哦 >_<" leftButtonTitle:nil rightButtonTitle:@"朕知道了"];
        
        [alert show];
        
    }
    
   
}

- (IBAction)loginBackBarButtonAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)hiddenKeyBoard:(id)sender {
    
    [_userNameField resignFirstResponder];
    [_userPasField resignFirstResponder];
}



#pragma NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.m_data appendData:data];
    NSLog(@"didReceiveData");
}
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

        [indicator dismiss];
        
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"登陆成功" leftButtonTitle:nil rightButtonTitle:@"朕很开心"];
        
        [alert show];

        
       // [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [indicator dismiss];
        
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"登陆失败" leftButtonTitle:nil rightButtonTitle:@"朕知道了"];
        
        [alert show];
        NSLog(@"login faile");
    }

}


-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [indicator dismiss];
    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"网络错误" leftButtonTitle:nil rightButtonTitle:@"朕马上解决"];
    
    [alert show];
    NSLog(@"数据接受失败，失败原因：%@",[error localizedDescription]);
}

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
