//
//  FriendRequestAndEvetnInVitaiaionViewController.h
//  Tickl.Me
//
//  Created by Prakash Joshi on 5/4/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendRequestAndEvetnInVitaiaionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
{
    IBOutlet UITableView *tableFriendRequests;
    IBOutlet UITableView *tableEventInvitation;
    IBOutlet UILabel *lblFriendReq;
    IBOutlet UILabel *lblEventInvitaions;
    
}
@end
