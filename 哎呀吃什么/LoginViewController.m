//
//  LoginViewController.m
//  哎呀吃什么
//
//  Created by 王振宇 on 14/12/2.
//  Copyright (c) 2014年 王振宇. All rights reserved.
//

#import "LoginViewController.h"
#import "DXAlertView.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize  userNameField=_userNameField;
@synthesize  userPasField=_userPasField;
@synthesize  m_data=_m_data;




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

- (IBAction)loginButtonAction:(id)sender {
     NSLog(@"button执行");
    
    if([_userNameField.text length]!=0 && [_userPasField.text length]!=0)
    {
        NSString * s_url = [[NSString alloc]initWithFormat:@"http://cqcreer.jd-app.com/login.php?username=%@&password=%@",_userNameField.text,_userPasField.text];
        NSURL *url = [[NSURL alloc]initWithString:s_url];
        //创建请求对象
       
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
        
        
      //  [[NSURLConnection alloc]initWithRequest:request delegate:self];
        
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
        
//        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示"
//                                                      message:@"用户名或者密码不能为空" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
//        [alert show];
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"用户名或者密码不能为空哦 >_<" leftButtonTitle:nil rightButtonTitle:@"朕知道了"];
        
        [alert show];
        
    }
    
   
}

- (IBAction)loginBackBarButtonAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
    //处理接收到的数据
    //如果包含“ok”，则登录成功，反之则失败
    
    if([s_result length]==0)
    {
        NSLog(@"没有数据");
    }else
    {
        NSLog(s_result);
    }
    
    if ([s_result rangeOfString:@"OK"].length>0)
    {
//        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示"
//                                                      message:@"ç" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
//        [alert show];
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"登陆成功" leftButtonTitle:nil rightButtonTitle:@"朕很开心"];
        
        [alert show];

        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
//        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"登录失败" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
//        [alert show];
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"登陆失败" leftButtonTitle:nil rightButtonTitle:@"朕知道了"];
        
        [alert show];
        NSLog(@"login faile");
    }

}


-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"网络错误" leftButtonTitle:nil rightButtonTitle:@"朕马上解决"];
    
    [alert show];
    NSLog(@"数据接受失败，失败原因：%@",[error localizedDescription]);
}



@end
