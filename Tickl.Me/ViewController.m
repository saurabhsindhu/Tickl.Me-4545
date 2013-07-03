//
//  ViewController.m
//  Tickl.Me
//
//  Created by Mountain on 2/1/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "ViewController.h"
#import "MailLogIn_ViewController.h"
#import "Filters_ViewController.h"
#import "CreateAccount_ViewController.h"
#import "FBFriend.h"
#import "JBRequestPool.h"
#import "MBProgressHUD.h"
#import "NSString+SBJSON.h"
#import "GlobalDeclarations.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)clickCreateAccount:(id)sender
{
    CreateAccount_ViewController *account = [[CreateAccount_ViewController alloc] init];
    [self.navigationController pushViewController:account animated:YES];
}

- (IBAction)clickLogInWithFacebook:(id)sender
{
    FacebookManager *myFacebook = [FacebookManager sharedInstance];
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    NSDate *expirationDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"expiration_date"];
    [myFacebook setDelegate:self];
    if (accessToken && expirationDate)
    {
        [myFacebook authorizeWithAccessToken:accessToken expirationDate:expirationDate];
    }
    else
        [myFacebook authorize];
    
}

- (IBAction)clickWhyFacebook:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Why Facebook?" message:@"We can use information from your Facebook account to make tickl.me better. We don't share your data." delegate:self cancelButtonTitle:nil otherButtonTitles:@"", nil];
   
       
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, alert.frame.size.height, alert.frame.size.width)];
//    
//    NSString *path = [[NSString alloc] initWithString:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"black_bg.png"]];
//    UIImage *bkgImg = [[UIImage alloc] initWithContentsOfFile:path];
//    [imageView setImage:bkgImg];
//   
//    
//    [alert addSubview:imageView];
//    
//    for (UIView *view in [alert subviews])
//    {
//        if ([view isKindOfClass:[UIButton class]])
//        {
//            [view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"got_it.png"]]];
//        }
//    }
//   
    
    [alert show];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (IBAction)clickLogInWithEmail:(id)sender
{
    MailLogIn_ViewController *mail = [[MailLogIn_ViewController alloc] init];
    [self.navigationController pushViewController:mail animated:YES];
}

#pragma mark FacebookManagerDelegate Methods
- (void) facebookLoginSucceeded
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithBool:YES] forKey:@"Login"];
    
     [defaults setValue:@"loginFromFacebook" forKey:@"LoginVia"];
    
    [defaults synchronize];
    
    FacebookManager *myFacebook = [FacebookManager sharedInstance];
    
    [myFacebook getMyInfo];
    //[myFacebook getFriends];
   
    
    Filters_ViewController *filter = [[Filters_ViewController alloc] init];
    [self.navigationController pushViewController:filter animated:YES];
}

- (void) facebookLoginFailed {
  
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Facebook login failed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    return;
}

-(void)myInfoLoaded:(NSMutableDictionary *)myInfo{
    
    NSLog(@"%@", myInfo);
    
    [[GlobalDeclarations sharedInstance]setUserDefaultValueForKey:[myInfo valueForKey:@"first_name"] forKey:@"UserFirstName"];
     [[GlobalDeclarations sharedInstance]setUserDefaultValueForKey:[myInfo valueForKey:@"last_name"]  forKey:@"UserLastName"];
     [[GlobalDeclarations sharedInstance]setUserDefaultValueForKey:[myInfo valueForKey:@"name"] forKey:@"UserName"];
     [[GlobalDeclarations sharedInstance]setUserDefaultValueForKey:[myInfo valueForKey:@"id"]  forKey:@"UserID"];
    [[GlobalDeclarations sharedInstance]setUserDefaultValueForKey:[[[myInfo valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url" ] forKey:@"UserProfileImage"];
     [[GlobalDeclarations sharedInstance]setUserDefaultValueForKey:[myInfo valueForKey:@"email"]  forKey:@"UserEmail"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
