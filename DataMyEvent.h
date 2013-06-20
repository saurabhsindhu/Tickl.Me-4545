//
//  DataMyEvent.h
//  Tickl.Me
//
//  Created by Chandra Mohan on 23/04/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataMyEvent : NSObject
{
    NSString *EventName;
    NSString *EventDateandTime;
    NSString *EventTitle;
    NSString *EventSubTitle;
    NSString *Dayimg;
}
@property(nonatomic,retain) NSString *EventName;
@property(nonatomic,retain) NSString *EventDateandTime;
@property(nonatomic,retain) NSString *EventTitle;
@property(nonatomic,retain) NSString *EventSubTitle;
@property(nonatomic,retain) NSString *Dayimg;

@end
