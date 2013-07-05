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
#import "JSON.h"
#import "ASIHTTPRequest.h"

static int count = 1;

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
    
    NSLog(@"%d",[latitude count]);
    NSLog(@"%d",[longitude count]);
    NSLog(@"%d",[listOfPlaceName count]);
    
    
    /////// iterate here
    for (int i =0;i < [latitude count]; i++) {
        MKCoordinateRegion region =  { {0.0, 0.0 }, { 0.0, 0.0 } };
        region.center.latitude = [[latitude objectAtIndex:i] floatValue];
        region.center.longitude = [[longitude objectAtIndex:i] floatValue];
        region.span.longitudeDelta = 0.1f;
        region.span.latitudeDelta = 0.1f;
        [self.mapView setRegion:region animated:YES];
        [self.mapView setZoomEnabled:YES];
             
        ml = [[MyLocation alloc]initWithName:[NSString stringWithFormat:@"%@",[arrayToVenu objectAtIndex:i]]  address:[NSString stringWithFormat:@"%@",[venueAddress objectAtIndex:i]] venuAddress:[NSString stringWithFormat:@"%@",[arrayToVenu objectAtIndex:i]] timeValue:[NSString stringWithFormat:@"%@",[timeHr objectAtIndex:i]] ticket:[NSString stringWithFormat:@"%@",[prices objectAtIndex:i]] coordinate:region.center];
//        ml.description = [NSString stringWithFormat:@"%@",[listOfDesc objectAtIndex:i]];

        
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

    

    self.view.frame=CGRectMake(0, 0, 320, 480);
    self.title=@"Map View";
    
    [self getArrayLists];
    
    UIButton *customMenuBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    customMenuBtn1.frame = CGRectMake(10, 7.5, 30, 30);
    [customMenuBtn1 addTarget:self action:@selector(listViewButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [customMenuBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [customMenuBtn1 setImage:[UIImage imageNamed:@"Done.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *rightBarButton =[[UIBarButtonItem alloc]initWithCustomView:customMenuBtn1];
    self.navigationItem.rightBarButtonItem = rightBarButton;
   
    UIButton *customMenuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customMenuBtn.frame = CGRectMake(10, 7.5, 30, 30);
    [customMenuBtn addTarget:self action:@selector(clickMenu) forControlEvents:UIControlEventTouchUpInside];
    [customMenuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [customMenuBtn setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *leftBarButton =[[UIBarButtonItem alloc] initWithCustomView:customMenuBtn];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    // create out annotations array (in this example only 3)
    self.mapAnnotations = [[NSMutableArray alloc] initWithCapacity:5];
    
    // annotation for the City of San Francisco
    
//    SFAnnotation *sfAnnotation = [[SFAnnotation alloc] init];
//    [self.mapAnnotations insertObject:sfAnnotation atIndex:kCityAnnotationIndex];
    
    //CLLocationController comes here...
    
    CLController = [[CLLocationController alloc] init];
    CLController.delegate = self;
   
    [self gotoLocation];    // finally goto San Francisco
    
}


-(void)getArrayLists{
    
    //url values
    
    arrayToEvents = [[NSMutableArray alloc]init];
    
    arrayToDesc = [[NSMutableArray alloc]init];
    
    arrayToVenu = [[NSMutableArray alloc]init];
    
    thmbImage = [[NSMutableArray alloc]init];
    
    eventShedule = [[NSMutableArray alloc]init];
    
    eventType = [[NSMutableArray alloc]init];
    
    longitude = [[NSMutableArray alloc]init];
    
    latitude = [[NSMutableArray alloc]init];
    
    venueAddress = [[NSMutableArray alloc]init];
    
    description = [[NSMutableArray alloc]init];
    
    locationValue = [[NSMutableArray alloc]init];
    
    timeHr = [[NSMutableArray alloc]init];
    
    cellImage = [[NSMutableArray alloc]init];
    
    prices = [[NSMutableArray alloc]init];
    
    //***********************JSON Value******************************//
    
    SBJSON *parser = [[SBJSON alloc]init];
    
       
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://108.168.203.226:8123/events/get_favorites_filter"]];
    
    // Perform request and get JSON back as a NSData object
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    // Get JSON as a NSString from NSData response
    NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    // parse the JSON response into an object
    // Here we're using NSArray since we're parsing an array of JSON status objects
    statuses = [parser objectWithString:json_string error:nil];
    
  
    // represented as a NSDictionary
    for (NSDictionary *status in statuses) {
        // You can retrieve individual values using objectForKey on the status NSDictionary
        
        [arrayToEvents addObject:[[status objectForKey:@"Event"]objectForKey:@"event_name"]];
        
        [prices addObject:[[status objectForKey:@"Event"]objectForKey:@"prices"]];
        
        [arrayToVenu addObject:[[status objectForKey:@"Venue"]objectForKey:@"venue_name"]];
        
        
        [eventShedule addObject:[[status objectForKey:@"EventSchedule"]objectForKey:@"start_time"]];
        
        [eventType addObject:[[status objectForKey:@"Event"]objectForKey:@"event_type"]];
        
        [longitude addObject:[[status objectForKey:@"Venue"]objectForKey:@"lon"]];
        
        [latitude addObject:[[status objectForKey:@"Venue"]objectForKey:@"lat"]];
        
        [venueAddress addObject:[[status objectForKey:@"Venue"]objectForKey:@"address"]];
        
        [description addObject:[[status objectForKey:@"Performer"]objectForKey:@"description"]];
        
        
        
    }
    
    
    for (int valTime = 0; valTime<[arrayToEvents count]; valTime++) {
        
        
        NSArray *subString = [[eventShedule objectAtIndex:valTime] componentsSeparatedByString:@" "];
        
        NSString *thirdValue1 = [subString objectAtIndex:1];
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"HH:mm:ss";
        NSDate *date = [dateFormatter dateFromString:thirdValue1];
        
        dateFormatter.dateFormat = @"hh:mm:ss a";
        NSString *pmamDateString = [dateFormatter stringFromDate:date];
        
        NSLog(@"%@",pmamDateString);
        
        [timeHr addObject:pmamDateString];
        
        
    }
    
  
    
    
}


- (IBAction)clickMore:(id)sender {
    
    count++;
    
    NSMutableString *requestString1 = [NSString stringWithFormat:@"http://108.168.203.226:8123/events/get_favorites_filter/page:%d", count];
    

    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestString1]];
    
    [request setHTTPMethod:@"POST"];

    
    [request setValue:@"application/json"
   forHTTPHeaderField:@"content-type"];
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSData *responseData  = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    request = nil;
    
    NSString *responseString = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSString *string = [responseString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    
    string = [string stringByReplacingOccurrencesOfString:@"\"{" withString:@"{"];
    string = [string stringByReplacingOccurrencesOfString:@"}\"" withString:@"}"];
    string = [string stringByReplacingOccurrencesOfString:@"\"[" withString:@"["];
    string = [string stringByReplacingOccurrencesOfString:@"]\"" withString:@"]"];
    
    NSDictionary *responseDict = (NSDictionary *)[string JSONValue];
    
    NSLog(@"%@",responseDict);
    
    //***********************JSON Value******************************//
    
    SBJSON *parser = [[SBJSON alloc]init];
    
    
       // Here we're using NSArray since we're parsing an array of JSON status objects
    statuses = [parser objectWithString:string error:nil];
    
    
    // represented as a NSDictionary
    for (NSDictionary *status in statuses) {
        // You can retrieve individual values using objectForKey on the status NSDictionary
        
        [arrayToEvents addObject:[[status objectForKey:@"Event"]objectForKey:@"event_name"]];
        
        [prices addObject:[[status objectForKey:@"Event"]objectForKey:@"prices"]];
        
        [arrayToVenu addObject:[[status objectForKey:@"Venue"]objectForKey:@"venue_name"]];
        
        
        [eventShedule addObject:[[status objectForKey:@"EventSchedule"]objectForKey:@"start_time"]];
        
        [eventType addObject:[[status objectForKey:@"Event"]objectForKey:@"event_type"]];
        
        [longitude addObject:[[status objectForKey:@"Venue"]objectForKey:@"lon"]];
        
        [latitude addObject:[[status objectForKey:@"Venue"]objectForKey:@"lat"]];
        
        [venueAddress addObject:[[status objectForKey:@"Venue"]objectForKey:@"address"]];
        
        [description addObject:[[status objectForKey:@"Performer"]objectForKey:@"description"]];
        
        
        
    }
    
    
    
    
    for (int valTime = 0; valTime<[arrayToEvents count]; valTime++) {
        
        
        NSArray *subString = [[eventShedule objectAtIndex:valTime] componentsSeparatedByString:@" "];
        
        NSString *thirdValue1 = [subString objectAtIndex:1];
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"HH:mm:ss";
        NSDate *date = [dateFormatter dateFromString:thirdValue1];
        
        dateFormatter.dateFormat = @"hh:mm:ss a";
        NSString *pmamDateString = [dateFormatter stringFromDate:date];
        
        NSLog(@"%@",pmamDateString);
        
        [timeHr addObject:pmamDateString];
        
        
    }
    
 
    [self gotoLocation];
    
}

#pragma mark ASIHTTPReq Delegate
- (void)requestStarted:(ASIHTTPRequest *)request{
    
    NSLog(@"requestStarted%@",request);
    
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    
    NSLog(@"requestFinished%@",request);
    
    NSString *responseString=[[request responseString]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@"Response %@",responseString);
    
    
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    
    NSLog(@"requestFailed%@",request);
    
}


- (IBAction)clickLess:(id)sender {
    
    count--;
    
    
    NSLog(@"%u",[arrayToEvents count]);
    
    int indexVal = [arrayToEvents count];
    
    int intDiff = indexVal - 3;
    
    if (intDiff > 9){
    
        
           // You can retrieve individual values using objectForKey on the status NSDictionary
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(intDiff, 3)];
        
        [arrayToEvents removeObjectsAtIndexes:indexSet];
        
        [prices removeObjectsAtIndexes:indexSet];
        
        [arrayToVenu removeObjectsAtIndexes:indexSet];
        
        
        [eventShedule removeObjectsAtIndexes:indexSet];
        
        [eventType removeObjectsAtIndexes:indexSet];
        
        [longitude removeObjectsAtIndexes:indexSet];
        
        [latitude removeObjectsAtIndexes:indexSet];
        
        [venueAddress removeObjectsAtIndexes:indexSet];
        
        [description removeObjectsAtIndexes:indexSet];
        
        
        
 
    
    NSLog(@"%@",eventType);
    
    
    for (int valTime = 0; valTime<[arrayToEvents count]; valTime++) {
        
        
        NSArray *subString = [[eventShedule objectAtIndex:valTime] componentsSeparatedByString:@" "];
        
        NSString *thirdValue1 = [subString objectAtIndex:1];
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"HH:mm:ss";
        NSDate *date = [dateFormatter dateFromString:thirdValue1];
        
        dateFormatter.dateFormat = @"hh:mm:ss a";
        NSString *pmamDateString = [dateFormatter stringFromDate:date];
        
        NSLog(@"%@",pmamDateString);
        
        [timeHr addObject:pmamDateString];
        
        
    }
    
    
    [self gotoLocation];

    }
    
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
        
        annotationView.image = [UIImage imageNamed:[NSString stringWithFormat:@"13-07-02_tickme_51.png"]];
        
        
        
        
        //array set for images
        
        for (int valEvent=0; valEvent<[arrayToEvents count]; valEvent++) {
            
            NSMutableString *str = [eventType objectAtIndex:valEvent];
            
            if ([str isEqualToString:@"Music"]) {
                
                
               // NSLog(@"%i",valEvent);
                
                
                annotationView.image=[UIImage imageNamed:@"Blue-Pin_Music.png"];
                
                
            }
            
            
            else if([str isEqualToString:@"Special Event"]) {
                
                annotationView.image=[UIImage imageNamed:@"Blue-Pin_Special-Events.png"];
                
                    
            }
            
            else if([str isEqualToString:@"Sports"]) {
                
                
                annotationView.image=[UIImage imageNamed:@"Blue-Pin_Sports.png"];
                
                         
            }
            
            else if([str isEqualToString:@"Comedy"]) {
                
                annotationView.image=[UIImage imageNamed:@"Blue-Pin_Comedy.png"];
                          
            }
            
            else if([str isEqualToString:@"Art"]) {
                
                annotationView.image=[UIImage imageNamed:@"Blue-Pin_Art.png"];
                        
            }
            
            else if([str isEqualToString:@"Dance"]) {
                
              annotationView.image=[UIImage imageNamed:@"Blue-Pin_Dance.png"];  
                           
            }
            
            else if([str isEqualToString:@"Theater"]) {
                
                 annotationView.image=[UIImage imageNamed:@"Blue-Pin_Theater.png"];  
                
                
            }
            
            
        }
        
        
        UIImage *image = [UIImage imageNamed:@"blue_arrow.png"];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect frame = CGRectMake(0.0, 0.0, 20, 20);
        button.frame = frame;   // match the button's size with the image size
        
        //[button setBackgroundImage:image forState:UIControlStateNormal];
        [button setImage:image forState:UIControlStateNormal];
        // set the button's target to this table view controller so we can interpret touch events and map that to a NSIndexSet
        [button addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor clearColor];
        annotationView.rightCalloutAccessoryView = button;


//       
//        
//        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
        

        
           return annotationView;
        
       }
    
    return nil;    
}

-(void)checkButtonTapped:(id)sender{
    
//    UITableViewCell *cell = ((UITableViewCell *)[sender superview]);
//    
//    NSIndexPath *indexPath = [tblMyEvents indexPathForCell:cell];
//    
//    NSLog(@"INDEX %@",indexPath);
//    
//    NSString *stri = [description objectAtIndex:indexPath.row];
    
    EventsDetail *takeImage=[[EventsDetail alloc]init];
    
   // takeImage.desc = stri;
    
    [[self navigationController]pushViewController:takeImage animated:YES];
    
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
