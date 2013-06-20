//
//  dataFriendRequests.h
//  Tickl.Me
//
//  Created by Prakash Joshi on 5/6/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dataFriendRequests : NSObject
{
    NSString *friendId;
    NSString *name;
    NSString *email;
    NSString * phone;
    NSString *image;
    NSString *status;
}
@property(nonatomic,retain) NSString *friendId;
@property(nonatomic,retain)NSString *name;
@property(nonatomic,retain)NSString *email;
@property(nonatomic,retain)NSString * phone;
@property(nonatomic,retain)NSString *image;
@property(nonatomic,retain)NSString *status;
@end
