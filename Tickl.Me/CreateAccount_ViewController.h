//
//  CreateAccount_ViewController.h
//  Tickl.Me
//
//  Created by Mountain on 2/1/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateAccount_ViewController : UIViewController <UITextFieldDelegate>
{
    
    BOOL isChecked;
    BOOL flag;
    IBOutlet UIButton *rememberMeBtn;
    IBOutlet UIScrollView *scroll;
    BOOL pickerLaunced;
    BOOL isPickerLaunced;
    BOOL pickerSelected;
    UIPickerView *pickerView;
    UIDatePicker *datePicker;
    UIView *subView;
    UIToolbar *toolbar;
}

- (IBAction)backBtn:(id)sender;
@property(retain,nonatomic) IBOutlet UILabel *lblFnameRequired;
@property(retain,nonatomic) IBOutlet UILabel *lblLnameRequired;
@property(retain,nonatomic) IBOutlet UILabel *lblEmailRequired;
@property(retain,nonatomic) IBOutlet UILabel *lblPasswordRequired;
@property(retain,nonatomic) IBOutlet UILabel *lblCPasswordRequired;
@property(retain,nonatomic) IBOutlet UILabel *lblDOBRequired;
@property(retain,nonatomic) IBOutlet UILabel *lblConfirmPswd;
@property(retain,nonatomic) IBOutlet UILabel *lblUnameRequired;
@property(retain,nonatomic) IBOutlet UITextField *txtFname;
@property(retain,nonatomic) IBOutlet UITextField *txtLname;
@property(retain,nonatomic) IBOutlet UITextField *txtUname;
@property(retain,nonatomic) IBOutlet UITextField *txtEmail;
@property(retain,nonatomic) IBOutlet UITextField *txtPassword;
@property(retain,nonatomic) IBOutlet UITextField *txtCPassword;
@property(retain,nonatomic) IBOutlet UITextField *txtDOB;
 @property(retain,nonatomic)  NSMutableData *responseData;
- (IBAction)clickCreateAccount:(id)sender;

@end
