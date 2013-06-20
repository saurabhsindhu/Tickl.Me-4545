//
//  MyFriends_ViewController.h
//  Tickl.Me
//
//  Created by Mountain on 2/4/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface MyFriends_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
NSMutableArray *arrFriendList;
IBOutlet UITableView *tblAddFriend;
}

- (void)clickAddFriends:(id)sender;
- (void)clickBack;

@end
