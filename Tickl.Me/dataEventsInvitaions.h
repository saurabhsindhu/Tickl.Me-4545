//
//  dataEventsInvitaions.h
//  Tickl.Me
//
//  Created by Prakash Joshi on 5/6/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dataEventsInvitaions : NSObject
{
    NSString *EventId;
    NSString *eventName;
    NSString *eventDetails;
    NSString *eventInvitee;
    NSString *eventImage;
    NSString *eventStatus;
}

@property(nonatomic,retain) NSString *EventId;
@property(nonatomic,retain) NSString *eventName;
@property(nonatomic,retain) NSString *eventDetails;
@property(nonatomic,retain) NSString *eventInvitee;
@property(nonatomic,retain) NSString *eventImage;
@property(nonatomic,retain) NSString *eventStatus;

@end

