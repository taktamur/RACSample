//
//  DelegatetypeViewController.m
//  RACSample
//
//  Created by tak on 2014/03/01.
//  Copyright (c) 2014年 taktamur. All rights reserved.
//

#import "DelegatetypeViewController.h"

@interface DelegatetypeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordVerificationField;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (weak, nonatomic) IBOutlet UILabel *passwordMessageLabel;

@end

@implementation DelegatetypeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.usernameField.delegate=self;
    self.emailField.delegate=self;
    self.passwordField.delegate=self;
    self.passwordVerificationField.delegate=self;
}




#pragma mark - UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog( @"%@,%@,%@,%@",self.usernameField.text, self.emailField.text ,self.passwordField.text,self.passwordVerificationField.text);

    // ルール1 createボタンのenable条件
    self.createButton.enabled =
    [self.usernameField.text length] > 0 &&
    [self.emailField.text length] > 0 &&
    [self.passwordField.text length] > 0 &&
    [self.passwordField.text isEqual:self.passwordVerificationField.text];

    // ルール2 passwordの条件
    NSString *message = @"";
    if( ![self.passwordField.text isEqualToString:self.passwordVerificationField.text] ){
        message = @"need same password";
    }
    self.passwordMessageLabel.text = message;
}


@end
