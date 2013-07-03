//
//  AddFriendViewController.m
//  Tickl.Me
//
//  Created by Chandra Mohan on 22/04/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "AddFriendViewController.h"
#import "RequsetsViewController.h"
#import "Tweet.h"
#import "TwitterConnection.h"
#import "RequsetsViewController.h"
#import "FBDialog.h"
#import "SBJsonParser.h"
#import "JSON.h"
#import "AppDelegate.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>

#define IMAGE_PREVIEW_TAG 11
#define NAME_LABEL_TAG 10


#define TWITTER_FOLLOWINGS_URL @"https://api.twitter.com/1/following.json"
#define TWITTER_NEAR_FEED_URL @"https://api.twitter.com/1.1/search/tweets.json"
#define TWITTER_FRIENDS_URL @"https://api.twitter.com/1.1/friends/list.json"

#define ERROR_LOCATION_FAILED @"Failed to get you current location"
#define ERROR_NO_DATA @"Could not retrieve your data.. try later"
#define ERROR_TWITTER_ACCESS @"In order to use Twitter functionality, please add your Twitter account in Settings."
#define ERROR_TWITTER_LIMIT @"Twitter rate limit... =^("
#define ERROR_PARSING @"Json error"
#define ERROR_SERVER @"Server error %i... please try later =^("

#define MESSAGE_TWEET @"Hey twitto! check this funny image of you haha =^]"



@interface AddFriendViewController ()
{
    
    NSString *phonenumber;
    NSString *showListingUsers;
}
@end

@implementation AddFriendViewController

@synthesize myAccount,paramString,resultFollowersNameList;
@synthesize facebook,reqFriendList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithFacebook:(Facebook*)fb
{
    self = [super init];
    if (self) {
        self.facebook = fb;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"Add Friends";
    
    showListingUsers=@"Twitter";
    arrFriendList=[[NSMutableArray alloc]init];
    arrFacebookFriend=[[NSMutableArray alloc]init];
    
    tweets = [[NSMutableArray alloc]init];
    fndname = [[NSMutableArray alloc]init];
    
    
    
}

#pragma mark
#pragma Fb

-(void)sendFBPost:(int)tag
{
    
    NSString *Message = [NSString stringWithFormat:@"-Posted via Events iPhone App"];
    NSMutableDictionary *params1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    Message, @"message", nil];
    NSString *post=[[appDelegate.FBFriendListArray objectAtIndex:tag] objectForKey:@"id"];
    
    [[appDelegate facebook] requestWithGraphPath:[NSString stringWithFormat:@"/%@/feed",post] andParams:params1 andHttpMethod:@"POST" andDelegate:self];
    UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@"Message!" message:@"Invitation Send Sucessfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show];
	
}


#pragma mark - FBSessionDelegate Methods

/**
 * Called when the user has logged in successfully.
 */
- (void)fbDidLogin
{
    
    [self showLoggedIn];
    
    // Save authorization information
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[[appDelegate facebook] accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[[appDelegate facebook] expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}



- (void) showLoggedIn
{
    [self apiFQLIMe];
}
- (void)authorize:(NSArray *)permissions
{
    
}

- (void) apiFQLIMe
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"SELECT uid,name,birthday,first_name,last_name,current_location,pic,email,sex FROM user WHERE uid=me()", @"query",
                                   nil];
    
	
    [[appDelegate facebook] requestWithMethodName:@"fql.query"
                                        andParams:params
                                    andHttpMethod:@"POST"
                                      andDelegate:self];
    
    
    [[appDelegate facebook] requestWithGraphPath:@"me/friends" andDelegate:self];
    
}

- (void)request:(FBRequest *)request didLoad:(id)result
{
    //NSLog(@"result is %@",result);
    
    if ([result isKindOfClass:[NSArray class]])
	{
        result = [result objectAtIndex:0];
    }
    // This callback can be a result of getting the user's basic
    // information or getting the user's permissions.
    
    if ([result objectForKey:@"data"])
	{
		appDelegate.FBFriendListArray = [result objectForKey:@"data"];
        
        
	}
    [tblAddFriend reloadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([showListingUsers isEqualToString:@"Twitter"]){
        
        return tweets.count;
        
    }
    
    if([showListingUsers isEqualToString:@"Email"]){
        
        return arrFriendList.count;
        
    }
    
    if([showListingUsers isEqualToString:@"Facebook"]){
        
        return [appDelegate.FBFriendListArray count];
        
    }


    return arrFriendList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell	*cell = [tblAddFriend dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell=nil;
    
    if(cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        
        UIImageView *imgFriend=[[UIImageView alloc]initWithFrame:CGRectMake(10, 7.5, 45, 45)];
        UILabel *lblFriendName=[[UILabel alloc]initWithFrame:CGRectMake(60, 5, 200, 25)];
        UIButton *btnAddFriend=[UIButton buttonWithType:UIButtonTypeCustom];
        if([showListingUsers isEqualToString:@"Facebook"])
        {
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(15,2,150,20)];
            // lbl.tag=MYPRICELABEL_TAG;
            lbl.font=[UIFont systemFontOfSize:15.0];
            lbl.textColor=[UIColor blackColor];
            [lbl setBackgroundColor:[UIColor clearColor]];
            //ADD THE LABEL TO CELLS CONTACT VIEW
            [cell.contentView addSubview:lbl];
            
            UIButton *ProfileImageButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
            [ProfileImageButton setBackgroundColor:[UIColor clearColor]];
            [ProfileImageButton setClearsContextBeforeDrawing:YES];
            [ProfileImageButton setUserInteractionEnabled:NO];
            NSString *ImagePath =[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture",[[appDelegate.FBFriendListArray objectAtIndex:indexPath.row] objectForKey:@"id"]];
            
            [ProfileImageButton setImageWithURL:[NSURL URLWithString:ImagePath] placeholderImage:[UIImage imageNamed:@"nouser.png"]];
            [cell.contentView addSubview:ProfileImageButton];
            
            
            
            
            UILabel *NameLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 20, 300, 30)];
            [NameLabel setTextColor:[UIColor blackColor]];
            [NameLabel setBackgroundColor:[UIColor clearColor]];
            [NameLabel setTextAlignment:UITextAlignmentLeft];
            [NameLabel setFont:[UIFont systemFontOfSize:16.0f]];
            [NameLabel setText:[NSString stringWithFormat:@"%@",[[appDelegate.FBFriendListArray objectAtIndex:indexPath.row] valueForKey:@"name"]]];
            [cell.contentView addSubview:NameLabel];
            
            
            btnAddFriend.frame=CGRectMake(270, 5, 25, 25);
            [btnAddFriend setImage:[UIImage imageNamed:@"imgAddFriend.png"] forState:UIControlStateNormal];
            [btnAddFriend addTarget:self action:@selector(sendInvitaionFormApp:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btnAddFriend];
            
            
        }
        else if ([showListingUsers isEqualToString:@"Twitter"])
        {
            UIImageView *imgEvent=[[UIImageView alloc]initWithFrame:CGRectMake(2, 0, 43, 43)];
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[tweets objectAtIndex:indexPath.row]]];
            
            UIImage *img = [UIImage imageWithData:data];
            
            imgEvent.image=img;
            
            
             NSLog(@"%@",imgEvent.image);
            
            [cell.contentView addSubview:imgEvent];
            
            UILabel *NameLabel=[[UILabel alloc]initWithFrame:CGRectMake(80, 10, 200, 30)];
            [NameLabel setTextColor:[UIColor blackColor]];
            [NameLabel setTextAlignment:NSTextAlignmentLeft];
            [NameLabel setFont:[UIFont systemFontOfSize:11.0f]];
            [NameLabel setText:[fndname objectAtIndex:indexPath.row]];
            [cell addSubview:NameLabel];
            
            btnAddFriend.frame=CGRectMake(270, 5, 25, 25);
            [btnAddFriend setImage:[UIImage imageNamed:@"imgAddFriend.png"] forState:UIControlStateNormal];
            [btnAddFriend addTarget:self action:@selector(sendInvitaionFormApp2:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btnAddFriend];


            
        }
        else if ([showListingUsers isEqualToString:@"Email"])
        {
            
//            mailView.hidden = NO;
//            scan.hidden = NO;
//            scanInfo.hidden =   NO;
//            info.hidden = NO;
            
            //    firstName,@"firstName",lastName,@"lastName",phonenumber,@"phonenumber",emailID,@"emailID",useImage,@"userImage",nil];
                        NSDictionary *dict=(NSDictionary*)[arrFriendList objectAtIndex:indexPath.row];
            
                        UIImage *image=[UIImage imageWithData:[dict valueForKey:@"userImage"]];
                        imgFriend.image=image;
                        [cell addSubview:imgFriend];
            
                        lblFriendName.backgroundColor=[UIColor clearColor];
                        lblFriendName.text=[NSString stringWithFormat:@"%@ %@",[dict valueForKey:@"firstName"],[dict valueForKey:@"lastName"]];
                        lblFriendName.font=[UIFont boldSystemFontOfSize:14];
                        [cell addSubview:lblFriendName];
            
                        UILabel *lblFriendEmailID=[[UILabel alloc]initWithFrame:CGRectMake(60, 30, 240, 35)];
                        lblFriendEmailID.backgroundColor=[UIColor clearColor];
                        lblFriendEmailID.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"emailID"]];
                        lblFriendEmailID.font=[UIFont boldSystemFontOfSize:14];
                        [cell addSubview:lblFriendEmailID];
            
                        btnAddFriend.frame=CGRectMake(270, 5, 25, 25);
                        [btnAddFriend setImage:[UIImage imageNamed:@"imgAddFriend.png"] forState:UIControlStateNormal];
                        //[btnAddFriend addTarget:self action:@selector(sendInvitaionFormApp) forControlEvents:UIControlEventTouchUpInside];
                        [cell addSubview:btnAddFriend];
            
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && currentMaxDisplayedCell == 0){
        currentMaxDisplayedCell = -1;
    }
    
    if (indexPath.row > currentMaxDisplayedCell){
        
        cell.contentView.alpha = 0.7;
        
        CGAffineTransform transformScale = CGAffineTransformMakeScale(0.9, 0.9);
        
        cell.contentView.transform = transformScale;
        
        [tblAddFriend bringSubviewToFront:cell.contentView];
        [UIView animateWithDuration:0.5 animations:^{
            cell.contentView.alpha = 1;
            //clear the transform
            cell.contentView.transform = CGAffineTransformIdentity;
        } completion:nil];
        
    }
    currentMaxDisplayedCell = indexPath.row;
}

-(void)sendInvitaionFormApp2:(id)sender{
    
    
    
}

-(void)sendInvitaionFormApp:(id)sender
{
    
    UITableViewCell *cell1 = ((UITableViewCell *)[sender superview]);
    
    NSLog(@"cell row: int%i", [tblAddFriend indexPathForCell:cell1].row);
    
    
    [self sendFBPost:[tblAddFriend indexPathForCell:cell1].row];
}

- (void)request:(FBRequest *)request didLoadRawResponse:(NSData *)data {
}

- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response{
    
}

#pragma mark Fb Delegate

- (void) facebookLoginFailed{
    
    
}

- (void) facebookLoginSucceeded{
    
    
}

- (void)requestLoading:(FBRequest *)request{
    
}
- (void) friendsListLoaded:(NSMutableArray*) array
{
    arrFriendList=array;
    
    [tblAddFriend reloadData];
}



#pragma mark - Facebook server calls

-(void) getFriendsList{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"name,id,picture,installed", @"fields", nil];
    @autoreleasepool {
        self.reqFriendList = [facebook requestWithGraphPath:@"me/friends" andParams:params andDelegate:self];
        //[facebook_ requestWithGraphPath:@"me/friends" andDelegate: self ];
    }
}


#pragma mark - Twitter server calls

- (void)loadProfilePictures
{
    for (int i = 0; i < tweets.count; i++)
    {
        Tweet *tweet = [tweets objectAtIndex:i];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:tweet.bigImageUrl]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                tweet.image = [UIImage imageWithData:data];
                
                NSArray *array = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:i inSection:0]];
                [tblAddFriend reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationNone];
            });
        });
    }
}

- (void)tweetRetrieved:(id)response
{
    if( [response isKindOfClass:[NSString class]] )
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                            message:response
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
        [tblAddFriend reloadData];
        //[self loadProfilePictures];
        [self dismissLoadingAlertView];
        dataLoading = NO;
        return;
    }
    
    NSArray *jsonusers = [response objectForKey:@"users"];
    NSString *nextCursor = [response objectForKey:@"next_cursor_str"];
    
    for (NSDictionary *jsonTweet in jsonusers)
    {
        NSString *name = [jsonTweet objectForKey:@"name"];
        NSString *user = [jsonTweet objectForKey:@"screen_name"];
        NSString *text = @"";
        
        NSString *imageUrl = [jsonTweet objectForKey:@"profile_image_url"];
        UIImage *profilePic = nil;
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = 0;
        coordinate.longitude = 0;
        
        [tweets addObject:imageUrl];
        [fndname addObject:name];
        
        
        Tweet *tweet = [[Tweet alloc] initWithUser:user name:name text:text coordinate:coordinate image:profilePic imageURL:imageUrl];
        
        //[imagPic addObject:imageUrl];
        //[tweets addObject:tweet];
    }
    
    // If there's any other page, reload tableview data and download the profile pictures, otherwise make a new call
    if ([nextCursor isEqualToString:@"0"]) {
        [tblAddFriend reloadData];
        // [self loadProfilePictures];
        [self dismissLoadingAlertView];
        dataLoading = NO;
    }
    else {
        [self tweeterConnectionWithCursor:nextCursor];
    }
}

- (void)tweeterConnectionWithCursor:(NSString *)cursor
{
    NSDictionary *params = @{@"cursor" : cursor,
    @"skip_status" : @"true",
    @"include_user_entities" : @"true"};
    
    // NOTE: Im not using here twiter API 1.1, but 1, because of their crazy rate limit policy.. If you want to use API 1.1 please use TWITTER_FRIENDS_URL constant
    [TwitterConnection twitterConnectionWithApiUrl:TWITTER_FOLLOWINGS_URL params:params target:self selector:@selector(tweetRetrieved:)];
}

- (void)retriveCurrentTwitterAccount
{
    dataLoading = YES;
    tweets = [NSMutableArray new];
    [self tweeterConnectionWithCursor:@"-1"];
    [self showLoadingAlert];
}


- (void)refreshDataIfNecessary
{
    if ((tweets == nil || tweets.count == 0) && !dataLoading)
    {
        [self retriveCurrentTwitterAccount];
    }
}

- (void)showLoadingAlert
{
    loadingAlertView = [[UIAlertView alloc] initWithTitle:@"Loading" message:@"Please wait"
                                                 delegate:self
                                        cancelButtonTitle:nil
                                        otherButtonTitles:nil];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.frame = CGRectMake(125, 75, 36, 36);
    [loadingAlertView addSubview:spinner];
    [spinner startAnimating];
    [loadingAlertView show];
}

- (void)dismissLoadingAlertView
{
    [loadingAlertView dismissWithClickedButtonIndex:0 animated:YES];
    loadingAlertView = nil;
}




//commented init due to crash!

-(void)sendInvitaionFormApp1:(id)sender
{
    
    UITableViewCell *cell1 = ((UITableViewCell *)[sender superview]);
    
    NSLog(@"cell row: int%i", [tblAddFriend indexPathForCell:cell1].row);
    
    
    //    RequsetsViewController *reqView = [[RequsetsViewController alloc]initWithNibName:@"RequsetsViewController" bundle:nil];
    //
    //     [self.navigationController pushViewController:reqView animated:YES];
    
       
}


#pragma mark Twitter Methods

//Get The Twitter Account Instance
/******To check whether More then Twitter Accounts setup on device or not *****/

-(void)getTwitterAccounts {
    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [accountStore requestAccessToAccountsWithType:accountType
                            withCompletionHandler:^(BOOL granted, NSError *error) {
                                
                                if (granted && !error) {
                                    
                                    //accountsList = [accountStore accountsWithAccountType:accountType];
                                    
                                    // int NoOfAccounts = [accountsList count];
                                    
                                    //                                    if (NoOfAccounts > 1) {
                                    //
                                    //                                        NSLog(@"device has more then one twitter accounts %i",NoOfAccounts);
                                    //
                                    //                                    }
                                    //                                    else
                                    //                                    {
                                    //                                        myAccount = [accountsList objectAtIndex:0];
                                    //                                        NSLog(@"device has single twitter account : 0");
                                    //
                                    //                                    }
                                }
                                else
                                {
                                    // show alert with information that the user has not granted your app access, etc.
                                }
                                
                            }];
}


/************* getting followers/friends ID list code start here *******/
// so far we have instnce of current account, that is myAccount //

-(void) getTwitterFriendsIDListForThisAccount{
    
    /*** url for all friends *****/
    // NSURL *url = [NSURL URLWithString:@"http://api.twitter.com/1/friends/ids.json"];
    
    /*** url for Followers only ****/
    NSURL *url = [NSURL URLWithString:@"http://api.twitter.com/1/followers/ids.json"];
    
    
    NSDictionary *p = [NSDictionary dictionaryWithObjectsAndKeys:myAccount.username, @"screen_name", nil];
    
    TWRequest *twitterRequest = [[TWRequest alloc] initWithURL:url parameters:p requestMethod:TWRequestMethodGET];
    
    [twitterRequest setAccount:myAccount];
    
    [twitterRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResposnse, NSError *error)
     {
         if (error) {
             
         }
         NSError *jsonError = nil;
         // Convert the response into a dictionary
         NSDictionary *twitterFriends = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONWritingPrettyPrinted error:&jsonError];
         
         NSArray *IDlist = [twitterFriends objectForKey:@"ids"];
         
         NSLog(@"response value is: %@", IDlist);
         
         int count = IDlist.count;
         for (int i=0; i<count; i++ ) {
             
             
             [paramString appendFormat:@"%@",[IDlist objectAtIndex:i]];
             
             if (i <count-1) {
                 NSString *delimeter = @",";
                 [paramString appendString:delimeter];
             }
             
         }
         
         NSLog(@"The mutable string is %@", paramString);
         [self getFollowerNameFromID:paramString];
     }
     ];
    
}


-(void) getFollowerNameFromID:(NSString *)ID{
    
    
    NSURL *url = [NSURL URLWithString:@"http://api.twitter.com/1/users/lookup.json"];
    NSDictionary *p = [NSDictionary dictionaryWithObjectsAndKeys:ID, @"user_id",nil];
    NSLog(@"make a request for ID %@",p);
    
    TWRequest *twitterRequest = [[TWRequest alloc] initWithURL:url
                                                    parameters:p
                                                 requestMethod:TWRequestMethodGET];
    [twitterRequest setAccount:myAccount];
    
    
    [twitterRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        if (error) {
            
        }
        NSError *jsonError = nil;
        
        
        NSDictionary *friendsdata = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONWritingPrettyPrinted error:&jsonError];
        //  NSLog(@"friendsdata value is %@", friendsdata);
        
        
        //  resultFollowersNameList = [[NSArray alloc]init];
        resultFollowersNameList = [friendsdata valueForKey:@"name"];
        NSLog(@"resultNameList value is %@", resultFollowersNameList);
        
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    [self refreshDataIfNecessary];
}


- (IBAction)btnSegentEmailCliceked:(UISegmentedControl *)sender {
    if(sender.selectedSegmentIndex==0){
        
                
        showListingUsers=@"Twitter";
        
        [self refreshDataIfNecessary];
        
         [tblAddFriend reloadData];
        
        
    }
    else if (sender.selectedSegmentIndex==1)
    {
                
        showListingUsers=@"Facebook";
        
        appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:@"FBAccessTokenKey"]
            && [defaults objectForKey:@"FBExpirationDateKey"]) {
            [appDelegate facebook].accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
            [appDelegate facebook].expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
        }
        
        if (![[appDelegate facebook] isSessionValid])
        {
            [appDelegate facebook].sessionDelegate = self;
            appDelegate.userPermissions = [[NSArray alloc] initWithObjects:
                                           @"read_stream", @"publish_stream", @"email", @"offline_access",@"friends_checkins",@"friends_about_me",@"user_games_activity",nil];
            
            [[appDelegate facebook] authorize:appDelegate.userPermissions];
            
        }
        else {
            [self showLoggedIn];
        }
        
        [tblAddFriend reloadData];
    }
    else  if(sender.selectedSegmentIndex==2)
    {
        showListingUsers= @"Email";
        if (ABAddressBookRequestAccessWithCompletion) { // if in iOS 6
            
            // Request authorization to Address Book
            ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
            
            if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
                ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
                    // First time access has been granted, add the contact
                });
            }
            else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
                // The user has previously given access, add the contact
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"alert" message:@"Go in privacy setting to access contacts" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }
        else{ // if not in iOS 6
            // just get the contacts directly
            
            
        }
        
        contactsMutableArray = [[NSMutableArray alloc] init];
        ABAddressBookRef addressBook = ABAddressBookCreate();    __block BOOL accessGranted = NO;
        
        if (ABAddressBookRequestAccessWithCompletion != NULL)
        {
            // we're on iOS6
            
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
                accessGranted = granted;
                dispatch_semaphore_signal(sema);
            });
            
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
            // dispatch_release(sema);
        }
        else
        {
            // we're on iOS5 or older
            
            accessGranted = YES;
        }
        
        
        if(accessGranted)
        {
            NSMutableArray *contactsToBeAdded=[[NSMutableArray alloc] init];
            //   ABAddressBookRef addressBook = ABAddressBookCreate();
            // ABAddressBookCreate();
            //CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBook);
            NSArray *arr = (__bridge_transfer  NSArray*)ABAddressBookCopyArrayOfAllPeople(addressBook);
            
            CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBook);
            //CFArrayRef people = ABAddressBookCopyPeopleWithName(addressBook,CFSTR("Utkarsha"));
            CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
            for(int i=0;i<nPeople;i++){
                ABRecordRef person=CFArrayGetValueAtIndex(people, i);
                NSString *firstName=(__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
                NSString *lastName=(__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
                
                
                
                NSUInteger emailsCount;
                ABMultiValueRef emailsMultiValueRef = ABRecordCopyValue(person, kABPersonEmailProperty);
                NSString *emailID;//=(__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonEmailProperty);                //Goes through the emails to check which one is the home email
                for(emailsCount = 0; emailsCount <= ABMultiValueGetCount(emailsMultiValueRef);emailsCount++){
                    NSString *emailLabel = (__bridge_transfer NSString *)ABMultiValueCopyLabelAtIndex (emailsMultiValueRef, emailsCount);
                    
                    NSString *str=@"Home";
                    
                    if(![emailLabel rangeOfString:str].location==NSNotFound){
                        
                        if ((__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(emailsMultiValueRef, emailsCount) != NULL){
                            
                            emailID = (__bridge_transfer NSString *)ABRecordCopyValue(person, kABPersonEmailProperty);
                        }
                        
                        //If the last name property does not exist
                        else{
                            
                            emailID = @"No Email ID";
                        }
                    }
                    else{
                        emailID = @"No Email ID";
                    }
                }
                
                
                NSData *useImageData=(__bridge_transfer NSData*)ABPersonCopyImageDataWithFormat(person, kABPersonImageFormatThumbnail);
                UIImage  *img = [UIImage imageWithData:useImageData];
                
                
                ABMultiValueRef multi = ABRecordCopyValue(person, kABPersonPhoneProperty);
                int count1=ABMultiValueGetCount(multi);
                NSLog(@"%d",count1);
                phonenumber = (__bridge NSString *)ABMultiValueCopyValueAtIndex(multi, 0);
                
                if(!firstName) firstName=@"";
                if(!lastName) lastName=@"";
                if(!phonenumber) phonenumber=@"";
                NSDictionary *curContact=[NSDictionary dictionaryWithObjectsAndKeys:(NSString *)firstName,@"firstName",lastName,@"lastName",phonenumber,@"phonenumber",emailID,@"emailID",useImageData,@"userImage",nil];
                [contactsToBeAdded addObject:curContact];
                arrFriendList = contactsToBeAdded;
            }
            
            if([contactsToBeAdded count] == 0)
            {
                //   contactsTable.hidden = YES;
                //       UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Message" message:@"No contacts are avialable" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                //       [alert show];
            }
            else
            {
                
                //  NSLog(@"%@",contactsMutableArray);
            }
        }
        //    CFRelease(people);
        //    CFRelease(addressBook);
        [tblAddFriend reloadData];
    }
    
}



- (void)btnBackClicked:(id)sender {
    [[self navigationController]popViewControllerAnimated:YES];
}

//getting facebook response

-(void)myInfoLoaded:(NSMutableDictionary *)myInfo{
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
