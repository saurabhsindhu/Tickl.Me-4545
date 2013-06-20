//
//  FAQ_ViewController.h
//  Tickl.Me
//
//  Created by Mountain on 2/22/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAQ_ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *strArray;
}
@property (retain, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)clickFAQ:(id)sender;

@end
