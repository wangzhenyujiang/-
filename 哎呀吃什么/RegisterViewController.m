//
//  RegisterViewController.m
//  哎呀吃什么
//
//  Created by 王振宇 on 14/12/1.
//  Copyright (c) 2014年 王振宇. All rights reserved.
//

#import "RegisterViewController.h"
#import "DXAlertView.h"
#import "JGProgressHUD.h"

@interface RegisterViewController ()
{

    JGProgressHUD *indicator; //等待指示器
}

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
    _userNameField.delegate=self;          //设置代理，为了检测用户输入字数时候合法
    _userPasfield.delegate=self;
    _rePasField.delegate=self;
    
    indicator = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
    indicator.textLabel.text=@"注册中请稍等...";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    
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
    
    
    self.userName = self.userNameField.text;
    self.userPas=self.userPasfield.text;
    self.rePas=self.rePasField.text;
    
    if([self.userName length]!=0&&[self.userPas length]!=0&&[self.rePas length]!=0)
    {
        if ([self.userPas compare:self.rePas] == NSOrderedSame)//判断两次密码时候一致
        {
           
            [indicator showInView:self.view];
            
            NSString * s_url = [[NSString alloc]initWithFormat:@"http://1.ingeatwhat.sinaapp.com/register.php?username=%@&password=%@&password2=%@",self.userName,self.userPas,self.userPas];
            NSURL *url = [[NSURL alloc]initWithString:s_url];
            
            NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
            
            NSURLConnection *connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
            
            if (connection) {
                self.data = [[NSMutableData alloc]init];
                NSLog(@"connection创建成功过");
            }else
            {
                
                NSLog(@"connection创建失败");
            }

        }else
        {
        //两次密码不一致
            DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"两次密码不一致哦 >_<" leftButtonTitle:nil rightButtonTitle:@"朕知道了"];
            
            [alert show];

        }
    
    }else
    {
    
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"您给点信息吧 >_<" leftButtonTitle:nil rightButtonTitle:@"马上写"];
        
        [alert show];
    }
    
}

/*
 隐藏键盘的方法
 */

- (IBAction)reallyHiddenKey:(id)sender {
    
    [_userNameField resignFirstResponder];
    [_userPasfield resignFirstResponder];
    [_rePasField resignFirstResponder];
}

- (IBAction)cancelButtonAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil ];
    
}

- (IBAction)hiddenKeyBoard:(id)sender {
    
    [_userNameField resignFirstResponder];
    [_userPasfield resignFirstResponder];
    [_rePasField resignFirstResponder];
    
}
#pragma NSURLConnectionDelegate
/*
 实现NSURLConnectiondelegate方法。
 */
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
    
    if ([s_result rangeOfString:@"OK"].length>0)  //如果包含“ok”，则登录成功，反之则失败
    {

        [indicator dismiss];
        
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"注册成功" leftButtonTitle:nil rightButtonTitle:@"朕知道了"];
        
       
        alert.rightBlock = ^() {
            NSLog(@"right button clicked");
            [self dismissViewControllerAnimated:YES completion:nil];
        };
        alert.dismissBlock = ^() {
            NSLog(@"Do something interesting after dismiss block");
            [self dismissViewControllerAnimated:YES completion:nil];
        };
        
        [alert show];
        
    }
    else
    {
        [indicator dismiss];          //活动指示器消失
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"注册失败" leftButtonTitle:nil rightButtonTitle:@"再注册一次"];
        
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

/*
 检测用户输入的字数是否合法，这是UITextFieldDelegate的方法
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (range.location>=10)
    {
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"提示" contentText:@"名字密码太长不好记哦 >_<" leftButtonTitle:nil rightButtonTitle:@"朕知道了"];
        [alert show];
        return  NO;
    }
    else
    {
        return YES;
    }
}



@end
