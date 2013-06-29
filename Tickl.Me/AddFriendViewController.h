//
//  AddFriendViewController.h
//  Tickl.Me
//
//  Created by Chandra Mohan on 22/04/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "FacebookManager.h"
#import <Twitter/Twitter.h>
#import <Accounts/Accounts.h>
#import "FBConnect.h"

@interface AddFriendViewController : UIViewController<FacebookManagerDelegate,FBRequestDelegate>

{
    NSMutableArray *arrFriendList;
    NSMutableArray *arrFacebookFriend;
    IBOutlet UITableView *tblAddFriend;
    IBOutlet UITableView *tblFollowers;
    NSMutableArray *contactsMutableArray;
    IBOutlet UIView *mailView;
    IBOutlet UIButton *scan;
    IBOutlet UIButton *scanInfo;
    IBOutlet UILabel *info;
    IBOutlet UISegmentedControl *segment;
    //Twitter params
    
    ACAccount *myAccount;
    NSMutableString *paramString;
    NSMutableArray *resultFollowersNameList;
    
    int currentMaxDisplayedCell;
    BOOL dataLoading;
    NSMutableArray *tweets;
    
    UIAlertView *loadingAlertView;
    NSMutableArray *fndname;
    
    //facebook
    
    int _pageNo;
    NSMutableArray *_friends;
    Facebook *_facebook;

}

@property(nonatomic,retain) ACAccount *myAccount;
@property(nonatomic, retain) NSMutableString *paramString;
@property(nonatomic, retain) NSMutableArray *resultFollowersNameList;
@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, strong) FBRequest*    reqFriendList;


- (IBAction)btnSegentEmailCliceked:(UISegmentedControl *)sender;
- (void)btnBackClicked:(id)sender;
-(void)sendInvitaionFormApp;
- (id)initWithFacebook:(Facebook*)fb;



@end
