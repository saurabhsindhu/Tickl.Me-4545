//
//  PasswordRecovery_ViewController.h
//  Tickl.Me
//
//  Created by Mountain on 2/1/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswordRecovery_ViewController : UIViewController <UITextFieldDelegate , UIAlertViewDelegate>{
    
   IBOutlet UITextField *textField;
    NSMutableArray *statuses,*arrayToEvents;
    NSString *emailStr;
    
}

- (IBAction)clickDone:(id)sender;
- (IBAction)clickSend:(id)sender;

@end
