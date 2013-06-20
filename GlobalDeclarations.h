//
//  GlobalDeclarations.h
//  SocialMediaApp
//
//  Created by Prakash Joshi on 8/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//#define httpUrlPort "http://108.168.203.226:8044/"
//
////login and signup
//#define WSrequestLogin httpUrlPort"Services/login"
//#define WSsignUp httpUrlPort"Services/signup"
//#define WSsecureQuestions httpUrlPort"Services/question"



@interface GlobalDeclarations : NSObject
{
    NSString *currentUserId;
    NSString *currentUserFirstName;
    NSString *currentUserLastName;
    NSString *currentUserName;
    NSString *currentUserIamgeURL;
    
}

@property(nonatomic,strong) NSString *currentUserId;
@property(nonatomic,strong) NSString *currentUserFirstName;
@property(nonatomic,strong) NSString *currentUserLastName;
@property(nonatomic,strong) NSString *currentUserName;
@property(nonatomic,strong) NSString *currentUserIamgeURL;


+(GlobalDeclarations*) sharedInstance;
-(NSString *) getUserDefaultValueForKey:(NSString *)key;
-(void) setUserDefaultValueForKey:(NSString*)value forKey:(NSString*)key;

@end
