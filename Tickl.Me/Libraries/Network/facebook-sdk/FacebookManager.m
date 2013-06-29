//
//  FacebookManager.m
//  aspire
//
//  Created by Satyadev Sain on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FacebookManager.h"
#import "FBFriend.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"

static NSString* kAppId =@"446436425445989";// @"377008632371045";

//static NSString* kAppSecretKey = @"8622d599be317a22f3ee03a1e33a81b7";

NSString* const kFacebookUpdateSuccessNotificationName = @"FacebookUpdateSuccessful";
NSString* const kFacebookUpdateFailureNotificationName = @"FacebookUpdateFailed";
static FacebookManager *sharedInstance = nil;

@interface FacebookManager ()

@end

@implementation FacebookManager
@synthesize appID=_appID;
@synthesize delegate=delegate_;
@synthesize facebook=facebook_;
@synthesize reqFriendList;
@synthesize reqMyInfo;
@synthesize reqMyLike;
@synthesize myFriends = _myFriends;
@synthesize myLikes = _myLikes;
@synthesize gameLikes = _gameLikes;
@synthesize myFriendsAndScores = _myFriendsAndScores;
@synthesize mySortedFriendsAndScores = _mySortedFriendsAndScores;
@synthesize pageIdToName = _pageIdToName;
@synthesize doneProcessing = _doneProcessing;
@synthesize highestCompatScore = _highestCompatScore;
@synthesize topFbPics = _topFbPics;
@synthesize responseString;


+ (FacebookManager *)sharedInstance {
    if (!sharedInstance) {
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

- (id) init {
    
    if (!kAppId) {
        NSLog(@"missing app id!");
        exit(1);
        return nil;
    }
    
    if ((self = [super init])) {
        permissions_ =  [NSArray arrayWithObjects:@"email",@"publish_stream",@"user_events",@"rsvp_event",@"create_event",@"read_page_mailboxes",@"read_friendlists",@"read_insights",@"read_requests",@"read_stream",@"read_mailbox",@"manage_friendlists",@"friends_events",@"friends_activities",@"friends_actions.news",@"friends_likes",@"friends_notes",@"user_activities",@"publish_actions",@"user_actions.news",@"user_likes",@"user_work_history",nil];
        facebook_ = [[Facebook alloc] initWithAppId:kAppId
                                        andDelegate:self];
        _appID=kAppId;
        
        newArr = [[NSMutableArray alloc]init];
        

    }
    return self;
}

- (void)authorize
{
    [facebook_ authorize:permissions_];
}

- (void)authorizeWithAccessToken:(NSString *)accessToken expirationDate:(NSDate *)expirationDate
{
    facebook_.accessToken = accessToken;
    facebook_.expirationDate = expirationDate;
    
    if (!facebook_.isSessionValid)
    {
        [facebook_ authorize:permissions_];
    }
    else
        [self fbDidLogin];
}

#pragma mark - Getters & Setters
- (NSMutableDictionary*)myFriends {
    if (!_myFriends) {
        _myFriends = [[NSMutableDictionary alloc] init];
    }
    
    return _myFriends;
}

- (NSMutableSet*)myLikes {
    if (!_myLikes) {
        //        _myLikes = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
        //                        [[NSMutableSet alloc] init], @"Music",              // Musician/band
        //                        [[NSMutableSet alloc] init], @"MoviesAndTv",        // Movie, Tv show, Tv channel, Tv network
        //                        [[NSMutableSet alloc] init], @"Books",              // Book
        //                        nil];
        _myLikes = [[NSMutableSet alloc] init];
    }
    
    return _myLikes;
}

- (NSMutableArray*)myFriendsAndScores {
    if (!_myFriendsAndScores) {
        _myFriendsAndScores = [[NSMutableArray alloc] init];
    }
    
    return _myFriendsAndScores;
}

- (NSArray*)mySortedFriendsAndScores {
    if (!_mySortedFriendsAndScores) {
        _mySortedFriendsAndScores = [[NSArray alloc] init];
    }
    
    return _mySortedFriendsAndScores;
}

- (void)setMySortedFriendsAndScores:(NSArray *)mySortedFriendsAndScores {
    _mySortedFriendsAndScores = mySortedFriendsAndScores;
    //    [self.tableView reloadData];
    //    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (NSMutableDictionary*)pageIdToName {
    if (!_pageIdToName) {
        _pageIdToName = [[NSMutableDictionary alloc] init];
    }
    
    return _pageIdToName;
}

- (NSMutableDictionary*)topFbPics {
    if (!_topFbPics) {
        _topFbPics = [[NSMutableDictionary alloc] init];
    }
    
    return _topFbPics;
}


- (void)postMessage:(NSString *)message {
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:message,@"message",@"Test it!",@"name",nil];
    [facebook_ requestWithGraphPath:@"me/feed"  andParams:params andHttpMethod:@"POST" andDelegate:self];
}

-(void)getPostedData{
    
    [facebook_ requestWithGraphPath:@"me/feed" andDelegate:self];
    
    NSString *postId = [permissions_ objectAtIndex:11];
    NSString *request = [NSString stringWithFormat:@"%@/comments" ,postId];
    [facebook_ requestWithGraphPath:request andDelegate:self];
    
}

- (void)postMessage:(NSString *)message andCaption:(NSString *)caption andImage:(UIImage *)image
{
    NSMutableDictionary *args = [[NSMutableDictionary alloc] init];
    [args setObject:caption forKey:@"caption"];
    [args setObject:message forKey:@"message"];
    [args setObject:UIImageJPEGRepresentation(image, 0.7) forKey:@"picture"];
    
    [facebook_ requestWithMethodName:@"photos.upload" andParams:args andHttpMethod:@"POST" andDelegate:self];
}

-(void) getFriends{
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"name,id,picture,installed", @"fields", nil];
    @autoreleasepool {
        self.reqFriendList = [facebook_ requestWithGraphPath:@"me/friends" andParams:params andDelegate:self];
        //[facebook_ requestWithGraphPath:@"me/friends" andDelegate: self ];
    }
}

-(void) getMyInfo
{
    
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"myLikesRequest", @"requestType", nil];
    
    
    self.reqMyInfo = [facebook_ requestWithGraphPath:@"me/likes" andParams:params andDelegate:self];
    
    
    NSMutableDictionary* params1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"meRequest",@"requestType", nil];
    
    self.reqMyLike = [facebook_ requestWithGraphPath:@"me" andParams:params1 andDelegate:self];
    
    [params1 objectForKey:@"email"];
    
//    [params1 objectForKey:@"picture"];
    
    NSLog(@"%@",[params1 objectForKey:@"picture"]);
    
    
    
    
    
}
- (void)logout
{
    [facebook_ logout: self];
}

- (void)inviteFriendtoApp: (FBFriend*) friend
{
    NSMutableDictionary *variables = [NSMutableDictionary dictionaryWithCapacity:4];
    [variables setObject:[NSString stringWithFormat:@"Hej!"
                          "Hej! Jeg har tilføjet dig som ven på Blå Mandag App. Tjek www.blåmandag.dk og download nu!"] forKey:@"message"];
    //    [variables setObject:@"url" forKey:@"picture"];
    [variables setObject:@"Hello" forKey:@"name"];
    [variables setObject:@"Description" forKey:@"description"];
    
    [facebook_ requestWithGraphPath: [NSString stringWithFormat:@"/%@/feed", friend.fbId]
                          andParams: variables
                      andHttpMethod:@"POST"
                        andDelegate:self];
}


-(void) processMyInfoQuery: (id) result
{
    NSLog(@"MyInfo - %@", result);
    [self.delegate myInfoLoaded: result];
}

- (void) processFriendsQuery:(id) result{
    NSLog(@"Friend List - %@", result);
    NSMutableArray* users = [NSMutableArray new];
    if([result isKindOfClass:[NSDictionary class]])
    {
        result = [result objectForKey: @"data"];
        if ([result isKindOfClass:[NSArray class]])
        {
            for(int i=0; i<[result count]; i++){
                FBFriend* friend = [FBFriend new];
                NSDictionary *userInfo = [result objectAtIndex:i];
                friend.fbId = [userInfo objectForKey:@"id"];
                friend.fbName = [userInfo objectForKey:@"name"];
                friend.fbPicture = [[[userInfo objectForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"];
                friend.bUsingApp = [[userInfo objectForKey:@"installed"] intValue];
                [users addObject: friend];
            }
        }
    }
    facebook_.friendsList = users;
    [self.delegate friendsListLoaded: users];
}

#pragma mark Facebook login delegates
- (void)fbDidLogin {
    if ([delegate_ respondsToSelector:@selector(facebookLoginSucceeded)]) {
        [delegate_ facebookLoginSucceeded];
    }
}

-(void)fbDidNotLogin:(BOOL)cancelled {
    sharedInstance = nil;
    if ([delegate_ respondsToSelector:@selector(facebookLoginFailed)]) {
        [delegate_ facebookLoginFailed];
    }
}

-(void)fbDidLogout {
    sharedInstance = nil;
    if ([delegate_ respondsToSelector:@selector(facebookloggedout)]) {
        [delegate_ facebookloggedout];
    }
}

- (void)fbDidExtendToken:(NSString*)accessToken
               expiresAt:(NSDate*)expiresAt
{
    
}

- (void)fbSessionInvalidated
{
    
}

#pragma mark facebook delegate methods

/**
 * FBRequestDelegate
 */

//- (void)request:(FBRequest *)request didLoad:(id)result {
//    if (request == self.reqFriendList) {
//        [self processFriendsQuery: result];
//    }
//    else if (request == self.reqMyInfo){
//        [self processMyInfoQuery: result];
//    }
//    else {
//        [self.delegate messagePostedSuccessfully];
//    }
//}

- (void)getLikes{
    
    @autoreleasepool {
        NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"name,id,picture,gender,email,first_name,last_name,favorite_teams,favorite_athletes", @"fields", nil];
        
        self.reqMyLike = [facebook_ requestWithGraphPath:@"me" andParams:params andDelegate:self];
        
        [params objectForKey:@"email"];
        
        // NSLog(@"%@ %@",self.reqMyInfo,[params objectForKey:@"email"]);
        
        
    }
}

- (void)request:(FBRequest *)request didLoad:(id)result {
    
 
    if (request == self.reqFriendList) {
        [self processFriendsQuery: result];
    }
    
    else {

    
    NSString *requestType = [request.params objectForKey:@"requestType"];
    
    if ([requestType isEqualToString:@"meRequest"]) {
        NSLog(@"did load me request");
        
    } else if ([requestType isEqualToString:@"myLikesRequest"]) {
        
        NSLog(@"did load my likes request");
        
    
//         NSLog(@"%@",result);
        
        data = [result objectForKey:@"data"];
        
        /* FQL
         for (NSDictionary *pageID in data) {
         [self.myLikes addObject:[pageID objectForKey:@"page_id"]];
         }
         */
        for (NSDictionary *myLike in data) { //Tv show;Tv channel;Tv network;Book;Movie;Musician/band
            NSString *currentCategory = [myLike objectForKey:@"category"];
            
            if ([currentCategory isEqualToString:@"Musician/band"]||[currentCategory isEqualToString:@"Tv show"]||[currentCategory isEqualToString:@"Tv channel"]||[currentCategory isEqualToString:@"Tv network"]||[currentCategory isEqualToString:@"Book"]||[currentCategory isEqualToString:@"Movie"]||[currentCategory isEqualToString:@"Sports"]||[currentCategory isEqualToString:@"Athelte"]) {
                [self.pageIdToName setObject:[myLike objectForKey:@"category"] forKey:[myLike objectForKey:@"name"]];
                
                NSLog(@"%@",self.pageIdToName);
                
                [self.myLikes addObject:[myLike objectForKey:@"name"]];
                NSLog(@"%@%@",myLike,self.myLikes);

                
                arPer = [self.myLikes allObjects];
                
                
            }
            
            else if ([currentCategory isEqualToString:@"Sports"]||[currentCategory isEqualToString:@"Athelte"]){
                
                [self.gameLikes addObject:[myLike objectForKey:@"name"]];
                NSLog(@"%@%@",myLike,self.gameLikes);
                
                
                arSports = [self.gameLikes allObjects];

                
            }
        }
        
        
        
    
        
    } else if ([requestType isEqualToString:@"name"]) {
        // loop through all results and store in myFriends dictionary
        data = [result objectForKey:@"data"];
        
        NSMutableString *friendsIDs = [[NSMutableString alloc] init];
        int friendCounter = 0;
        // loop through friends and concat IDs to params
        for (NSDictionary *friend in data) {
            friendCounter++;
            [self.myFriends setObject:[friend objectForKey:@"name"] forKey:[friend objectForKey:@"id"]];
            
            if (friendCounter == 500) {
                NSLog(@"retrieving 500 friends' likes");
                [friendsIDs appendFormat:@"%@", [friend objectForKey:@"id"]];
                NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:friendsIDs, @"ids", @"myFriendsLikesRequest", @"requestType", nil];
                
                [facebook_ requestWithGraphPath:@"likes" andParams:params andDelegate:self];
                friendCounter = 0;
                [friendsIDs setString:@""];
            } else {
                [friendsIDs appendFormat:@"%@,", [friend objectForKey:@"id"]];
                
            }
        }
        
        // take care of last group of friends
        if ([friendsIDs length] > 0) {
            // if last character is a comma, remove it
            if ([[friendsIDs substringFromIndex:[friendsIDs length] - 1] isEqualToString:@","]) {
                [friendsIDs setString:[friendsIDs substringToIndex:[friendsIDs length] -1]];
                self.doneProcessing = YES;
            }
        }
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:friendsIDs, @"ids", @"myFriendsLikesRequest", @"requestType", nil];
        //        //  NSLog(@"%@", friendsIDs);
        [facebook_ requestWithGraphPath:@"likes" andParams:params andDelegate:self];
        
        //        NSLog(@"friends: %@", self.myFriends);
    } else if ([requestType isEqualToString:@"myFriendsLikesRequest"]) {
        NSLog(@"did load friends likes request");
        
               
        for (NSString* friendID in [result allKeys]) {
            RFriend *currentFriend = [[RFriend alloc] init];
            currentFriend.friendID = friendID;
            currentFriend.name = [self.myFriends objectForKey:friendID];
            currentFriend.compatScore = 0.0f;
            currentFriend.totalLikes = 0;
            currentFriend.sameLikes = 0;
            
            NSArray *friendLikes = [[result objectForKey:friendID] objectForKey:@"data"];
            for (NSDictionary *friendLike in friendLikes) {
                NSString *currentCategory = [friendLike objectForKey:@"category"];
                if ([currentCategory isEqualToString:@"Musician/band"] || [currentCategory isEqualToString:@"Movie"] || [currentCategory isEqualToString:@"Tv show"] || [currentCategory isEqualToString:@"Tv channel"] || [currentCategory isEqualToString:@"Tv network"] || [currentCategory isEqualToString:@"Book"]) {
                    currentFriend.totalLikes++;
                    if ([self.myLikes containsObject:[friendLike objectForKey:@"id"]]) {
                        // same like!
                        currentFriend.sameLikes++;
                        [currentFriend.commonLikes addObject:[friendLike objectForKey:@"id"]];
                    }
                }
            }
            
            currentFriend.compatScore = (currentFriend.sameLikes*2) / (float)(currentFriend.totalLikes + [self.myLikes count]);
            [self.myFriendsAndScores addObject:currentFriend];
            //            NSLog(@"%@: %i, %i, %f", currentFriend.name, currentFriend.sameLikes, currentFriend.totalLikes, currentFriend.compatScore);
        }
        
        NSArray *sortedArray = [self.myFriendsAndScores sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            float first = [(RFriend*)a compatScore];
            float second = [(RFriend*)b compatScore];
            
            return (first < second);
        }];
        
        self.doneProcessing = YES;
        self.highestCompatScore = [[sortedArray objectAtIndex:0] compatScore];
        self.mySortedFriendsAndScores = sortedArray;
        
        if (self.doneProcessing) {
            int topFriendCounter = 0;
            for (RFriend* topFriend in self.mySortedFriendsAndScores) {
                if (topFriendCounter < 10) {
                    // add picture to toppics
                    NSLog(@"top friedn FBID is :%@",topFriend.friendID);
                    [self.topFbPics setObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture",topFriend.friendID]]] forKey:topFriend.friendID];
                    topFriendCounter++;
                }
            }
            NSLog(@"top friend pics is %@",self.topFbPics);
            //[self.tableView reloadData];
        }
        
        NSLog(@"%@", sortedArray);
        
    }
    
    
    
    if ([result valueForKey:@"email"]) {
        
        NSMutableDictionary* hash = result;
        
        username = (NSString*)[hash valueForKey:@"id"];
        
        NSString *email = (NSString*)[hash valueForKey:@"email"];
        
        
        NSString *firstName = (NSString*)[hash valueForKey:@"first_name"];
        
        NSString *lastName = (NSString*)[hash valueForKey:@"last_name"];
        
        [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"Username"];
        
        [[NSUserDefaults standardUserDefaults] setObject:email forKey:@"EmailId"];
        
        [[NSUserDefaults standardUserDefaults] setObject:firstName forKey:@"first_name"];
        
        [[NSUserDefaults standardUserDefaults] setObject:lastName forKey:@"last_name"];
        
        //user picture...
        
        
        NSURL *urlPic = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?", username]];
        
        NSString *strURL = [NSString stringWithFormat:@"%@",urlPic];
        
        NSData *dataByte = [NSData dataWithContentsOfURL:urlPic];
        
       // NSDictionary *urlP = [NSDictionary dictionaryWithObject:urlPic forKey:@"URL"];
                              
        UIImage *profilePic = [[UIImage alloc] initWithData:dataByte];
        
        NSLog(@"%@",profilePic);
        
        //
        NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:firstName,@"first_name",lastName,@"last_name",email,@"email",username,@"id",strURL,@"URL", nil];
        
        NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://108.168.203.226:8123/users/getFacebookUser/"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
        NSDictionary* postDict = [NSDictionary dictionaryWithObjectsAndKeys:dict,@"User",nil];
        // NSDictionary* data = [NSDictionary dictionaryWithObject:postDict forKey:@"id"];
        NSString* jsonData = [postDict JSONRepresentation];
        NSData* postData = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
        [request appendPostData:postData];
        [request setDelegate:self];
        [request startAsynchronous];
        
        NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        destPath = [destPath stringByAppendingPathComponent:@"userid.plist"];
        
        // If the file doesn't exist in the Documents Folder, copy it.
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if (![fileManager fileExistsAtPath:destPath]) {
            NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"userid" ofType:@"plist"];
            [fileManager copyItemAtPath:sourcePath toPath:destPath error:nil];
        }
        
        NSMutableDictionary *arrValue = [[NSMutableDictionary alloc]init];
        
        [arrValue setObject:username forKey:@"facebook_id"];
        
        [arrValue writeToFile:destPath atomically:YES];

        
        
    }
    
    if (data != nil)
        
    {
        
    NSLog(@"%@",username);
        
    getResponse = YES;
    
    //NSMutableArray *allLike = [[NSMutableArray alloc]initWithObjects:data,arPer,arSports, nil];
    
    NSLog(@"<<<Likes>>>%@",data);
    
    
    NSDictionary* postDict = [NSDictionary dictionaryWithObjectsAndKeys:data,username,nil];
    
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://108.168.203.226:8123/categories/get_facebook_like/"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    ASIHTTPRequest* requestUrl = [ASIHTTPRequest requestWithURL:url];
    NSDictionary* data1 = [NSDictionary dictionaryWithObject:postDict forKey:@"fb_id"];
    NSString* jsonData = [data1 JSONRepresentation];
    NSData* postData = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
    [requestUrl appendPostData:postData];
    [requestUrl setDelegate:self];
    [requestUrl startAsynchronous];

    }
        
  }
}

#pragma mark ASIHTTPReq Delegate
- (void)requestStarted:(ASIHTTPRequest *)request{
    
    NSLog(@"requestStarted%@",request);
    
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    
    NSLog(@"requestFinished%@",request);
    
    if (getResponse==YES){
    
    responseString=[[request responseString]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSLog(@"Response %@",responseString);
        
    NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        destPath = [destPath stringByAppendingPathComponent:@"favorite.plist"];
        
        // If the file doesn't exist in the Documents Folder, copy it.
    NSFileManager *fileManager = [NSFileManager defaultManager];
        
    if (![fileManager fileExistsAtPath:destPath]) {
            NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"favorite" ofType:@"plist"];
            [fileManager copyItemAtPath:sourcePath toPath:destPath error:nil];
    }
        
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        
    [dict setObject:responseString forKey:@"favor"];
        
    [dict writeToFile:destPath atomically:YES];
        
    }
    
    
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    
    NSLog(@"requestFailed%@",request);
    
}

- (void)exchangeKey:(NSString *)aKey withKey:(NSString *)aNewKey inMutableDictionary:(NSMutableDictionary *)aDict
{
    if (![aKey isEqualToString:aNewKey]) {
        id objectToPreserve = [aDict objectForKey:aKey];
        [aDict setObject:objectToPreserve forKey:aNewKey];
        [aDict removeObjectForKey:aKey];
    }
}



- (void) messagePostedSuccessfully
{
    NSLog(@"hey!!");
}
- (void)request:(FBRequest*)request didFailWithError:(NSError*)error {
    if ([delegate_ respondsToSelector:@selector(requestFailed:)]) {
        [delegate_ requestFailed:error];
    }
    if ([delegate_ respondsToSelector:@selector(messagePostingFailedWithError:)]) {
        [delegate_ messagePostingFailedWithError:error];
    }
}

@end
