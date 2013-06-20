//
//  SettingViewController.h
//  Tickl.Me
//
//  Created by Saurabh Sindhu on 5/29/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    IBOutlet UITableView *tblView;
    NSMutableArray *arrtitleForHeader;
}

@end
