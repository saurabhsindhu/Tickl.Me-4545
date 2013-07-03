//
//  SearchDetail.h
//  Tickl.Me
//
//  Created by Saurabh Sindhu on 6/24/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ASIHTTPRequest.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

@interface SearchDetail : UIViewController<UIActionSheetDelegate,CLLocationManagerDelegate,ASIHTTPRequestDelegate>{
    
    NSString *start_time,*venue_name,*prices,*description,*address;
    
    NSString *city,*zip,*phone,*lat,*longit,*udid,*endTime;
    
    IBOutlet UIScrollView *scroll;
    
    NSString *str1;
    
    double latit,longi;
    
    CLLocationManager *locationManager;
    
    CLLocation *currentLocation;
    
    float currentLat;
    
    float currentLong;
    
    CGSize expectedLabelSize;
    
    //Events come here...
    
    NSArray *events;
    
    EKEventViewController *detailViewController;
	EKEventStore *eventStore;
	EKCalendar *defaultCalendar;
	NSMutableArray *eventsList;
    
    BOOL getit;
   
    
}

@property (nonatomic,retain)NSString *start_time;
@property (nonatomic,retain)NSString *endTime;
@property (nonatomic,retain)NSString *venue_name;
@property (nonatomic,retain)NSString *prices;
@property (nonatomic,retain)NSString *description;
@property (nonatomic,retain)NSString *address;
@property (nonatomic,retain)NSString *city;
@property (nonatomic,retain)NSString *zip;
@property (nonatomic,retain)NSString *phone;
@property (nonatomic,retain)NSString *lat;
@property (nonatomic,retain)NSString *longit;
@property (nonatomic,retain)NSString *udid;

@property (nonatomic, retain) EKEventStore *eventStore;
@property (nonatomic, retain) EKCalendar *defaultCalendar;
@property (nonatomic, retain) NSMutableArray *eventsList;
@property (nonatomic, retain) EKEventViewController *detailViewController;

-(void)monthStr:(NSInteger)val;
-(void)resizeHeightToFitForLabel:(UILabel *)label withText:(NSString *)text;

@end
