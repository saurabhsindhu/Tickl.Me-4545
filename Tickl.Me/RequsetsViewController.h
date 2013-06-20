//
//  RequsetsViewController.h
//  Tickl.Me
//
//  Created by Saurabh Sindhu on 5/24/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequsetsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

{
    
    IBOutlet UITableView *reqTable;
    NSMutableArray *arrayList;
    NSMutableArray *arrayList2;
}

@end
