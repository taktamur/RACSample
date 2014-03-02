//
//  PAMViewController.m
//  RACSample
//
//  Created by tak on 2014/02/22.
//  Copyright (c) 2014年 taktamur. All rights reserved.
//

#import "PAMViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface LoginSignal:RACSignal
@end;
@implementation LoginSignal
@end

@interface PAMViewController ()
@property(nonatomic)NSString *username;
@property(nonatomic)BOOL createEnabled;
@property(nonatomic)NSString *password;
@property(nonatomic)NSString *passwordConfirmation;
@property (weak, nonatomic) IBOutlet UIButton *buttom;

@property(nonatomic)RACCommand *loginCommand;
@end

@implementation PAMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    self.loginCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        
        [NSThread sleepForTimeInterval:1.0];
        return [RACSignal empty];
    }];
    
    [self.loginCommand.executionSignals subscribeNext:^(RACSignal *loginSignal) {
        // Log a message whenever we log in successfully.
        [loginSignal subscribeCompleted:^ {
            NSLog(@"Logged in successfully!");
        }];
    }];
    self.buttom.rac_command = self.loginCommand;

//    [[RACObserve(self, username)
//      filter:^(NSString *newName) {
//          return [newName hasPrefix:@"j"];
//      }]
//      subscribeNext:^(NSString *newName) {
//        NSLog(@"%@", newName);
//    }];
//    
//    
//    RAC(self, createEnabled) = [RACSignal
//                                combineLatest:@[ RACObserve(self, password),
//                                                 RACObserve(self, passwordConfirmation) ]
//                                reduce:^(NSString *password, NSString *passwordConfirm) {
//                                    return @([passwordConfirm isEqualToString:password]);
//                                }];
//    
//    self.buttom.rac_command =  [[RACCommand alloc] initWithSignalBlock:^(id _) {
//        NSLog(@"button was pressed!");
//        return [RACSignal empty];
//    }];
}

-(void)viewDidAppear:(BOOL)animated
{
//    self.username = @"hogehoge";
//    self.username = @"jjj";
//    self.password=@"hogehoge";
//    self.passwordConfirmation=@"hog1ehoge";
//    NSLog( @"bool=%d",self.createEnabled);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
