//
//  RACStyleViewController.m
//  RACSample
//
//  Created by tak on 2014/03/01.
//  Copyright (c) 2014年 taktamur. All rights reserved.
//

#import "RACStyleViewController2.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RACStyleViewController2 ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordVerificationField;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UILabel *passwordMessageLabel;

@end

@implementation RACStyleViewController2


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    RACSignal *samePasswordSignal =
    [RACSignal combineLatest:@[self.passwordField.rac_textSignal,
                               self.passwordVerificationField.rac_textSignal]
                      reduce:^(NSString *password,
                               NSString *passwordVerification){
                          return @([password isEqualToString:passwordVerification]);
                      }];
     
    RACSignal *passwordLengthSignal =
    [RACSignal combineLatest:@[self.passwordField.rac_textSignal]
                      reduce:^(NSString *password){
                          return @([password length]>=8);
                      }];
    
    // ルール1 createボタンのenable条件
    RACSignal *formValidSignal =
    [RACSignal combineLatest: @[self.usernameField.rac_textSignal,
                                self.emailField.rac_textSignal,
                                samePasswordSignal,
                                passwordLengthSignal]
                      reduce:^(NSString *username,
                               NSString *email,
                               NSNumber *passwordsame,
                               NSNumber *passwordLength) {
                          NSLog( @"%@,%@,%@,%@",
                                username,
                                email,
                                passwordsame,
                                passwordLength);
                          return @([username length] > 0 &&
                          [email length] > 0 &&
                          [passwordsame boolValue] &&
                          [passwordLength boolValue]);
                      }];
    
    RAC(self.createButton,enabled) = formValidSignal;
    
    // ルール2 passwordの条件
    RACSignal *passwordValidSignal =
    [RACSignal combineLatest:@[samePasswordSignal,
                               passwordLengthSignal]
                      reduce:^(NSNumber *same,
                               NSNumber *length){
                          NSString *message = @"";
                          if( ![length boolValue]){
                              message = @"need 8 char.";
                          }
                          if( ![same boolValue] ){
                              message = @"need same password";
                          }
                          return message;
                      }];
    RAC(self.passwordMessageLabel,text) = passwordValidSignal;
}

@end
