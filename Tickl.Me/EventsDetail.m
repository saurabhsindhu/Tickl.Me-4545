//
//  EventsDetail.m
//  Tickl.Me
//
//  Created by Saurabh Sindhu on 5/29/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "EventsDetail.h"
#import "CheckInView.h"
#define METERS_PER_MILE 1609

@interface EventsDetail ()

@end

@implementation EventsDetail
@synthesize eventsDescription;
@synthesize xX,yY;
@synthesize desc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"%f%f",[xX doubleValue],[yY doubleValue]);
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [xX doubleValue];
    zoomLocation.longitude= [yY doubleValue];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    // 3
    MKCoordinateRegion adjustedRegion = [self.mapView1 regionThatFits:viewRegion];
    // 4
    [self.mapView1 setRegion:adjustedRegion animated:YES];
    
    
    [super viewDidLoad];
    UILabel *lblEventSubDetails = [[UILabel alloc]initWithFrame :CGRectMake(25, 215, 280, 65)];
    lblEventSubDetails.font = [UIFont boldSystemFontOfSize:13];
    lblEventSubDetails.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
    lblEventSubDetails.tag =19;
    lblEventSubDetails.lineBreakMode = NSLineBreakByWordWrapping;
    lblEventSubDetails.numberOfLines = 0;
    lblEventSubDetails.backgroundColor = [UIColor whiteColor];
    lblEventSubDetails.text = desc;
    [self.view addSubview:lblEventSubDetails];
    
   
    
    // Label for Venue Detail
    UILabel *lblDet = [[UILabel alloc]initWithFrame :CGRectMake(25, 285, 280, 12)];
    lblDet.font = [UIFont boldSystemFontOfSize:13];
    lblDet.textColor =[UIColor darkGrayColor];
    lblDet.tag =13;
    lblDet.backgroundColor = [UIColor clearColor];
    lblDet.text = @"Venue Detail";
    [self.view addSubview:lblDet];

    
    
    UILabel *lblVenueDetails = [[UILabel alloc]initWithFrame:CGRectMake(25, 300, 280, 65)];
    lblVenueDetails.font = [UIFont boldSystemFontOfSize:13];
    lblVenueDetails.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
    lblVenueDetails.tag = 12;
    lblVenueDetails.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lblVenueDetails];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)checkIn:(id)sender{
   
    CheckInView *check = [[CheckInView alloc]initWithNibName:@"CheckInView" bundle:nil];
    
    [self.navigationController pushViewController:check animated:YES];
    
    
}

@end
