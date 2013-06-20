//
//  Filters_ViewController.h
//  Tickl.Me
//
//  Created by Mountain on 2/1/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Filters_ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *stringArray;
    IBOutlet UIView *assistanceView;
    IBOutlet UIButton *btnSkip;
    IBOutlet UITableView *tableViewFilters;
    
    NSMutableArray *thumbImage;
}
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIView *welcomeView;
- (void)clickNext:(id)sender;
- (IBAction)clickSkip:(id)sender;
- (IBAction)clickOK:(id)sender;
- (void)clickBack;

@end
