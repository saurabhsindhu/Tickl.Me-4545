//
//  Help_ViewController.h
//  Tickl.Me
//
//  Created by Mountain on 2/8/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Help_ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *questions;
    NSArray *abouttheapp;
}
@property (retain, nonatomic) IBOutlet UITableView *tableView;
- (void)clickBack;

@end
