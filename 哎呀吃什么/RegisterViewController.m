//
//  RegisterViewController.m
//  哎呀吃什么
//
//  Created by 王振宇 on 14/12/1.
//  Copyright (c) 2014年 王振宇. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

@synthesize userNameField=_userNameField;
@synthesize userPasfield=_userPasfield;
@synthesize rePasField=_rePasField;
@synthesize userName=_userName;
@synthesize userPas=_userPas;
@synthesize rePas=_rePas;
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

- (IBAction)rigisterButtonAction:(id)sender {
  //  http://cqcreer.jd-app.com/register.php?username=wwww&password=wwww
    self.userName = self.userNameField.text;
    self.userPas=self.userPasfield.text;
    self.rePas=self.rePasField.text;
    
    if([self.userName length]!=0&&[self.userPas length]!=0&&[self.rePas length]!=0)
    {
        if ([self.userPas compare:self.rePas] == NSOrderedSame)
        {
            NSString * s_url = [[NSString alloc]initWithFormat:@"http://cqcreer.jd-app.com/register.php?username=%@&password=%@",self.userName,self.userPas];
            NSURL *url = [[NSURL alloc]initWithString:s_url];
            //创建请求对象
            
            NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
            
            
            //  [[NSURLConnection alloc]initWithRequest:request delegate:self];
            
            NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
            
            if (connection) {
                self.data = [[NSMutableData alloc]init];
                NSLog(@"connection创建成功过");
            }else
            {
                
                NSLog(@"connection创建失败");
            }
            
            NSLog(@"执行");
            

        }else
        {
        //两次密码不一致
            UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示"
                                                          message:@"两次密码不一致" delegate:self cancelButtonTitle:@"朕知道了" otherButtonTitles: nil];
            [alert show];
        }
    
    }else
    {
        //用户信息不全
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示"
                                                      message:@"用户信息不全" delegate:self cancelButtonTitle:@"朕知道了" otherButtonTitles: nil];
        [alert show];
    }
    
}

- (IBAction)cancelButtonAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil ];
    
}
#pragma NSURLConnectionDelegate
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.data appendData:data];
    NSLog(@"didReceiveData");
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading");
    
    NSString *s_result = [[NSString alloc]initWithData:_data encoding:NSUTF8StringEncoding];
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
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示"
                                                      message:@"注册成功" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:@"注册失败" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
        NSLog(@"login faile");
    }
    
}


-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"提示" message:[error localizedDescription] delegate:self cancelButtonTitle:@"朕知道了" otherButtonTitles: nil];
    [alert show];
    NSLog(@"数据接受失败，失败原因：%@",[error localizedDescription]);
}




@end
