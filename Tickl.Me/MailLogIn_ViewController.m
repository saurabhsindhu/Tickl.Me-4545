//
//  MailLogIn_ViewController.m
//  Tickl.Me
//
//  Created by Mountain on 2/1/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "MailLogIn_ViewController.h"
#import "Filters_ViewController.h"
#import "PasswordRecovery_ViewController.h"
#import "AppDelegate.h"
#import "JSON.h"
@interface MailLogIn_ViewController ()

@end

@implementation MailLogIn_ViewController

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
    self.title=@"Login";
}

- (IBAction)clickForgotPassword:(id)sender
{
    PasswordRecovery_ViewController *password = [[PasswordRecovery_ViewController alloc] init];
    [self.navigationController pushViewController:password animated:YES];
}

- (IBAction)clickCancel:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)clickLogin:(id)sender
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.login = 1;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithBool:YES] forKey:@"Login"];
    
    [defaults setValue:@"loginFromEmail" forKey:@"LoginVia"];
    [defaults synchronize];
    
    Filters_ViewController *filter = [[Filters_ViewController alloc] init];
    [self.navigationController pushViewController:filter animated:YES];
    
    
    NSMutableString *requestString1 = [NSMutableString stringWithFormat:@"http://108.168.203.226:8123/users/getLogin"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestString1]];
    [request setHTTPMethod:@"POST"];
    
    NSString* body = [NSString stringWithFormat:@"{\"User\":{\"username\":\"%@\",\"password\":\"%@\"}}",self.username_txtField.text,self.password_txtField.text];
    
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

    
    NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    destPath = [destPath stringByAppendingPathComponent:@"userName.plist"];
    
    // If the file doesn't exist in the Documents Folder, copy it.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:destPath]) {
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"userName" ofType:@"plist"];
        [fileManager copyItemAtPath:sourcePath toPath:destPath error:nil];
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    [dict setObject:self.username_txtField.text forKey:@"userName"];
    
    [dict writeToFile:destPath atomically:YES];

    
    
    
//    UIAlertView *fail = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Please double check your username and password. If you're having trouble, tap the Forgot Password link." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
//    [fail show];
//    [fail release];
}

#pragma mark - UITextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.username_txtField) {
        [self.password_txtField becomeFirstResponder];
    }
    else
        [textField resignFirstResponder];
    
    return TRUE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
