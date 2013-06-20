//
//  MyEvents_ViewController.h
//  Tickl.Me
//
//  Created by Mountain on 2/8/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataMyEvent.h"
@interface MyEvents_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *tblMyEvents;
    NSMutableArray *arrFriendList;
    IBOutlet UIButton *btnEdit;
   DataMyEvent *objMyEvent;
    NSMutableArray *arrTotalEvent;

}
- (IBAction)clickAddToCalendar:(id)sender;
- (IBAction)clickToday:(id)sender;
- (void)backBtnClicked;
- (void)clickEdit:(id)sender;

@end
