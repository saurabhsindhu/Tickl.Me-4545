//
//  MailLogIn_ViewController.h
//  Tickl.Me
//
//  Created by Mountain on 2/1/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MailLogIn_ViewController : UIViewController <UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UITextField *username_txtField;
@property (retain, nonatomic) IBOutlet UITextField *password_txtField;

- (IBAction)clickForgotPassword:(id)sender;
- (IBAction)clickCancel:(id)sender;
- (IBAction)clickLogin:(id)sender;
@end
