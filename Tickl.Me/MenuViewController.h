//
//  MenuViewController.h
//  Tickl.Me
//
//  Created by Mountain on 2/9/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,ASIHTTPRequestDelegate>{
    
    IBOutlet UIButton *button;
}

- (IBAction)clickSettings:(id)sender;
- (IBAction)clickSignout:(id)sender;

@property (nonatomic, retain) IBOutlet NSArray *lstTitles;
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end