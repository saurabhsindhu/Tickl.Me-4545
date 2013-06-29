//
//  SearchResultsViewController.h
//  Tickl.Me
//
//  Created by Prakash Joshi on 4/29/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface SearchResultsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *tableSearchResults;
    
    //array of data
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
    NSMutableArray *thumImages;
    
    NSMutableArray *time;
    NSMutableArray *venue;
    NSMutableArray *price;
    NSMutableArray *desc;
    NSMutableArray *address;
    NSMutableArray *city;
    NSMutableArray *state,*zip,*phone;
    NSMutableArray *udid;
    NSMutableArray *endtime;
    
    AsyncImageView *asyncImageView;
    
    NSString *strVal;
    
    
}

@property(nonatomic,retain)NSString *strVal;

- (void)backBtnClicked:(UIButton *)sender;


  @end
