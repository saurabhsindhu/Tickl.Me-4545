//
//  ViewFriendListViewController.h
//  Tickl.Me
//
//  Created by Prakash Joshi on 4/18/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface ViewFriendListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate>
{
    IBOutlet UITableView *tblMyFriends;
    NSMutableArray *arrFriendList;
    NSMutableArray *arrayToid;
    NSMutableArray *arrayfn;
    NSMutableArray *arrayToln;
    NSMutableArray *thmbImage;
    NSMutableArray *emailId;
    NSMutableArray *statuses;
    NSMutableArray *arr,*array;
    
}
-(IBAction)MyProfile:(id)sender;
-(void)AddFriends:(id)sender;
@end
