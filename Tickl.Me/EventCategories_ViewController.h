//
//  EventCategories_ViewController.h
//  Tickl.Me
//
//  Created by Mountain on 2/4/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface EventCategories_ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate>
{
    NSMutableArray *arrCategoriesArray;
    NSMutableArray *arrCategoriesSelectionStatus;
    
    BOOL     isEditing;
    IBOutlet UITableView *tableSubCategories;
    
    NSMutableArray *thumbNail;
    
    NSMutableArray *statuses;
    NSMutableArray *arrayToEvents;
    NSMutableArray *thmbImage;
    NSMutableArray *uid;
    UISwitch *switchBtn;
    UILabel *lblEventName;
    UIImageView *imgEvent;
    NSMutableArray *array,*arr;
    
    BOOL switchOn;
    
}
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property BOOL switchOn;

- (IBAction)clickFilters:(id)sender;
- (void)clickEditBarButton:(id)sender;
- (IBAction)clickOnOff:(id)sender;


@end
