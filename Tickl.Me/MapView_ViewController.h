//
//  MapView_ViewController.h
//  Tickl.Me
//
//  Created by Mountain on 2/2/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "CLLocationController.h"
#import "ConnectedClass.h"
#import "annotationsController.h"
#import "MyLocation.h"
#import "ASIHTTPRequest.h"

@interface MapView_ViewController : UIViewController <MKMapViewDelegate,ASIHTTPRequestDelegate>//CoreLocationControllerDelegate
{
    
    BOOL _doneInitialZoom;
    
    MKMapView *mapView;
    CLLocationController *CLController;
    NSMutableArray *lon;
    NSMutableArray *lat;
    NSMutableArray *annotationsarray;
    NSMutableArray *annImages;
    
    //Annotation from Events
    
    NSMutableArray *listOfPlaceName,*listOfLatitude,*listOfLongitude,*listOfCat,*listOfAddress,*listOfDesc;
    
    MyLocation *ml;
    
    NSMutableArray *arrTotalEvent;
    NSMutableArray *statuses;
    NSMutableArray *arrayToEvents;
    NSMutableArray *arrayToDesc;
    NSMutableArray *arrayToVenu;
    NSMutableArray *thmbImage;
    NSMutableArray *eventShedule;
    NSMutableArray *eventType;
    NSMutableArray *latitude,*longitude;
    NSMutableArray *venueAddress;
    NSMutableArray *description;
    NSMutableArray *locationValue;
    NSMutableArray *timeHr;
    NSMutableArray *cellImage;
    NSMutableArray *prices;
    
    

}

@property (retain, nonatomic) IBOutlet MKMapView *mapView;
@property (retain, nonatomic) NSMutableArray *lon;
@property (retain, nonatomic) NSMutableArray *lat;
@property (retain, nonatomic) NSMutableArray *listOfPlaceName;
@property (retain, nonatomic) NSMutableArray *listOfCat;
@property (retain,nonatomic) NSMutableArray *listOfAddress;
@property (retain,nonatomic) NSMutableArray *listOfDesc;
@property (nonatomic, strong) NSMutableArray *mapAnnotations;

- (IBAction)clickMore:(id)sender;
- (IBAction)clickLess:(id)sender;
- (IBAction)clickFilters:(id)sender;
- (void)clickMenu;
- (void)listViewButtonClicked:(UIButton *)sender;


@end
