//
//  PeoplelikeMeViewController.h
//  Tickl.Me
//
//  Created by Saurabh Sindhu on 7/1/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ASIHTTPRequest.h"

@interface PeoplelikeMeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate>{
    
    IBOutlet UITableView *peopleTable;
    NSMutableArray *statuses;
    NSMutableArray *arrayToEvents;
    NSMutableArray *uid;
    int events;
    NSMutableArray *array;
    NSMutableArray *arr;
    
    
}

@end
