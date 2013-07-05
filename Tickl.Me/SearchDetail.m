//
//  SearchDetail.m
//  Tickl.Me
//
//  Created by Saurabh Sindhu on 6/24/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "SearchDetail.h"
#import "MapKitDisplayViewController.h"
#import <EventKit/EventKit.h>
#import "ASIHTTPRequest.h"
#import "JSON.h"
#import <EventKit/EventKit.h>
#import "EKEvent+Utilities.h"
#import "AddFriendViewController.h"
#import "CheckInView.h"


@interface SearchDetail ()

@end

@implementation SearchDetail

int Xcoord,Ycoord;

@synthesize start_time,venue_name,prices,description,address,city,zip,phone,lat,longit,udid,endTime;

@synthesize eventStore,defaultCalendar,eventsList,detailViewController;

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
    [super viewDidLoad];
    
    
//    EKEventStore *store = [[EKEventStore alloc] init];
    
       
    scroll.frame = CGRectMake(0, 0, 320, 460);
    [scroll setContentSize:CGSizeMake(320, 880)];
    
    //current lat/long
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    
    latit = [lat doubleValue];
    longi = [longit doubleValue];
    
   
    
    UIBarButtonItem *leftBarButton =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(clickMenu)];
    self.navigationItem.rightBarButtonItem = leftBarButton;
    
    NSLog(@"%@",venue_name);
    
    Xcoord = 100;
    Ycoord = 220;

  
    UILabel *lblEventTime = [[UILabel alloc]initWithFrame :CGRectMake(Xcoord+90, Ycoord-70, 100, 150)];
    lblEventTime.tag =11;
    lblEventTime.textColor = [UIColor blackColor];
    lblEventTime.text=venue_name;
   [scroll addSubview:lblEventTime];
    

    
    NSLog(@"%@",start_time);
    
    NSArray *subStrings = [start_time componentsSeparatedByString:@" "]; 
    NSString *firstString = [subStrings objectAtIndex:0];
    NSString *lastString = [subStrings objectAtIndex:1];
    
    NSLog(@"F%@S%@",firstString,lastString);
    
    NSArray *subString = [firstString componentsSeparatedByString:@"-"];
    NSInteger firstVal =  [[subString objectAtIndex:1]integerValue];
    NSString *secondVal = [subString objectAtIndex:2];
    
    NSLog(@"S%d",firstVal);
    
    [self monthStr:firstVal];
    
    NSLog(@"S%@",str1);
    
    CGSize stringBoundingBox4 = [str1 sizeWithFont:[UIFont boldSystemFontOfSize:8.0]];
    UILabel *startmonth = [[UILabel alloc]initWithFrame :CGRectMake(5, Ycoord+30, 80, stringBoundingBox4.height+10)];
    startmonth.tag =14;
    startmonth.textColor = [UIColor blackColor];
    startmonth.text=str1;
    [scroll addSubview:startmonth];
    
    CGSize stringBoundingBox2 = [secondVal sizeWithFont:[UIFont boldSystemFontOfSize:9.0]];
    UILabel *starttime = [[UILabel alloc]initWithFrame :CGRectMake(5, Ycoord, 60, stringBoundingBox2.height+10)];
    starttime.tag =13;
    starttime.textColor = [UIColor blackColor];
    starttime.text=secondVal;
    [scroll addSubview:starttime];
    
    NSString *strAbt = @"About the Event:";
    CGSize stringBoundingBox1 = [strAbt sizeWithFont:[UIFont boldSystemFontOfSize:14.0]];
    UILabel *abtEvent = [[UILabel alloc]initWithFrame :CGRectMake(10, 280, stringBoundingBox1.width+20, stringBoundingBox1.height+10)];
    abtEvent.textColor =[UIColor blackColor];
    abtEvent.tag =12;
    abtEvent.backgroundColor = [UIColor clearColor];
    abtEvent.text=strAbt;
    abtEvent.textAlignment = 0;
    [scroll addSubview:abtEvent];
    
    
    UILabel *des = [[UILabel alloc]initWithFrame :CGRectMake(10, 310, 300, 250)];
    des.textColor =[UIColor blackColor];
    des.tag =19;
    des.lineBreakMode = NSLineBreakByWordWrapping;
    des.numberOfLines = 0;
    [self resizeHeightToFitForLabel:des withText:description];
    NSLog(@"width = %f, height = %f", expectedLabelSize.width, expectedLabelSize.height);
    [scroll addSubview:des];

    
    UIButton *customMenuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customMenuBtn.frame = CGRectMake(10, expectedLabelSize.height+385, 80, 80);
    [customMenuBtn addTarget:self action:@selector(clickMap) forControlEvents:UIControlEventTouchUpInside];
    [customMenuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [customMenuBtn setImage:[UIImage imageNamed:@"map_img.jpeg"] forState:UIControlStateNormal];
    [scroll addSubview:customMenuBtn];

    
    NSString *str2 = @"About the venue";
    
    UILabel *abtVenue = [[UILabel alloc]initWithFrame :CGRectMake(10, expectedLabelSize.height+300, 250, 80)];
    abtVenue.textColor =[UIColor blackColor];
    abtVenue.tag =21;
    abtVenue.backgroundColor = [UIColor clearColor];
    abtVenue.text=str2;
    abtVenue.textAlignment = 0;
    abtVenue.font = [UIFont boldSystemFontOfSize:15.0];
    [scroll addSubview:abtVenue];
    
    
    UILabel *addressV = [[UILabel alloc]initWithFrame :CGRectMake(100, expectedLabelSize.height+400, 180, 10)];
    addressV.textColor =[UIColor blackColor];
    addressV.tag =22;
    addressV.backgroundColor = [UIColor clearColor];
    addressV.text=address;
    addressV.textAlignment = 0;
    addressV.font = [UIFont boldSystemFontOfSize:11.0];
    [scroll addSubview:addressV];
    
    UILabel *cityName = [[UILabel alloc]initWithFrame :CGRectMake(100, expectedLabelSize.height+412, 50, 10)];
    cityName.textColor =[UIColor blackColor];
    cityName.tag =23;
    cityName.backgroundColor = [UIColor clearColor];
    cityName.text=city;
    cityName.textAlignment = 0;
    cityName.font = [UIFont boldSystemFontOfSize:11.0];
    [scroll addSubview:cityName];
    
    UILabel *zipCode = [[UILabel alloc]initWithFrame :CGRectMake(155, expectedLabelSize.height+412, 60, 10)];
    zipCode.textColor =[UIColor blackColor];
    zipCode.tag =24;
    zipCode.backgroundColor = [UIColor clearColor];
    zipCode.text=zip;
    zipCode.textAlignment = 0;
    zipCode.font = [UIFont boldSystemFontOfSize:11.0];
    [scroll addSubview:zipCode];
    
    
    UILabel *phoneNumber = [[UILabel alloc]initWithFrame :CGRectMake(100, expectedLabelSize.height+425, 60, 10)];
    phoneNumber.textColor =[UIColor blackColor];
    phoneNumber.tag =24;
    phoneNumber.backgroundColor = [UIColor clearColor];
    phoneNumber.text=phone;
    phoneNumber.textAlignment = 0;
    phoneNumber.font = [UIFont boldSystemFontOfSize:8.0];
    [scroll addSubview:phoneNumber];
    
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextSetRGBStrokeColor(ctx, 0.0f/255.0f, 0.0f/255.0f, 255.0f/255.0f, 1.0f); // Your underline color
//    CGContextSetLineWidth(ctx, 1.0f);
//    
//    UIFont *font = [UIFont systemFontOfSize:16.0f];
//    CGSize constraintSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
//    CGSize labelSize;
//    labelSize = [phone sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
//    
//    CGContextMoveToPoint(ctx, 0, self.bounds.size.height - 1);
//    CGContextAddLineToPoint(ctx, labelSize.width + 10, self.bounds.size.height - 1);
//    
//    CGContextStrokePath(ctx);




   
}

#pragma mark
#pragma UnderLine



#pragma mark
#pragma UILabel

-(CGFloat)heightForLabel:(UILabel *)label withText:(NSString *)text
{
    CGSize maximumLabelSize     = CGSizeMake(320, 9999);
    
    expectedLabelSize    = [text sizeWithFont:label.font
                                   constrainedToSize:maximumLabelSize
                                       lineBreakMode:label.lineBreakMode];
    
    return expectedLabelSize.height;
    
  
}

-(void)resizeHeightToFitForLabel:(UILabel *)label
{
    CGRect newFrame         = label.frame;
    newFrame.size.height    = [self heightForLabel:label withText:label.text];
    label.frame             = newFrame;
}

-(void)resizeHeightToFitForLabel:(UILabel *)label withText:(NSString *)text
{
    label.text              = text;
    [self resizeHeightToFitForLabel:label];
}




- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    currentLocation = newLocation;
    currentLat =  newLocation.coordinate.latitude;
    currentLong =  newLocation.coordinate.longitude;
    
}


#pragma mark
#pragma ActionSheet

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    

    if (buttonIndex==0 && getit==YES){
        
        NSLog(@"Hi");
        
        CheckInView *check = [[CheckInView alloc]init];
        
         [[self navigationController]pushViewController:check animated:YES];
    }
    
    if (buttonIndex==0 && getit==NO) {
        
    
        
        self.eventStore = [[EKEventStore alloc] init];
        
        self.eventsList = [[NSMutableArray alloc] initWithArray:0];
        // Fetch today's event on selected calendar and put them into the eventsList array
        [self.eventsList addObjectsFromArray:[self fetchEventsForToday]];
        
       // NSLog(@"%@",self.eventsList);
        
        
        //fb_id
        
        NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        destPath = [destPath stringByAppendingPathComponent:@"userid.plist"];
        
        NSLog(@"tft%@",destPath);
        
        
        NSDictionary *dictValue = [[NSDictionary alloc]
                                   initWithContentsOfFile:destPath];
        
        
        NSString *fb_id = [dictValue objectForKey:@"facebook_id"];
        
        NSLog(@"%@",fb_id);
        
        
        //user_id
        
        NSString *destPath1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        destPath1 = [destPath1 stringByAppendingPathComponent:@"userName.plist"];
        
        NSLog(@"tft%@",destPath1);
        
        
        NSDictionary *dictValue1 = [[NSDictionary alloc]
                                    initWithContentsOfFile:destPath1];
        
        NSString *user_id = [dictValue1 objectForKey:@"userName"];
        
        NSLog(@"tft%@%@",user_id,udid);
        
        
        if (fb_id != nil) {
            
            NSString *user_id = [dictValue1 objectForKey:@"userName"];
            
            NSLog(@"tft%@%@",user_id,udid);
            
            NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://108.168.203.226:8123/events/get_fbk_events"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
           
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
            NSDictionary* postDict = [NSDictionary dictionaryWithObjectsAndKeys:fb_id,@"facebook_id",udid,@"id",start_time,@"date",nil];
            
            NSString* jsonData = [postDict JSONRepresentation];
            NSData* postData = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
            [request appendPostData:postData];
            [request setDelegate:self];
            [request startAsynchronous];
            
         
        }
        
        else if (user_id != nil){
            
            
            
            NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://108.168.203.226:8123/events/get_my_events/"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
           
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
            NSDictionary* postDict = [NSDictionary dictionaryWithObjectsAndKeys:user_id,@"user_id",udid,@"id",start_time,@"date",nil];
            
            NSString* jsonData = [postDict JSONRepresentation];
            NSData* postData = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
            [request appendPostData:postData];
            [request setDelegate:self];
            [request startAsynchronous];
            
        }
        
        
//        EKEventEditViewController *addController = [[EKEventEditViewController alloc] initWithNibName:nil bundle:nil];
//        
//        NSLog(@"%@",self.eventStore);
//    
//        
//        // set the addController's event store to the current event store.
//        addController.eventStore = self.eventStore;
//        
//        // present EventsAddViewController as a modal view controller
//        [self presentViewController:addController animated:YES completion:nil];
//
//       
      
        
    }
    
    if (buttonIndex==1) {
        
        AddFriendViewController *addFrnd = [[AddFriendViewController alloc]init];
        
        
         [[self navigationController]pushViewController:addFrnd animated:YES];
        
    }
    
    
    if (buttonIndex==2) {
        
        NSLog(@"%f",currentLat);
        
        NSString *currentLatitude = [NSString stringWithFormat:@"%f",currentLat];
        
        NSString *currentLongitude = [NSString stringWithFormat:@"%f",currentLong];
        
        NSString *myLatLong1 = [currentLatitude stringByAppendingString:@","];
        
        NSString *myLatLong = [myLatLong1 stringByAppendingString:currentLongitude];
        
        NSString *latlong1 = [lat stringByAppendingString:@","];
        
        NSString *latlong = [latlong1 stringByAppendingString:longit];
        
               
        [[UIApplication sharedApplication] openURL:
         [NSURL URLWithString:
          [NSString stringWithFormat: @"http://maps.google.com/maps?saddr=%@&daddr=%@",
           myLatLong,
           latlong]]]; 
        
    }
    
    if (buttonIndex==3) {
        
        //fb_id
        
        NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        destPath = [destPath stringByAppendingPathComponent:@"userid.plist"];
        
        NSLog(@"tft%@",destPath);
        
        
        NSDictionary *dictValue = [[NSDictionary alloc]
                                   initWithContentsOfFile:destPath];
        
        
        NSString *fb_id = [dictValue objectForKey:@"facebook_id"];
        
        NSLog(@"%@",fb_id);
        
        
        //user_id
        
         NSString *destPath1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        destPath1 = [destPath1 stringByAppendingPathComponent:@"userName.plist"];
        
        NSLog(@"tft%@",destPath1);
        
        
        NSDictionary *dictValue1 = [[NSDictionary alloc]
                                   initWithContentsOfFile:destPath1];
        
        NSString *user_id = [dictValue1 objectForKey:@"userName"];
        
        NSLog(@"tft%@%@",user_id,udid);
        
        
        if (fb_id != nil) {
            
            NSString *user_id = [dictValue1 objectForKey:@"userName"];
            
            NSLog(@"tft%@%@",user_id,udid);
            
            NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://108.168.203.226:8123/events/get_favorite_data/"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
            NSDictionary* postDict = [NSDictionary dictionaryWithObjectsAndKeys:fb_id,@"facebook_id",udid,@"id",nil];
            
            NSString* jsonData = [postDict JSONRepresentation];
            NSData* postData = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
            [request appendPostData:postData];
            [request setDelegate:self];
            [request startAsynchronous];
   
         
            
        }
        
        else if (user_id != nil){
        
       
        
        NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://108.168.203.226:8123/events/get_favorite_data/"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
        NSDictionary* postDict = [NSDictionary dictionaryWithObjectsAndKeys:user_id,@"user_id",udid,@"id",nil];
        
        NSString* jsonData = [postDict JSONRepresentation];
        NSData* postData = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
        [request appendPostData:postData];
        [request setDelegate:self];
        [request startAsynchronous];

        }
                
    }
    
    
}


// Fetching events happening in the next 24 hours with a predicate, limiting to the default calendar
- (NSArray *)fetchEventsForToday {
    
    NSLog(@"%@",start_time);
    
    NSArray *subStrings = [start_time componentsSeparatedByString:@" "];
    NSString *firstString = [subStrings objectAtIndex:0];
  

    
    NSString *dateString = firstString;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    
    NSDate *startDate = [[NSDate alloc] init];
    // voila!
    startDate = [dateFormatter dateFromString:dateString];
   
	
	
	NSLog(@"%@",endTime);
    
    NSArray *subStringsVal = [endTime componentsSeparatedByString:@" "];
    NSString *firstString1 = [subStringsVal objectAtIndex:0];
    

	// endDate is 1 day = 60*60*24 seconds = 86400 seconds from startDate
	NSDate *endDate = [[NSDate alloc]init];
    
    endDate = [dateFormatter dateFromString:firstString1];
	    
    if([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        // iOS 6 and later
        // This line asks user's permission to access his calendar
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
         {
             if (granted)
             {
                EKEvent *event = [EKEvent eventWithEventStore:eventStore];
                 event.title  = venue_name;
                 NSLog(@"Name%@",venue_name);
                 event.location = address;
                 event.notes = description;
                
                 //event.allDay = YES;
             
                             
                                 
                 event.startDate = startDate;
                 
                 event.endDate = endDate;
                 
                 [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                 NSError *err;
                 
                 [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
             
                //alarm concept here...
             
//                [event addAlarm:[EKAlarm alarmWithAbsoluteDate:[[NSDate date] dateByAddingTimeInterval:-1800]]];
//             
//                [event setCalendar:[eventStore defaultCalendarForNewEvents]];
//             
//                 NSMutableArray *myAlarmsArray = [[NSMutableArray alloc] init];
//             
//                 EKAlarm *alarm1 = [EKAlarm alarmWithRelativeOffset:-3600]; // 1 Hour
//                 EKAlarm *alarm2 = [EKAlarm alarmWithRelativeOffset:-86400]; // 1 Day
//             
//                 [myAlarmsArray addObject:alarm1];
//                 [myAlarmsArray addObject:alarm2];
//             
//             event.alarms = myAlarmsArray;
             
             NSError *error1 = nil;
             
             if ([eventStore saveEvent:event span:EKSpanThisEvent error:&error1])
             {
                 //success
             }
             else
             {
                 //error
             }
                 
            if(err)
                     NSLog(@"unable to save event to the calendar!: Error= %@", err);
                 
             }
             else // if he does not allow
             {
                 [[[UIAlertView alloc]initWithTitle:nil message:@"not!" delegate:nil cancelButtonTitle:NSLocalizedString(@"plzAlowCalendar", nil)  otherButtonTitles: nil] show];
                 return;
             }
         }];
    }
    
    // iOS < 6
    else
    {
        EKEvent *event = [EKEvent eventWithEventStore:eventStore];
        event.title  = venue_name;
        event.location = address;
        event.allDay = YES;
        
        
        event.startDate = startDate;
        
        event.endDate = endDate;
        
        [event setCalendar:[eventStore defaultCalendarForNewEvents]];
        NSError *err;
        
        [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
        
        if(err)
            NSLog(@"unable to save event to the calendar!: Error= %@", err);
        

        
        }
    
      
	return events;
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



-(void)clickMenu{
    
    
    NSInteger minutes = 4*60;//5hrs
    NSDate *date = [NSDate date];
    NSLog(@"Current Time: %@", date);//Current Time: 2013-07-02 06:33:25 +0000
    
    
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:SS"];
    
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    NSLog(@"%@",dateString);
    
    NSDate *futureDate = [date dateByAddingTimeInterval:minutes*60];
    
    NSString *futString = [dateFormatter stringFromDate:futureDate];
    
    NSLog(@"%@",futString);
    
    NSLog(@"%@",start_time);
    
    NSArray *subString = [start_time componentsSeparatedByString:@" "];
    NSInteger firstVal =  [[subString objectAtIndex:1]integerValue];
    NSString *secondVal = [subString objectAtIndex:0];
    
    
    NSLog(@"S%dSV%@",firstVal,secondVal);
    
    NSArray *subString1 = [futString componentsSeparatedByString:@" "];
    NSInteger firstVal1 =  [[subString1 objectAtIndex:1]integerValue];
    NSString *secondVal1 = [subString1 objectAtIndex:0];
    
    NSLog(@"Se%ddSVa%@",firstVal1,secondVal1);
    
    if ( [secondVal isEqualToString:secondVal1] && firstVal1 > firstVal) {
        
        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Check In", @"Invite A Friend",@"Get Directions",@"Add as Favorite",nil];
        [action showInView:self.view];
        
        getit=YES;
        
    }
    
    else {
    
    
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Add To Calender", @"Invite A Friend",@"Get Directions",@"Add as Favorite",nil];
    [action showInView:self.view];
        
    getit=NO;
        
    }
    
}

-(void)clickMap{
    
    MapKitDisplayViewController *map = [[MapKitDisplayViewController alloc]initWithNibName:@"MapKitDisplayViewController" bundle:nil];
    
    map.latitude = latit;
    
    map.longitude = longi;
    
    NSLog(@"%f%f",latit,longi);
    
    [self.navigationController pushViewController:map animated:YES];
    
    
}


-(void)monthStr:(NSInteger)val{
    
    if (val==1) {
        
        str1 = @"January";
        
    }
    
    else if (val==2) {
        
        str1 = @"February";
        
    }
    
    else if (val==3) {
        
        str1 = @"March";
        
    }
    
    else if (val==4) {
        
        str1 = @"April";
        
    }
    
    else if (val==5) {
        
        str1 = @"May";
        
    }
    
    else if (val==6) {
        
        str1 = @"June";
        
    }
    
    else if (val==7) {
        
        str1 = @"July";
        
    }
    
    else if (val==8) {
        
        str1 = @"August";
        
    }
    
    else if (val==9) {
        
        str1 = @"September";
        
    }
    
    else if (val==10) {
        
        str1 = @"October";
        
    }
    
    else if (val==11) {
        
        str1 = @"November";
        
    }
    
    else if (val==12) {
        
        str1 = @"December";
        
    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
