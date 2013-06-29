//
//  MenuViewController.m
//  Tickl.Me
//
//  Created by Mountain on 2/9/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuTableCell.h"
#import "AppDelegate.h"
#import "MapView_ViewController.h"
#import "ViewController.h"
#import "DDMenuController.h"
#import "MenuViewController.h"
#import "FindEvents_ViewController.h"
#import "MyProfile_ViewController.h"
#import "MyEvents_ViewController.h"
#import "Filters_ViewController.h"
#import "Blog_ViewController.h"
#import "Help_ViewController.h"
#import "SettingViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MyFriends_ViewController.h"
#import "FriendRequestAndEvetnInVitaiaionViewController.h"
#import "MailLogIn_ViewController.h"
#import "EventListViewViewController.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import "ViewController.h"
#import "FacebookManager.h"



@interface MenuViewController ()
{
    DDMenuController *menuController ;
    UINavigationController *navController;
}
@end

@implementation MenuViewController
@synthesize lstTitles;

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
    
    
    self.lstTitles = @[
                       @"Home - Map/List",
                       @"Search",
                       @"My Profile",
                       @"My Events",
                       @"Filters",
                       @"Friends",
                       @"Tickl.me Blog",
                       @"Help"
                       ];
    
    [self.tableView reloadData];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewRowAnimationTop];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // NSLog(@"%d", self.lstTitles.count);
    return self.lstTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        UIView *selectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 46)];
        selectionView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:142.0/255.0 blue:211.0/255.0 alpha:1.0];
        cell.selectedBackgroundView = selectionView;
    }
    
       cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //    static NSString *CellIdentifier = @"MenuTableCell";
    //
    //    MenuTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //
    //    if (cell == nil)
    //    {
    //        cell = (MenuTableCell *)[[[NSBundle mainBundle] loadNibNamed:@"MenuTableCell" owner:self options:nil] objectAtIndex:0];
    //
    //        //Selection View
    //        UIView *selectionView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 46)] autorelease];
    //        selectionView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:142.0/255.0 blue:211.0/255.0 alpha:1.0];
    //        cell.selectedBackgroundView = selectionView;
    //    }
    
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = [NSString stringWithFormat:@"  %@", [self.lstTitles objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 36;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
    
    if (indexPath.row == 0) {
        EventListViewViewController *map = [[EventListViewViewController alloc] init];
        navController = [[UINavigationController alloc] initWithRootViewController:map];
    }
    else if (indexPath.row == 1)
    {
        FindEvents_ViewController *find = [[FindEvents_ViewController alloc] init];
        navController = [[UINavigationController alloc] initWithRootViewController:find];
    }
    else if (indexPath.row == 2)
    {
        MyProfile_ViewController *profile = [[MyProfile_ViewController alloc] init];
        navController = [[UINavigationController alloc] initWithRootViewController:profile];
    }
    else if (indexPath.row == 3)
    {
        //        FriendRequestAndEvetnInVitaiaionViewController*friendRequest=[[FriendRequestAndEvetnInVitaiaionViewController alloc]initWithNibName:@"FriendRequestAndEvetnInVitaiaionViewController" bundle:nil];
        //         [self.vcMain setRootController:friendRequest animated:YES];
        
        MyEvents_ViewController *events = [[MyEvents_ViewController alloc] init];
        navController = [[UINavigationController alloc] initWithRootViewController:events];
    }
    else if (indexPath.row == 4)
    {
        Filters_ViewController *filters = [[Filters_ViewController alloc] init];
        navController = [[UINavigationController alloc] initWithRootViewController:filters];
    }
    else if (indexPath.row == 5)
    {//Friends
        MyFriends_ViewController *find = [[MyFriends_ViewController alloc] init];
        navController = [[UINavigationController alloc] initWithRootViewController:find];
    }
    else if (indexPath.row == 6)
    {
        Blog_ViewController *blog = [[Blog_ViewController alloc] init];
        navController = [[UINavigationController alloc] initWithRootViewController:blog];
    }
    else if (indexPath.row == 7)
    {
        Help_ViewController *help = [[Help_ViewController alloc] init];
        navController = [[UINavigationController alloc] initWithRootViewController:help];
        //[self.vcMain setRootController:self.vcMap animated:YES];
    }
    
    
    
    [menuController setRootController:navController animated:YES];
    //  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (IBAction)clickSettings:(id)sender
{
    menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
    SettingViewController *blog = [[SettingViewController alloc] init];
    navController  = [[UINavigationController alloc] initWithRootViewController:blog];
    [menuController setRootController:navController animated:YES];
}

- (IBAction)clickSignout:(id)sender {
    
    FacebookManager *fbMngr = [FacebookManager sharedInstance];
    
    [fbMngr logout];
    
    NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    destPath = [destPath stringByAppendingPathComponent:@"userName.plist"];
    
    //NSLog(@"tft%@",destPath);
    
    
    NSDictionary *dictValue = [[NSDictionary alloc]
                               initWithContentsOfFile:destPath];
    
    NSString *strVal = [dictValue objectForKey:@"userName"];
    
    // NSLog(@"JSON String 1%@",strVal);

    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://108.168.203.226:8123/users/userLogout"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
       
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    NSDictionary* postDict = [NSDictionary dictionaryWithObjectsAndKeys:strVal,@"email_id",nil];
    NSString* jsonData = [postDict JSONRepresentation];
    NSData* postData = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
    [request appendPostData:postData];
    [request setDelegate:self];
    [request startAsynchronous];

    
    menuController = (DDMenuController*)((AppDelegate*)[[UIApplication sharedApplication] delegate]).menuController;
    ViewController *help = [[ViewController alloc] init];
    navController = [[UINavigationController alloc] initWithRootViewController:help];

    [menuController setRootController:navController animated:YES];
    
}

#pragma mark ASIHTTPReq Delegate
- (void)requestStarted:(ASIHTTPRequest *)request{
    
    NSLog(@"requestStarted%@",request);
    
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    
    NSLog(@"requestFinished%@",request);
    
    NSString *responseString=[[request responseString]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //NSLog(@"Response %@",responseString);

    
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    
    NSLog(@"requestFailed%@",request);
    
}


@end