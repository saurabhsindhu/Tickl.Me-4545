//
//  Favorites_ViewController.h
//  Tickl.Me
//
//  Created by Mountain on 2/1/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dataPerformers.h"
#import "dataTeams.h"
#import "FacebookManager.h"
#import "ASIHTTPRequest.h"
#import "OverlayViewController.h"

@interface Favorites_ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate,ASIHTTPRequestDelegate,UISearchDisplayDelegate>
{
    NSMutableArray *suffixArray;
    IBOutlet UITableView *tableListView;
    NSMutableArray *arrPerformers;
    NSMutableArray *arrTeams;
    FacebookManager *fbMgr;
    
    dataPerformers *objPerformers;
    dataTeams *objTeams;
    IBOutlet UIButton *btnSkip;
    
    IBOutlet UISearchBar *searchTable;
    
    NSMutableArray *searchData;
    
    UISearchDisplayController *searchDisplayController;
    
    NSArray *array;
    
    NSArray *searchResults;
    
    NSMutableArray *statuses;
    
    NSMutableArray *arrayToMusic,*arrayToSports,*musicID,*sportsID;
    
    IBOutlet UIView *viewAssistance;
    
    //search
    
    NSMutableArray *copyListOfItems;
    BOOL searching;
	BOOL letUserSelectRow;
	
	OverlayViewController *ovController;
    
}
- (IBAction)topSegmentControllClicked:(UISegmentedControl*)sender;

@property (retain, nonatomic) IBOutlet UIView *welcomeView;
@property (retain, nonatomic) IBOutlet UITableView *tableView;


- (void)clickBack:(id)sender;
- (void)clickNext:(id)sender;
- (IBAction)clickSkip:(id)sender;
- (IBAction)clickOK:(id)sender;
- (IBAction)btnEditToolbarClicked:(UIButton *)sender;
- (void) doneSearching_Clicked:(id)sender;

@end
