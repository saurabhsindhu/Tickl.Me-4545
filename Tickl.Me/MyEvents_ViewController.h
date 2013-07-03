//
//  MyEvents_ViewController.h
//  Tickl.Me
//
//  Created by Mountain on 2/8/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataMyEvent.h"
#import "ASIHTTPRequest.h"
#import "AsyncImageView.h"

@interface MyEvents_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ASIHTTPRequestDelegate>
{
    
    IBOutlet UITableView *tblMyEvents;
    NSMutableArray *arrFriendList;
    IBOutlet UIButton *btnEdit;
   DataMyEvent *objMyEvent;
    NSMutableArray *arrTotalEvent;
    NSMutableArray *statuses;
    NSMutableArray *arrayToEvents;
    NSMutableArray *arrayToVenu;
    NSMutableArray *thmbImage;
    NSMutableArray *eventShedule;
    NSMutableArray *venueAddress;
    AsyncImageView *asyncImageView;
    
    UIActivityIndicatorView *myActivityIndicator;

}
- (IBAction)clickAddToCalendar:(id)sender;
- (IBAction)clickToday:(id)sender;
- (void)backBtnClicked;
- (void)clickEdit:(id)sender;

@end
