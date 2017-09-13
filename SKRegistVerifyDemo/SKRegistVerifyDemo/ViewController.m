//
//  ViewController.m
//  SKRegistVerifyDemo
//
//  Created by AY on 2017/9/13.
//  Copyright © 2017年 AlexanderYeah. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
/* 验证密码field */
@property (weak, nonatomic) IBOutlet UITextField *verfifyPwdField;
/* 验证密码按钮 */
@property (weak, nonatomic) IBOutlet UIButton *pwdBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)verifyPwdBtnClick:(id)sender {

	[self verifyPwd:self.verfifyPwdField.text];
}

/**
	验证密码必须是6-20位的长度
*/
- (BOOL)verifyPwd:(NSString *)str
{
	// 密码6-20位 必须是字母 数字 字符至少两种的组合
	NSString *passWordRegex = @"^(?=.*[a-zA-Z0-9].*)(?=.*[a-zA-Z\\W].*)(?=.*[0-9\\W].*).{6,20}$";
	// 筛选条件设置
	NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
	
	if([pred evaluateWithObject:str]){
		// 符合条件
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"格式正确" message:@"输入格式正确" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	    [alert show];
		return YES;
	}else{
		// 不符合条件
	    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"格式错误" message:@"密码6-20位 必须是字母 数字 字符至少两种的组合" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	    [alert show];
		return NO;
	}

}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
