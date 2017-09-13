//
//  ViewController.m
//  SKRegistVerifyDemo
//
//  Created by AY on 2017/9/13.
//  Copyright © 2017年 AlexanderYeah. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextFieldDelegate>
/* 验证密码field */
@property (weak, nonatomic) IBOutlet UITextField *verfifyPwdField;
/* 验证密码按钮 */
@property (weak, nonatomic) IBOutlet UIButton *pwdBtn;
/* 电话号码 */
@property (weak, nonatomic) IBOutlet UITextField *telNumField;
/* 电话号码按钮 */
@property (weak, nonatomic) IBOutlet UIButton *telBtn;

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
	1 验证密码必须是6-20位的长度
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

/**
2 验证手机号码格式是否正确
*/
- (IBAction)telVerifyBtnClick:(id)sender {
	if (![self isMobileNumber:self.telNumField.text]) {
		// 不是手机号码
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"手机号码格式错误" message:@"手机号码格式错误" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	    [alert show];
	}else{
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"格式正确" message:@"手机号码格式正确" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	    [alert show];
	}

}



#pragma mark - textfield 代理方法 控制在11位内
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
		
	// range 就是用户改变的范围，当改变的范围为0的时候，就是用户在执行写入操作
 	if (range.length == 0) {
		// 写入操作
		if (textField == self.telNumField && self.telNumField.text.length >= 11) {
		// 当位数超过11位的时候,不能够再输入
			return NO;
		}else{
			return YES;
		}
		
	}
	return YES;
}

// 正则判断手机号码地址格式
- (BOOL)isMobileNumber:(NSString *)mobileNum {

//    电信号段:133/153/180/181/189/177
//    联通号段:130/131/132/155/156/185/186/145/176
//    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
//    虚拟运营商:170

	NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";

	NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];

	return [regextestmobile evaluateWithObject:mobileNum];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
