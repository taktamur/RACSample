//
//  RACStyleViewController.m
//  RACSample
//
//  Created by tak on 2014/03/01.
//  Copyright (c) 2014年 taktamur. All rights reserved.
//

#import "RACStyleViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RACStyleViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordVerificationField;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UILabel *passwordMessageLabel;

@end

@implementation RACStyleViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // ルール1 createボタンのenable条件
    RACSignal *formValidSignal =
    [RACSignal combineLatest:@[ self.usernameField.rac_textSignal,
                                self.emailField.rac_textSignal,
                                self.passwordField.rac_textSignal,
                                self.passwordVerificationField.rac_textSignal]
                      reduce:^(NSString *username,
                               NSString *email,
                               NSString *password,
                               NSString *passwordVerification) {
                          NSLog( @"%@,%@,%@,%@",
                                username,
                                email,
                                password,
                                passwordVerification);
                          
                          return @([username length] > 0 &&
                          [email length] > 0 &&
                          [password length] >= 8 &&
                          [password isEqual:passwordVerification]);
                      }];
    
    RAC(self.createButton,enabled) = formValidSignal;
    
    // ルール2 passwordの条件
    RACSignal *passwordValidSignal =
    [RACSignal combineLatest:@[ self.passwordField.rac_textSignal,
                                self.passwordVerificationField.rac_textSignal]
                      reduce:^(NSString *password,
                               NSString *passwordVerification) {
                          NSString *message = @"";
                          if( [password length] < 8){
                              message = @"need 8 char.";
                          }
                          if( ![password isEqualToString:passwordVerification] ){
                              message = @"need same password";
                          }
                          return message;
                      }];
    RAC(self.passwordMessageLabel,text) = passwordValidSignal;
}

@end
