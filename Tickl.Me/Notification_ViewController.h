//
//  Notification_ViewController.h
//  Tickl.Me
//
//  Created by Mountain on 2/1/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Notification_ViewController : UIViewController
{
    NSArray *pushStrs;
    NSArray *emailStrs;
    NSArray *socialStrs;
}
@property (retain, nonatomic) IBOutlet UITableView *tableView;
- (void)clickBack:(id)sender;
- (IBAction)clickSkip:(id)sender;
- (void)clickNext:(id)sender;

@end
