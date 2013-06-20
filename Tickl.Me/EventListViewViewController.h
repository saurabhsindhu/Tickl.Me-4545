//
//  EventListViewViewController.h
//  Tickl.Me
//
//  Created by Prakash Joshi on 4/30/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataMyEvent.h"
#import "AsyncImageView.h"

@interface EventListViewViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *thumImages;
    IBOutlet UITableView *tblMyEvents;
    NSMutableArray *arrFriendList;
    DataMyEvent *objMyEvent;
    NSMutableArray *arrTotalEvent;
    NSMutableArray *statuses;
    NSMutableArray *arrayToEvents;
    NSMutableArray *arrayToDesc;
    NSMutableArray *arrayToVenu;
    NSMutableArray *thmbImage;
    NSMutableArray *eventShedule;
    NSMutableArray *eventType;
    NSMutableArray *latitude,*longitude;
    NSMutableArray *venueAddress;
    NSMutableArray *description;
    
    AsyncImageView *asyncImageView;
}
- (IBAction)btnBackClicked:(UIButton *)sender;
@end
