//
//  FindEvents_ViewController.h
//  Tickl.Me
//
//  Created by Mountain on 2/4/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ASIHTTPRequest.h"

@class SelectDateViewController;

@interface FindEvents_ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,CLLocationManagerDelegate,ASIHTTPRequestDelegate,UISearchBarDelegate>
{
    
    SelectDateViewController *selDate;
    
    NSArray *stringArray;
    
    NSString *myString;
    
    IBOutlet UISlider *slide;
    
    CLLocationManager *locationManager;
    
    CLLocation *currentLocation;
    
    float currentLat;
    
    float currentLong;
    
    NSString *responseString;
    
    UISwitch *switchBtn;
    
    NSMutableString *startDate,*endDate;
    
    NSString *strVal,*endVal;
    
    
}

- (void)searchNewEvents:(UIButton *)sender;

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UISearchBar *searchBar;
@property (retain, nonatomic) SelectDateViewController *selDate;

- (IBAction)costRangeButtonClicked:(UISegmentedControl *)sender;

- (IBAction)clickSearch:(id)sender;
- (IBAction)clickFree:(id)sender;
- (IBAction)click149:(id)sender;
- (IBAction)click1_49:(id)sender;
- (IBAction)click50_99:(id)sender;
- (IBAction)click100:(id)sender;
- (void)backBtnClicked;
-(IBAction)sliderValue:(id)sender;

@end
