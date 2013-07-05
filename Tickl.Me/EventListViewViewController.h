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
#import <MapKit/MapKit.h>

@interface EventListViewViewController : UIViewController<CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate>
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
    NSMutableArray *locationValue;
    NSMutableArray *minTime,*hourTime;
    NSMutableArray *cellImage;
    
    AsyncImageView *asyncImageView;
    
    
    CLLocationManager *locationManager;
    
    CLLocation *currentLocation;
    
    float currentLat;
    
    float currentLong;
    
    NSMutableArray *imagArray;
    
}
- (IBAction)btnBackClicked:(UIButton *)sender;
@end
