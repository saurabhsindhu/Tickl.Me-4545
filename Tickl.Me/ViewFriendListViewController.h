//
//  ViewFriendListViewController.h
//  Tickl.Me
//
//  Created by Prakash Joshi on 4/18/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewFriendListViewController : UIViewController
{
    IBOutlet UITableView *tblMyFriends;
    NSMutableArray *arrFriendList;
}
-(IBAction)MyProfile:(id)sender;
-(void)AddFriends:(id)sender;
@end
