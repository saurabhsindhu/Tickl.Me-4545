//
//  GlobalDeclarations.m
//  SocialMediaApp
//
//  Created by Prakash Joshi on 8/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GlobalDeclarations.h"


static GlobalDeclarations *shareInstance = nil;
@implementation GlobalDeclarations

@synthesize currentUserId;
@synthesize currentUserFirstName;
@synthesize currentUserLastName;
@synthesize currentUserName;
@synthesize currentUserIamgeURL;

+ (GlobalDeclarations*)sharedInstance
{
    @synchronized(self) 
	{
        if (shareInstance == nil) 
		{
            shareInstance = [[self alloc] init];
		}
    }
	
    return shareInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self) 
	{
        if (shareInstance == nil) 
		{
            shareInstance = [super allocWithZone:zone];
			
            return shareInstance; // assignment and return on first allocation
        }
    }
    return nil; //on subsequent allocation attempts return nil
}


-(NSString *) getUserDefaultValueForKey:(NSString *)key
{
    
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    NSString *returnVal = (NSString *) [defs objectForKey:key];
    if (returnVal) 
    {
        return returnVal;
    }
    else 
    {
        return nil;
    }
    
}

-(void) setUserDefaultValueForKey:(NSString*)value forKey:(NSString*)key
{
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    [defs setObject:value forKey:key];
}


@end
