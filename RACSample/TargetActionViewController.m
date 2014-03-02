//
//  TargetActionViewController.m
//  RACSample
//
//  Created by tak on 2014/03/01.
//  Copyright (c) 2014年 taktamur. All rights reserved.
//

#import "TargetActionViewController.h"

@interface TargetActionViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordVerificationField;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UILabel *passwordMessageLabel;

@end

@implementation TargetActionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // ルール1
    [self.usernameField addTarget:self
                           action:@selector(updateButtonEnable:)
                 forControlEvents:UIControlEventEditingChanged];
    [self.emailField addTarget:self
                        action:@selector(updateButtonEnable:)
              forControlEvents:UIControlEventEditingChanged];
    [self.passwordField addTarget:self
                           action:@selector(updateButtonEnable:)
                 forControlEvents:UIControlEventEditingChanged];
    [self.passwordVerificationField addTarget:self
                                       action:@selector(updateButtonEnable:)
                             forControlEvents:UIControlEventEditingChanged];

    // ルール2
    [self.passwordField addTarget:self
                           action:@selector(updatePasswordMessage:)
                 forControlEvents:UIControlEventEditingChanged];
    [self.passwordVerificationField addTarget:self
                                       action:@selector(updatePasswordMessage:)
                             forControlEvents:UIControlEventEditingChanged];
    
}



// ルール1 createボタンのenable条件
-(void)updateButtonEnable:(UITextField *)field
{
    NSLog( @"%@,%@,%@,%@",
          self.usernameField.text,
          self.emailField.text,
          self.passwordField.text,
          self.passwordVerificationField.text);
    
    self.createButton.enabled =
    [self.usernameField.text length] > 0 &&
    [self.emailField.text length] > 0 &&
    [self.passwordField.text length] >= 8 &&
    [self.passwordField.text isEqual:self.passwordVerificationField.text];

}


// ルール2 passwordの条件
-(void)updatePasswordMessage:(UITextField *)field
{
    NSString *message = @"";
    if( [self.passwordField.text length] < 8){
        message = @"need 8 char.";
    }
    if( ![self.passwordField.text isEqualToString:self.passwordVerificationField.text] ){
        message = @"need same password";
    }
    self.passwordMessageLabel.text = message;
}

@end
