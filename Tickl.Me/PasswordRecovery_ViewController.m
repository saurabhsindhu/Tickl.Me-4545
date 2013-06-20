//
//  PasswordRecovery_ViewController.m
//  Tickl.Me
//
//  Created by Mountain on 2/1/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "PasswordRecovery_ViewController.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"

@interface PasswordRecovery_ViewController ()

@end

@implementation PasswordRecovery_ViewController

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
    self.title=@"Password Recovery";
}

- (IBAction)clickDone:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickSend:(id)sender
{
    
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://108.168.203.226:8123/users/forgotPwd"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    NSDictionary* postDict = [NSDictionary dictionaryWithObjectsAndKeys:textField.text,@"email_id",nil];
    NSString* jsonData = [postDict JSONRepresentation];
    NSData* postData = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
    [request appendPostData:postData];
    [request setDelegate:self];
    [request startAsynchronous];
    
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Help is on the way!" message:@"Password sent to Email" delegate:self cancelButtonTitle:@"Thanks!" otherButtonTitles: nil];
    [alert show];
    

}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)requestStarted:(ASIHTTPRequest *)request{
    
    NSLog(@"requestStarted%@",request);
    
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    
    NSLog(@"requestFinished%@",request);
    
    NSString *responseString=[[request responseString]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@"%@",[responseString JSONValue]);
    
    
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    
    NSLog(@"requestFailed%@",request);
    
}


#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {

    //[super dealloc];
}

@end
