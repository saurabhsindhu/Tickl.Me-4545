//
//  CreateAccount_ViewController.m
//  Tickl.Me
//
//  Created by Mountain on 2/1/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "CreateAccount_ViewController.h"
#import "Filters_ViewController.h"
#import "JSON.h"
@interface CreateAccount_ViewController ()
{

}
@end

@implementation CreateAccount_ViewController
@synthesize txtCPassword,txtEmail,txtDOB,txtFname,txtLname,txtPassword,txtUname,responseData;
@synthesize lblCPasswordRequired,lblDOBRequired,lblEmailRequired,lblFnameRequired,lblLnameRequired,lblPasswordRequired,lblConfirmPswd,lblUnameRequired;

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
    // Do any additional setup after loading the view from its nib.
    self.title=@"Registration";

        [[self navigationController] setNavigationBarHidden:NO animated:YES];
        lblFnameRequired.hidden = YES;
        lblLnameRequired.hidden = YES;
        lblEmailRequired.hidden = YES;
        lblDOBRequired.hidden = YES;
        lblPasswordRequired.hidden = YES;
        lblCPasswordRequired.hidden = YES;
        lblConfirmPswd.hidden = YES;
        lblUnameRequired.hidden = YES;
        isChecked = NO;
        
        BOOL isPortrait = UIDeviceOrientationIsPortrait(self.interfaceOrientation);
        if (isPortrait)
        {
            if ([[UIScreen mainScreen] bounds].size.height == 568)
            {
                //this is iphone 5 xib
            }
            else
            {
                
            }
        }
        else
        {
            subView.frame=CGRectMake(0,50,480,170);
            toolbar.frame=CGRectMake(0, 40, 480, 40);
            scroll.contentSize = CGSizeMake(200, 500);
            //scroll.frame=CGRectMake(0, 40, 480, 256);
            datePicker.frame = CGRectMake(0 , 40 , 480 , 216 );
        }
    }
    -(void)viewDidAppear:(BOOL)animated
    {
        
    }
    
    - (void)didReceiveMemoryWarning
    {
        [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
    }
#pragma mark - text field delegates
    
    - (void)textFieldDidBeginEditing:(UITextField *)textField
    {
        pickerSelected=NO;
        if(isPickerLaunced)
        {
            [self datePickerCancelPressed];
        }
        
        if([textField isEqual:txtLname])
        {
            [UIScrollView beginAnimations:nil context:NULL];
            [UIScrollView setAnimationDuration:0.50];
            scroll.frame = CGRectMake(0,-50,self.view.frame.size.width,self.view.frame.size.height);
            [UIScrollView commitAnimations];
        }
//        else if([textField isEqual:txtUname])
//        {
//            [UIView beginAnimations:nil context:NULL];
//            [UIView setAnimationDuration:0.50];
//            scroll.frame = CGRectMake(0,-100,self.view.frame.size.width,self.view.frame.size.height);
//            [UIView commitAnimations];
//        }
        
        if([textField isEqual:txtEmail])
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.50];
            scroll.frame = CGRectMake(0,-100,self.view.frame.size.width,self.view.frame.size.height);//-150
            [UIView commitAnimations];
            // [self Birthday:self];
        }
        else if([textField isEqual:txtPassword])
        {
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.50];
            BOOL isPortrait = UIDeviceOrientationIsPortrait(self.interfaceOrientation);
            if (isPortrait)
            {
                scroll.frame = CGRectMake(0,-170,self.view.frame.size.width,self.view.frame.size.height);
            }
            else
            {
                scroll.frame = CGRectMake(0,-130,self.view.frame.size.width,self.view.frame.size.height);
                
            }
            [UIView commitAnimations];
        }
        else if([textField isEqual:txtCPassword])
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.50];
            BOOL isPortrait = UIDeviceOrientationIsPortrait(self.interfaceOrientation);
            if (isPortrait)
            {
                scroll.frame = CGRectMake(0,-200,self.view.frame.size.width,self.view.frame.size.height);
            }
            else
            {
                scroll.frame = CGRectMake(0,-150,self.view.frame.size.width,self.view.frame.size.height);
            }
            [UIView commitAnimations];
        }
    }
    
    - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
    {
        NSString *resultingString = [textField.text stringByReplacingCharactersInRange: range withString: string];
        NSCharacterSet *whitespaceSet = [NSCharacterSet whitespaceCharacterSet];
        if  ([resultingString rangeOfCharacterFromSet:whitespaceSet].location == NSNotFound)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    - (void)textFieldDidEndEditing:(UITextField *)textField
    {
        if(textField.tag == 101)
        {
            if ([txtFname.text length] <=0)
            {
                lblFnameRequired.hidden=NO;
                flag = FALSE;
            }else{
                lblFnameRequired.hidden=YES;
                
            }
        }
        else if(textField.tag == 102)
        {
            if ([txtLname.text length] <=0)
            {
                lblLnameRequired.hidden=NO;
                flag = FALSE;
            }
            else
            {
                lblLnameRequired.hidden=YES;
            }
        }
        else if(textField.tag == 107)
        {
            if ([txtUname.text length] <=0)
            {
                lblUnameRequired.hidden=NO;
                flag = FALSE;
                
            }else{
                lblUnameRequired.hidden=YES;
            }
        }
        
        else if(textField.tag == 103)
        {
            if ([txtEmail.text length] <=0)
            {
                lblEmailRequired.hidden=NO;
                flag = FALSE;
                
            }else{
                lblEmailRequired.hidden=YES;
                [self validateEmail:txtEmail.text];
            }
        }
        
        else if(textField.tag == 104)
        {
            if ([txtDOB.text length] <=0)
            {
                lblDOBRequired.hidden=NO;
                flag = FALSE;
                
            }else{
                lblDOBRequired.hidden=YES;
            }
        }
        else if(textField.tag == 105)
        {
            if ([txtPassword.text length] <=0)
            {
                lblPasswordRequired.hidden=NO;
                flag = FALSE;
                
            }else{
                lblPasswordRequired.hidden=YES;
            }
        }
        else if(textField.tag == 106)
        {
            if ([txtCPassword.text length] <=0)
            {
                lblCPasswordRequired.hidden=NO;
                flag = FALSE;
                
            }else
            {
                lblCPasswordRequired.hidden=YES;
                if (![txtPassword.text isEqualToString:txtCPassword.text])
                {
                    lblConfirmPswd.hidden=NO;
                    txtCPassword.text=@"";
                    flag = FALSE;
                }
                else
                {
                    lblConfirmPswd.hidden=YES;
                }
            }
        }
    }
    
    - (BOOL)textFieldShouldReturn:(UITextField *)textField
    {
        [textField resignFirstResponder];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        scroll.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
        [UIView commitAnimations];
        
        return YES;
    }
    
    -(BOOL)shouldAutorotate
    {
        return YES;
    }
    
    - (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
    {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
            {
                //scroll.contentSize = CGSizeMake(200,500);
                if (isPickerLaunced) {
                    subView.frame=CGRectMake(0,50,480,170);
                    toolbar.frame=CGRectMake(0, 40, 480, 40);
                    scroll.contentSize = CGSizeMake(200, 500);
                    //scroll.frame=CGRectMake(0, 0, 480, 256);
                    datePicker.frame = CGRectMake(0 , 40 , 480 , 216 );
                }
                scroll.contentSize = CGSizeMake(200, 500);
                // scroll.frame=CGRectMake(0, 40, 310, 550);
            }
            else if(toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
            {
                //scroll.contentSize = CGSizeMake(300, 100);
                // scroll.frame=CGRectMake(0, 40, 320,460 );
                //            datePicker.frame = CGRectMake(0 , 40 , 320 , 250 );
                //            subView.frame = CGRectMake(0,80,320,250);
                //            toolbar.frame = CGRectMake(0, 0, 320, 40);
                if (isPickerLaunced)
                {
                    [self datePickerCancelPressed];
                }
                else
                {
                    
                }
            }
        }
    }
#pragma mark -
#pragma mark Validation Function
    
    -(BOOL) validateEmail: (NSString *) email
    {
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        BOOL isValid = [emailTest evaluateWithObject:email];
        
        if ([emailTest evaluateWithObject:txtEmail.text] == YES)
        {
            lblEmailRequired.hidden = YES;
            
        }
        else
        {
            lblEmailRequired.hidden = NO;
            flag = FALSE;
            txtEmail.text = @"";
        }
        return isValid;
    }
    -(IBAction)Birthday:(id)sender
    {
        
        [txtDOB resignFirstResponder];
        [txtEmail resignFirstResponder];
        [txtFname resignFirstResponder];
        [txtLname resignFirstResponder];
        [txtPassword resignFirstResponder];
        [txtCPassword resignFirstResponder];
        
        // [scroll setContentOffset:CGPointMake(0,150) animated:YES];
        if(isPickerLaunced)
        {
            [self datePickerCancelPressed];
        }
        else
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.50];
            BOOL isPortrait = UIDeviceOrientationIsPortrait(self.interfaceOrientation);
            if (isPortrait)
            {
                scroll.frame = CGRectMake(0,-170,self.view.frame.size.width,self.view.frame.size.height);
            }
            else
            {
                scroll.frame = CGRectMake(0,-170,self.view.frame.size.width,self.view.frame.size.height);
                
            }
            
            [UIView commitAnimations];
            
            CGRect pickerFrame;
            if ([[UIScreen mainScreen] bounds].size.height == 568)
            {
                //this is iphone 5 xib
                pickerFrame = CGRectMake(0 , 84 , 320 , 250 );
            }
            else
            {
                pickerFrame = CGRectMake(0 , 40 , 320 , 250 );
            }
            
            datePicker = [[UIDatePicker alloc] initWithFrame:pickerFrame];
            datePicker.datePickerMode=UIDatePickerModeDate;
            
            CGRect frame;
            if ([[UIScreen mainScreen] bounds].size.height == 568)
            {
                //this is iphone 5 xib
                frame = CGRectMake(0,80,320,350);
                
            }
            else
            {
                frame = CGRectMake(0,80,320,250);
                
            }
            
            
            subView = [[UIView alloc] initWithFrame:frame];
            [subView addSubview:datePicker] ;
            subView.backgroundColor=[UIColor redColor];
            subView.hidden = NO;
            subView.backgroundColor = [UIColor clearColor];
            if ([[UIScreen mainScreen] bounds].size.height == 568)
            {
                //this is iphone 5 xib
                toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 50, 320, 40)];
            }
            else
            {
                toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
                
            }
            
            toolbar.tintColor=[UIColor blackColor];
            
            UIBarButtonItem *toolbarItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(datePickerCancelPressed)];
            UIBarButtonItem *toolbarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(datePickerDonePressed)];
            
            
            UIBarButtonItem *flexibleWidth = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] ;
            toolbar.items = [[NSArray alloc] initWithObjects:toolbarItem1,flexibleWidth , toolbarItem, nil];
            
            [subView addSubview:toolbar];
            
            subView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0 , 482 );
            [UIView beginAnimations:@"start" context:nil];
            [UIView setAnimationDuration:0.6];
            [UIView setAnimationDidStopSelector:@selector(animationFinished)];
            [UIView setAnimationDelegate:self];
            subView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0 , 125 );
            [UIView commitAnimations];
            [self.view addSubview:subView];
            
            isPickerLaunced=YES;
            pickerSelected=YES;
            
            //BOOL isPortrait = UIDeviceOrientationIsPortrait(self.interfaceOrientation);
            if (isPortrait)
            {
                scroll.frame = CGRectMake(0,-170,self.view.frame.size.width,self.view.frame.size.height);
            }
            else
            {
                subView.frame=CGRectMake(0,50,480,170);
                toolbar.frame=CGRectMake(0, 40, 480, 40);
                datePicker.frame = CGRectMake(0 , 40 , 480 , 216 );
            }
        }
    }
    -(void)datePickerCancelPressed
    {
        if ([txtDOB.text length] <=0)
        {
            lblDOBRequired.hidden=NO;
            flag = FALSE;
        }else{
            lblDOBRequired.hidden=YES;
        }
        
        subView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0 , 125 );
        [UIView beginAnimations:@"start" context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDidStopSelector:@selector(animationFinished)];
        [UIView setAnimationDelegate:self];
        subView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0 , 482 );
        [UIView commitAnimations];
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        scroll.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
        [UIView commitAnimations];
        
        isPickerLaunced=NO;
        pickerLaunced=NO;
        
    }
    -(void)datePickerDonePressed
    {
        if(isPickerLaunced)
        {
            NSDate *selectedDate = datePicker.date;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MMMM dd, YYYY"];
            NSString *eventDate=[dateFormatter stringFromDate:selectedDate];
            txtDOB.text = eventDate;
            if ([txtDOB.text length] <=0)
            {
                lblDOBRequired.hidden=NO;
                flag = FALSE;
            }else
            {
                lblDOBRequired.hidden=YES;
            }
            [UIView beginAnimations:@"start" context:nil];
            [UIView setAnimationDuration:0.6];
            [UIView setAnimationDidStopSelector:@selector(animationFinished)];
            [UIView setAnimationDelegate:self];
            subView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0 , 482 );
            [UIView commitAnimations];
            [scroll setContentOffset:CGPointMake(0,0) animated:YES];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            scroll.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
            [UIView commitAnimations];
            isPickerLaunced=NO;
        }
        else {
            if ([txtDOB.text length] <=0)
            {
                lblDOBRequired.hidden=NO;
                flag = FALSE;
                
            }else{
                lblDOBRequired.hidden=YES;
            }
            
            NSDate *selectedDate = datePicker.date;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"mm'/'dd'/'yyyy"];
            NSString *eventDate=[dateFormatter stringFromDate:selectedDate];
            txtDOB.text = eventDate;
            
            [UIView beginAnimations:@"start" context:nil];
            [UIView setAnimationDuration:0.6];
            [UIView setAnimationDidStopSelector:@selector(animationFinished)];
            [UIView setAnimationDelegate:self];
            subView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0 , 482 );
            [UIView commitAnimations];
            [scroll setContentOffset:CGPointMake(0,0) animated:YES];
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            scroll.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
            [UIView commitAnimations];
            
        }
    }
    - (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
    {
        return 1;
    }
    
    
    - (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
    {
        return 1;
    }
    
    -(IBAction) isAgreeClicked:(id)sender
    {
        if ([txtDOB.text length]<=0)
        {
            UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Firstly, fill your Date of Birth." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert1 show];
        }
        else
        {
            if(rememberMeBtn.imageView.image == [UIImage imageNamed:@"Check_red.png"])
            {
                isChecked=NO;
                UIImage * btnImage1 = [UIImage imageNamed:@"whiteCircle.png"];
                [rememberMeBtn setImage:btnImage1 forState:UIControlStateNormal];
                
            }
            else
            {
                NSDate *now = [[NSDate alloc] init];
                NSDate *endDate = datePicker.date;
                NSTimeInterval timeDifference = [endDate timeIntervalSinceDate:now];
                
                NSDate *Date=[NSDate dateWithTimeIntervalSinceReferenceDate:timeDifference];
                NSLog(@"time difference:%@",Date);
                // The time interval
                
                
                // Get the system calendar
                NSCalendar *sysCalendar = [NSCalendar currentCalendar];
                
                // Get conversion to months, days, hours, minutes
                unsigned int unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
                
                NSDateComponents *conversionInfo = [sysCalendar components:unitFlags fromDate:endDate
                                                                    toDate:now  options:0];
                
                NSLog(@"Conversion: %dmin %dhours %ddays %dmoths %dyears",[conversionInfo minute], [conversionInfo hour], [conversionInfo day], [conversionInfo month], [conversionInfo year]);
                NSInteger years=[conversionInfo year];
                NSLog(@"%d",years);
                if(years < 21)
                {
                    UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"Message" message:@"You must be 21 years of age or older to sign up for Stuff2du." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    alert1.tag=1;
                    [alert1 show];
                    txtDOB.text = @"";
                }
                else
                {
                    isChecked=YES;
                    UIImage * btnImage1 = [UIImage imageNamed:@"Check_red.png"];
                    [rememberMeBtn setImage:btnImage1 forState:UIControlStateNormal];
                }
            }
        }
    }


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	self.responseData = nil;
}


- (IBAction)clickCreateAccount:(id)sender
{
    if ([txtFname.text length]==0 || [txtLname.text length]==0  || [txtCPassword.text length]==0 || [txtPassword.text length]==0  || [txtEmail.text length]==0)
    {
        NSLog(@"Fail");
    }
    else
    {
        
        
//        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:kLatestKivaLoansURL]];
//        [[NSURLConnection alloc] initWithRequest:request delegate:self];
//        
        
        NSMutableString *requestString1 = [NSMutableString stringWithFormat:@"http://108.168.203.226:8123/users/getRegister"];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestString1]];
        [request setHTTPMethod:@"POST"];
        
        NSString* body = [NSString stringWithFormat:@"{\"User\":{\"first_name\":\"%@\",\"last_name\":\"%@\",\"email\":\"%@\",\"password\":\"%@\"}}",self.txtFname.text,self.txtLname.text,self.txtEmail.text,self.txtPassword.text];
        
        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
        
        [request setValue:@"application/json"
       forHTTPHeaderField:@"content-type"];
        NSURLResponse *response = nil;
        NSError *error = nil;
        
        NSData *responseData  = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        request = nil;
        
        NSString *responseString = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
        
        NSString *string = [responseString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        responseString = nil;
        
        string = [string stringByReplacingOccurrencesOfString:@"\"{" withString:@"{"];
        string = [string stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
        string = [string stringByReplacingOccurrencesOfString:@"\"[" withString:@"["];
        string = [string stringByReplacingOccurrencesOfString:@"]\"" withString:@"]"];
        
        NSDictionary *responseDict = (NSDictionary *)[string JSONValue];

        NSLog(@"%@",responseDict);
//        if (!isChecked)
//        {
//            
//        }
//        else
//        {
//            Filters_ViewController *filters = [[Filters_ViewController alloc] initWithNibName:@"Filters_ViewController" bundle:nil];
//            [self.navigationController pushViewController:filters animated:YES];
//        }
    }
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
