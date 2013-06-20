//
//  AddFriendViewController.m
//  Tickl.Me
//
//  Created by Chandra Mohan on 22/04/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "AddFriendViewController.h"
#import "RequsetsViewController.h"

@interface AddFriendViewController ()
{
    
    NSString *phonenumber;
    NSString *showListingUsers;
}
@end

@implementation AddFriendViewController

@synthesize myAccount,paramString,resultFollowersNameList;

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
    
    self.title=@"Add Friends";
    
    //showListingUsers=@"Email";
    arrFriendList=[[NSMutableArray alloc]init];
    
    
    
    
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor=[UIColor whiteColor];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrFriendList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
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
            FBFriend *friend=[[FBFriend alloc]init];
            friend=(FBFriend*)[arrFriendList objectAtIndex:indexPath.row];
            
            NSURL *url = [NSURL URLWithString:friend.fbPicture];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            imgFriend.image=image;
            [cell addSubview:imgFriend];
            
            lblFriendName.backgroundColor=[UIColor clearColor];
            lblFriendName.text=[NSString stringWithFormat:@"%@",friend.fbName];
            lblFriendName.font=[UIFont boldSystemFontOfSize:14];
            [cell addSubview:lblFriendName];
            
            btnAddFriend.frame=CGRectMake(270, 5, 25, 25);
            [btnAddFriend setImage:[UIImage imageNamed:@"imgAddFriend.png"] forState:UIControlStateNormal];
            [btnAddFriend addTarget:self action:@selector(sendInvitaionFormApp:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btnAddFriend];
        }
        else if ([showListingUsers isEqualToString:@"Twitter"])
        {
            //            NSURL *url = [NSURL URLWithString:friend.fbPicture];
            //            NSData *data = [NSData dataWithContentsOfURL:url];
            //            UIImage *image = [UIImage imageWithData:data];
            //            UIImage *image=[UIImage imageNamed:@"UserImage.png"];
            //            imgFriend.image=image;
            //            [cell addSubview:imgFriend];
            //
            //            lblFriendName.backgroundColor=[UIColor clearColor];
            //            lblFriendName.text=[NSString stringWithFormat:@"Twitter friend name"];
            //            lblFriendName.font=[UIFont boldSystemFontOfSize:14];
            //            [cell addSubview:lblFriendName];
            //
            //            btnAddFriend.frame=CGRectMake(270, 5, 25, 25);
            //            [btnAddFriend setImage:[UIImage imageNamed:@"imgAddFriend.png"] forState:UIControlStateNormal];
            //            [btnAddFriend addTarget:self action:@selector(sendInvitaionFormApp) forControlEvents:UIControlEventTouchUpInside];
            //            [cell addSubview:btnAddFriend];
            
            
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
            [btnAddFriend addTarget:self action:@selector(sendInvitaionFormApp:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btnAddFriend];
            
            
        }
        else if ([showListingUsers isEqualToString:@"Email"])
        {
            
            mailView.hidden = NO;
            scan.hidden = NO;
            scanInfo.hidden =   NO;
            info.hidden = NO;
            
            //    firstName,@"firstName",lastName,@"lastName",phonenumber,@"phonenumber",emailID,@"emailID",useImage,@"userImage",nil];
            //            NSDictionary *dict=(NSDictionary*)[arrFriendList objectAtIndex:indexPath.row];
            //
            //            UIImage *image=[UIImage imageWithData:[dict valueForKey:@"userImage"]];
            //            imgFriend.image=image;
            //            [cell addSubview:imgFriend];
            //
            //            lblFriendName.backgroundColor=[UIColor clearColor];
            //            lblFriendName.text=[NSString stringWithFormat:@"%@ %@",[dict valueForKey:@"firstName"],[dict valueForKey:@"lastName"]];
            //            lblFriendName.font=[UIFont boldSystemFontOfSize:14];
            //            [cell addSubview:lblFriendName];
            //
            //            UILabel *lblFriendEmailID=[[UILabel alloc]initWithFrame:CGRectMake(60, 30, 240, 35)];
            //            lblFriendEmailID.backgroundColor=[UIColor clearColor];
            //            lblFriendEmailID.text=[NSString stringWithFormat:@"%@",[dict valueForKey:@"emailID"]];
            //            lblFriendEmailID.font=[UIFont boldSystemFontOfSize:14];
            //            [cell addSubview:lblFriendEmailID];
            //
            //            btnAddFriend.frame=CGRectMake(270, 5, 25, 25);
            //            [btnAddFriend setImage:[UIImage imageNamed:@"imgAddFriend.png"] forState:UIControlStateNormal];
            //            [btnAddFriend addTarget:self action:@selector(sendInvitaionFormApp) forControlEvents:UIControlEventTouchUpInside];
            //            [cell addSubview:btnAddFriend];
            
        }
    }
    
    return cell;
}


//commented init due to crash!

-(void)sendInvitaionFormApp:(id)sender
{
    
    UITableViewCell *cell1 = ((UITableViewCell *)[sender superview]);
    
    NSLog(@"cell row: int%i", [tblAddFriend indexPathForCell:cell1].row);
    
    
    //    RequsetsViewController *reqView = [[RequsetsViewController alloc]initWithNibName:@"RequsetsViewController" bundle:nil];
    //
    //     [self.navigationController pushViewController:reqView animated:YES];
    
    FacebookManager *myFacebook = [FacebookManager sharedInstance];
    [myFacebook setDelegate:self];
    FBFriend * friend=(FBFriend*)[arrFriendList objectAtIndex:0];
    NSString *kAppId=[FacebookManager sharedInstance].appID;
    NSString *path=[[NSBundle mainBundle] pathForResource:@"wildFlower" ofType:@"jpg"];
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   kAppId, @"app_id",
                                   @"https://developers.apple.com", @"link",
                                   /*@"http://www.impactinstruction.com/wordpress/wp-content/uploads/2012/04/practice1.jpg"*/path, @"picture",
                                   @"Facebook Dialogs", @"name",
                                   @"Reference Documentation", @"caption",
                                   friend.fbId,@"to",
                                   @"Using Dialogs to interact with users.", @"description",
                                   nil];
    // FBDialog *facebook=[[FBDialog alloc]init];
    //[[[FacebookManager sharedInstance] facebook] dialog:@"feed" andParams:params andDelegate:self];
    //  [myFacebook inviteFriendtoApp:[arrFriendList objectAtIndex:0]];
    
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

- (IBAction)btnSegentEmailCliceked:(UISegmentedControl *)sender {
    if(sender.selectedSegmentIndex==0){
        
        [mailView setHidden:YES];
        
        showListingUsers=@"Twiter";
        
        
        [self getTwitterFriendsIDListForThisAccount];
        
        
    }
    else if (sender.selectedSegmentIndex==1)
    {
        [mailView setHidden:YES];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        
        if([[defaults valueForKey:@"LoginVia"] isEqualToString:@"loginFromFacebook"])
        {
            FacebookManager *myFacebook = [FacebookManager sharedInstance];
            [myFacebook setDelegate:self];
            [myFacebook getFriends];
            showListingUsers=@"Facebook";
        }
        else
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
            [defaults setValue:@"loginFromFacebook" forKey:@"LoginVia"];
            FacebookManager *myFacebook1 = [FacebookManager sharedInstance];
            [myFacebook1 setDelegate:self];
            [myFacebook1 getFriends];
            showListingUsers=@"Facebook";
        }
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
