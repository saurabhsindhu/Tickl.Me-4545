//
//  FacebookManager.h
//  aspire
//
//  Created by Satyadev Sain on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBConnect.h"
#import "ASIHTTPRequest.h"
#import <QuartzCore/QuartzCore.h>
#import "Constants.h"
#import "CompatibilityCell.h"
#import "RFacebookLike.h"
#import "RFriend.h"
#import "MBProgressHUD.h"

#define FRIENDLIST_LOADED_NOTIFICATION      @"FriendlistLoaded"

@protocol FacebookManagerDelegate;


extern NSString* const kFacebookUpdateSuccessNotificationName;
extern NSString* const kFacebookUpdateFailureNotificationName;

@interface FacebookManager : NSObject<FBRequestDelegate,
FBDialogDelegate,
FBSessionDelegate> { //ASIHTTPRequestDelegate
    id<FacebookManagerDelegate>  delegate_;
    Facebook* facebook_;
    NSArray* permissions_;
    NSArray *performers, *sports;
    NSArray *arPer,*arSports;
    NSString *username;
    NSMutableArray *data;
    NSMutableArray *newArr;
    BOOL getResponse;
    NSString *responseString;
}

@property(nonatomic,retain) NSString *appID;
@property(nonatomic, strong) Facebook *facebook;
@property (nonatomic, strong) id<FacebookManagerDelegate> delegate;
@property (nonatomic, strong) FBRequest*    reqFriendList;
@property (nonatomic, strong) FBRequest*    reqMyInfo;
@property (nonatomic, strong) FBRequest*    reqMyLike;

@property (nonatomic, strong) NSMutableDictionary *myFriends;
//@property (nonatomic, strong) NSMutableDictionary *myLikes;
@property (nonatomic, strong) NSMutableSet *myLikes;
@property (nonatomic, strong) NSMutableSet *gameLikes;
@property (nonatomic, strong) NSMutableArray *myFriendsAndScores;
@property (nonatomic, strong) NSArray *mySortedFriendsAndScores;
@property (nonatomic, strong) NSMutableDictionary *pageIdToName;
@property BOOL doneProcessing;
@property float highestCompatScore;
@property (nonatomic, strong) NSMutableDictionary *topFbPics;
@property (nonatomic, strong)  NSString *responseString;

+ (FacebookManager *) sharedInstance;
- (void)postMessage:(NSString *)message;
- (void)postMessage:(NSString *)message andCaption:(NSString *)caption andImage:(UIImage *)image;
- (void)getFriends;
- (void)getMyInfo;
- (void)getLikes;
- (void)inviteFriendtoApp: (FBFriend*) friend;
- (void)logout;
- (void)authorize;
- (void)authorizeWithAccessToken:(NSString *)accessToken expirationDate:(NSDate *)expirationDate;
@end

@protocol FacebookManagerDelegate <NSObject>
- (void) facebookLoginSucceeded;
- (void) facebookLoginFailed;
@optional
- (void) facebookloggedout;
- (void) friendsListLoaded:(NSMutableArray*) array;
- (void) myInfoLoaded: (NSMutableDictionary*) myInfo;
- (void) requestFailed:(NSError*) error;
- (void) messagePostedSuccessfully;
- (void) messagePostingFailedWithError:(NSError *)error;

@end



