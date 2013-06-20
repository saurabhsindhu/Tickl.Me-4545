//
//  Friend.h
//  MyFaves
//
//  Created by lianbi on 7/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBFriend : NSObject

@property (nonatomic, strong) NSString* fbId;
@property (nonatomic, strong) NSString* fbName;
@property (nonatomic, strong) NSString* fbPicture;
@property (nonatomic, assign) BOOL      bUsingApp;
@property (nonatomic, assign) BOOL      bSelected; //This is the checked status for adding friend.
@property (nonatomic, strong) UIImage*  profilePhoto;

@end
