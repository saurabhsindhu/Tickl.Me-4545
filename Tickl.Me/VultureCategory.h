//
//  VultureCategory.h
//  Tickl.Me
//
//  Created by Saurabh Sindhu on 6/11/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface VultureCategory : UIViewController<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate>
{
   
    IBOutlet UITableView *vultureTable;
    NSMutableArray *statuses;
    NSMutableArray *arrayToEvents;
    NSMutableArray *uid;
    int events;
    NSMutableArray *array;
    NSMutableArray *arr;
    
}

@end
