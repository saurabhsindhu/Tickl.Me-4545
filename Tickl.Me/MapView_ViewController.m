//
//  MapView_ViewController.m
//  Tickl.Me
//
//  Created by Mountain on 2/2/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "MapView_ViewController.h"
#import "CSMapAnnotation.h"
#import "AppDelegate.h"
#import "FindEvents_ViewController.h"
#import "DDMenuController.h"
#import "EventListViewViewController.h"
#import "SFAnnotation.h"
#import "EventsDetail.h"
#import "annotationsController.h"

typedef enum AnnotationIndex : NSUInteger
{
    kCityAnnotationIndex = 0,
    kBridgeAnnotationIndex,
    kTeaGardenAnnotationIndex
} AnnotationIndex;

@interface MapView_ViewController ()

@end

@implementation MapView_ViewController

@synthesize mapAnnotations,mapView;
@synthesize lon,lat,listOfCat,listOfPlaceName,listOfAddress,listOfDesc;

+ (CGFloat)annotationPadding;
{
    return 10.0f;
}

+ (CGFloat)calloutHeight;
{
    return 40.0f;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)gotoLocation
{
    
    [mapView removeAnnotations:mapView.annotations];
    
    
    annotationsarray=[[NSMutableArray alloc] init];
    
    NSLog(@"%d",[lat count]);
    NSLog(@"%d",[lon count]);
    NSLog(@"%d",[listOfPlaceName count]);
    
    
    /////// iterate here
    for (int i =0;i < [lat count]; i++) {
        MKCoordinateRegion region =  { {0.0, 0.0 }, { 0.0, 0.0 } };
        region.center.latitude = [[lat objectAtIndex:i] floatValue];
        region.center.longitude = [[lon objectAtIndex:i] floatValue];
        region.span.longitudeDelta = 5.0f;
        region.span.latitudeDelta = 5.0f;
        [self.mapView setRegion:region animated:YES];
        [self.mapView setZoomEnabled:YES];
        ml = [[MyLocation alloc]initWithName:[NSString stringWithFormat:@"%@",[listOfPlaceName objectAtIndex:i]] address:[NSString stringWithFormat:@"%@",[listOfAddress objectAtIndex:i]] coordinate:region.center];
        
//        ml.description = [NSString stringWithFormat:@"%@",[listOfDesc objectAtIndex:i]];
//        
//        NSLog(@"DESCR...%@",ml.description);
        
        ml.nTag = i;
        
        [self.mapView addAnnotation:ml];
        [annotationsarray addObject:ml];
        
    }

}




-(void)viewWillAppear:(BOOL)animated
{
    [self checkForConnection];
    [super viewWillAppear:YES];
    
}

-(void)checkForConnection {
    ConnectedClass *connection = [[ConnectedClass alloc] init];
    
    if ([connection connected] == NO) {
        UIAlertView *alertDialog = [[UIAlertView alloc] initWithTitle:@"Internet Connection" message:@"This application requires an internet connection to work properly. Please activate either a WiFi or a cellular data connection." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertDialog show];
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    annotationsarray=[[NSMutableArray alloc] init];
    listOfDesc = [[NSMutableArray alloc]init];
    //lat = [[NSMutableArray alloc]init];
    //lon = [[NSMutableArray alloc]init];
    
    annImages = [[NSMutableArray alloc]initWithObjects:@"Blue-Pin_Added-a-Friend.png",@"Blue-Pin_Added-to-My-Calendar.png",@"Blue-Pin_Art.png",@"Blue-Pin_Comedy.png",@"Blue-Pin_Dance.png",@"Blue-Pin_Event-Categories.png",@"Blue-Pin_Event-Check-in.png",@"Blue-Pin_Family-Friendly.png",@"Blue-Pin_Favorites.png",nil];

    
   // NSLog(@"Latitude %@ Longitude %@",lat,lon);
    

    self.view.frame=CGRectMake(0, 0, 320, 480);
    self.title=@"Map View";
    
    UIBarButtonItem *rightBarButton =[[UIBarButtonItem alloc] initWithTitle:@"List" style:UIBarButtonItemStyleDone target:self action:@selector(listViewButtonClicked:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
   
    UIButton *customMenuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customMenuBtn.frame = CGRectMake(10, 7.5, 30, 30);
    [customMenuBtn addTarget:self action:@selector(clickMenu) forControlEvents:UIControlEventTouchUpInside];
    [customMenuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [customMenuBtn setImage:[UIImage imageNamed:@"nav_menu_icon.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *leftBarButton =[[UIBarButtonItem alloc] initWithCustomView:customMenuBtn];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    // create out annotations array (in this example only 3)
    self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:2];
    
    // annotation for the City of San Francisco
    
    SFAnnotation *sfAnnotation = [[SFAnnotation alloc] init];
    [self.mapAnnotations insertObject:sfAnnotation atIndex:kCityAnnotationIndex];
    
    //CLLocationController comes here...
    
    CLController = [[CLLocationController alloc] init];
    CLController.delegate = self;
   
    [self gotoLocation];    // finally goto San Francisco
    
}


- (IBAction)clickMore:(id)sender {
    
    
}

- (IBAction)clickLess:(id)sender {
}

- (IBAction)clickFilters:(id)sender {
    
}

- (void)clickMenu {
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDelegate showMenu];

}

- (void)listViewButtonClicked:(UIButton *)sender {
      EventListViewViewController *eventList=[[EventListViewViewController alloc]initWithNibName:@"EventListViewViewController" bundle:nil];
    [[self navigationController]pushViewController:eventList animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MKMapDelegate

// user tapped the disclosure button in the callout
//
#pragma mark - MKMapViewDelegate

// user tapped the disclosure button in the callout
//
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    // here we illustrate how to detect which annotation type was clicked on for its callout
//    id <MKAnnotation> annotation = [view annotation];
//    if ([annotation isKindOfClass:[BridgeAnnotation class]])
//    {
//        NSLog(@"clicked Golden Gate Bridge annotation");
//    }

    EventsDetail *eventDet = [[EventsDetail alloc]initWithNibName:@"EventsDetail" bundle:nil];
    
    eventDet.xX = [NSString stringWithFormat:@"%@",[lat objectAtIndex:ml.nTag]];
    eventDet.yY = [NSString stringWithFormat:@"%@",[lon objectAtIndex:ml.nTag]];
    
    //NSLog(@"X%@Y%@",str1,str2);
    
    [self.navigationController pushViewController:eventDet animated:YES];
    
    
}

#pragma mark CoreLocDele -

-(void)locationUpdate:(CLLocation *)location {
    if (location.horizontalAccuracy >= 0) {
        NSArray *annotationsArray = [NSArray arrayWithArray:[mapView annotations]];
        MKCoordinateRegion mapRegion;
        
        // [addDisplayLocationButton setEnabled:TRUE];
        
        mapRegion.center = location.coordinate;
        mapRegion.span.latitudeDelta = 1;
        mapRegion.span.longitudeDelta = 1;
        
        [mapView setRegion:mapRegion animated:YES];
        
        [mapView addAnnotation:[[annotationsController alloc] initWithTitle:@"This is me" subtitle:@"Current Loc" coordinate:location.coordinate]];
        if ([annotationsArray count] > 0) {
            [mapView removeAnnotations:annotationsArray];
            //}
            [CLController.locMgr stopUpdatingLocation];
           
        }
    }
}

#pragma mark Annotation Delegate -


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[MyLocation class]]) {
        
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            } else {
                annotationView.annotation = annotation;
                }
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        
        NSString *strCat = [NSString stringWithFormat:@"%@",listOfCat];
        
        //NSLog(@"<Category>%@",strCat);

        
        if (ml.nTag==0||ml.nTag==2||ml.nTag==3) {
            
            annotationView.image=[UIImage imageNamed:@"Orange-Pin_Music.png"];
            
        }
        if (ml.nTag==4||ml.nTag==11||ml.nTag==16){
            
            annotationView.image=[UIImage imageNamed:@"Ornage-Pin_Art.png"];//here we use a nice image instead of the default pins
            }
        
        if (ml.nTag==5||ml.nTag==7||ml.nTag==8||ml.nTag==9||ml.nTag==10||ml.nTag==12||ml.nTag==14||ml.nTag==15){
            
            annotationView.image=[UIImage imageNamed:@"Orange-Pin_Special-Events.png"];//here we use a nice image instead of the default pins
            }
        
        if (ml.nTag==6||ml.nTag==13){
            
            annotationView.image=[UIImage imageNamed:@"Orange-Pin_Sports.png"];//here we use a nice image instead of the default pins
            }
        
                
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        annotationView.rightCalloutAccessoryView = rightButton;

        
           return annotationView;
        
       }
    
    return nil;    
}




//- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
//{
//    
////    MKPinAnnotationView *pinDrop = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"current"];
////   
////    //if (pinDrop == nil) {
////        pinDrop = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"current"];
////        pinDrop.pinColor = MKPinAnnotationColorPurple;
////        pinDrop.canShowCallout = YES;
////        pinDrop.animatesDrop = NO;
//   
//   // } else {
//   //     pinDrop.annotation = annotation;
//   // }
//   // return pinDrop;
//
//    // in case it's the user location, we already have an annotation, so just return nil
//    if ([annotation isKindOfClass:[MKUserLocation class]])
//    {
//        return nil;
//    }
//    
//        else if ([annotation isKindOfClass:[SFAnnotation class]])   // for City of San Francisco
//    {
//        static NSString *SFAnnotationIdentifier = @"SFAnnotationIdentifier";
//        
//        MKAnnotationView *flagAnnotationView =
//        [self.mapView dequeueReusableAnnotationViewWithIdentifier:SFAnnotationIdentifier];
//        if (flagAnnotationView == nil)
//        {
//            MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
//                                                                            reuseIdentifier:SFAnnotationIdentifier];
//            annotationView.canShowCallout = YES;
//            
//            UIImage *flagImage = [UIImage imageNamed:@"Blue-Pin_Added-a-Friend.png"];
//            
//            // size the flag down to the appropriate size
//            CGRect resizeRect;
//            resizeRect.size = flagImage.size;
//            CGSize maxSize = CGRectInset(self.view.bounds,
//                                         [MapView_ViewController annotationPadding],
//                                         [MapView_ViewController annotationPadding]).size;
//            maxSize.height -= self.navigationController.navigationBar.frame.size.height + [MapView_ViewController calloutHeight];
//            if (resizeRect.size.width > maxSize.width)
//                resizeRect.size = CGSizeMake(maxSize.width, resizeRect.size.height / resizeRect.size.width * maxSize.width);
//            if (resizeRect.size.height > maxSize.height)
//                resizeRect.size = CGSizeMake(resizeRect.size.width / resizeRect.size.height * maxSize.height, maxSize.height);
//            
//            resizeRect.origin = CGPointMake(0.0, 0.0);
//            UIGraphicsBeginImageContext(resizeRect.size);
//            [flagImage drawInRect:resizeRect];
//            UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsEndImageContext();
//            
//            annotationView.image = resizedImage;
//            annotationView.opaque = NO;
//            
//            UIImageView *sfIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SFIcon.png"]];
//            annotationView.leftCalloutAccessoryView = sfIconView;
//            
//            // offset the flag annotation so that the flag pole rests on the map coordinate
//            annotationView.centerOffset = CGPointMake( annotationView.centerOffset.x + annotationView.image.size.width/2, annotationView.centerOffset.y - annotationView.image.size.height/2 );
//            
//            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//            [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
//            annotationView.rightCalloutAccessoryView = rightButton;
//            
//            return annotationView;
//        }
//        else
//        {
//            flagAnnotationView.annotation = annotation;
//        }
//        return flagAnnotationView;
//    }
//    //    else if ([annotation isKindOfClass:[CustomMapItem class]])  // for Japanese Tea Garden
//    //    {
//    //        static NSString *TeaGardenAnnotationIdentifier = @"TeaGardenAnnotationIdentifier";
//    //
//    //        CustomAnnotationView *annotationView =
//    //        (CustomAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:TeaGardenAnnotationIdentifier];
//    //        if (annotationView == nil)
//    //        {
//    //            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:TeaGardenAnnotationIdentifier];
//    //        }
//    //        return annotationView;
//    //    }
//    
//    return nil;
//}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
   
    NSLog(@"KHJF");
    
}


@end
