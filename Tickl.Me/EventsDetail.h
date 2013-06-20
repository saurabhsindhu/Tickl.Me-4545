//
//  EventsDetail.h
//  Tickl.Me
//
//  Created by Saurabh Sindhu on 5/29/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "CLLocationController.h"

@interface EventsDetail : UIViewController{
    
    NSMutableArray *eventsDescription;
    NSString *xX;
    NSString *yY;
    
}

@property(nonatomic,retain)IBOutlet MKMapView *mapView1;

@property(nonatomic,retain)NSMutableArray *eventsDescription;
@property(nonatomic,retain)NSString *xX;
@property(nonatomic,retain)NSString *yY;

-(IBAction)checkIn:(id)sender;

@end

