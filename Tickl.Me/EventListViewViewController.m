//
//  EventListViewViewController.m
//  Tickl.Me
//
//  Created by Prakash Joshi on 4/30/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "EventListViewViewController.h"
#import "TakePicEventPlaceViewController.h"
#import "AppDelegate.h"
#import "MapView_ViewController.h"
#import "AsyncImageView.h"
#import "JSON.h"
#import "CheckInView.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "EventsDetail.h"

#define ASYNC_IMAGE_TAG 9999

@interface EventListViewViewController ()

@end

@implementation EventListViewViewController

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
    
//    
//    UIImage *image = [UIImage imageNamed:@"top_bar.png"];
//    UIImageView *imageViewe = [[UIImageView alloc] initWithImage:image];
//    
//      
//    CGRect applicationFrame = CGRectMake(0, 0, 330, 46);
//    UIView * newView = [[UIView alloc] initWithFrame:applicationFrame];
//    [newView addSubview:imageViewe];
//  
//    
//    
//    [self.navigationController.navigationBar addSubview:newView];
    
    
   
    
    imagArray = [[NSMutableArray alloc]initWithObjects:@"Blue-List_Added-a-Friend.png",@"Blue-List_Added-to-My-Calendar.png",@"Blue-List_Art.png",@"Blue-List_Comedy.png",@"Blue-List_Dance.png",@"Blue-List_Event-Categories.png",@"Blue-List_Event-Check-in.png",@"Blue-List_Family-Friendly.png",@"Blue-List_Favorites.png",@"Blue-List_Free-or-Cheap.png",@"Blue-List_High-Culture.png",@"Blue-List_Movies.png",@"Orange-List_Music.png",@"Blue-List_Odd-and-Offbeat.png",@"Blue-List_Once-in-a-Lifetime.png",@"Blue-List_People-Like-Me.png",@"Blue-List_scan-my-friends.png",@"Blue-List_Special-Events.png",@"Blue-List_Sports.png",@"Blue-List_Talks-and-Readings.png",@"Blue-List_Theater.png",@"Blue-List_Vultures.png",nil];
    
    //current lat/long
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    // path for filter
    
    NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    destPath = [destPath stringByAppendingPathComponent:@"filter.plist"];
    
    
    
   /* NSDictionary *dictValue = [[NSDictionary alloc]
                               initWithContentsOfFile:destPath]; */
    
    
      
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"Eswitch.plist"];
    
    NSDictionary *myDict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    BOOL myBool = [[myDict objectForKey:@"Eswitch"] boolValue];
    
    
    if (myBool==YES) {
        NSLog(@"1");
    }
    
    else {
        
        NSLog(@"2");
    }
    
    
    
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
    
    thumImages = [[NSMutableArray alloc]init];
    
    locationValue = [[NSMutableArray alloc]init];
    
    minTime = [[NSMutableArray alloc]init];
    
    hourTime = [[NSMutableArray alloc]init];
    
    cellImage = [[NSMutableArray alloc]init];
    
    //***********************JSON Value******************************//
    
    SBJSON *parser = [[SBJSON alloc]init];
    
   
        
        //http://108.168.203.226:8123/events/get_list_events
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://108.168.203.226:8123/events/get_favorites_filter"]];
        
        // Perform request and get JSON back as a NSData object
        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        // Get JSON as a NSString from NSData response
        NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        
        // parse the JSON response into an object
        // Here we're using NSArray since we're parsing an array of JSON status objects
        statuses = [parser objectWithString:json_string error:nil];
        
        
             
       
    // Prepare URL request to download statuses from Twitter
    // NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://108.168.203.226:8123/events/get_event_data"]];
    
    // Perform request and get JSON back as a NSData object
    // NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    // Get JSON as a NSString from NSData response
    // NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    // parse the JSON response into an object
    // Here we're using NSArray since we're parsing an array of JSON status objects
    
    
    // Each element in statuses is a single status
    // represented as a NSDictionary
    for (NSDictionary *status in statuses) {
        // You can retrieve individual values using objectForKey on the status NSDictionary
        
        [arrayToEvents addObject:[[status objectForKey:@"Event"]objectForKey:@"event_name"]];
        
        [arrayToVenu addObject:[[status objectForKey:@"Venue"]objectForKey:@"venue_name"]];
        
        [thmbImage addObject:[[status objectForKey:@"Performer"]objectForKey:@"thumbnail"]];
        
        [eventShedule addObject:[[status objectForKey:@"EventSchedule"]objectForKey:@"start_time"]];
        
        [eventType addObject:[[status objectForKey:@"Event"]objectForKey:@"event_type"]];
        
        [longitude addObject:[[status objectForKey:@"Venue"]objectForKey:@"lon"]];
        
        [latitude addObject:[[status objectForKey:@"Venue"]objectForKey:@"lat"]];
        
        [venueAddress addObject:[[status objectForKey:@"Venue"]objectForKey:@"address"]];
        
        [description addObject:[[status objectForKey:@"Performer"]objectForKey:@"description"]];
        
    }
    
    
    
    //***************************************************************//
    
          
  
    
    UIButton *customMenuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customMenuBtn.frame = CGRectMake(10, 7.5, 30, 30);
    [customMenuBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [customMenuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [customMenuBtn setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *leftBarButton =[[UIBarButtonItem alloc] initWithCustomView:customMenuBtn];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    // ****************************************Map View BarButton*************************************************//
    
    UIButton *customMapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customMapBtn.frame = CGRectMake(300, 7.5, 30, 30);
    [customMapBtn addTarget:self action:@selector(mapButtonClk) forControlEvents:UIControlEventTouchUpInside];
    [customMapBtn setImage:[UIImage imageNamed:@"location.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:customMapBtn];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    
    arrTotalEvent=[[NSMutableArray alloc]initWithObjects:nil];
    
   }


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
    
      
}

- (void)backBtnClicked {
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app showMenu];
}

-(void)mapButtonClk{
    
    MapView_ViewController *map = [[MapView_ViewController alloc]initWithNibName:@"MapView_ViewController" bundle:nil];
    
    map.lat = latitude;
    map.lon = longitude;
    map.listOfCat = eventType;
    map.listOfPlaceName = arrayToVenu;
    map.listOfAddress = venueAddress;
    map.listOfDesc = description;
    
    
    [[self navigationController]pushViewController:map animated:YES];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventsDetail *takeImage=[[EventsDetail alloc]init];
    [[self navigationController]pushViewController:takeImage animated:YES];
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor=[UIColor whiteColor];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayToEvents.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    asyncImageView = nil;
    
	NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell	*cell = [tblMyEvents dequeueReusableCellWithIdentifier:cellIdentifier];
    // objMyEvent=(DataMyEvent*)[arrTotalEvent objectAtIndex:indexPath.row];
    cell=nil;
    
    if(cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        
//        UIButton *ProfileImageButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
//        [ProfileImageButton setBackgroundColor:[UIColor clearColor]];
//        [ProfileImageButton setClearsContextBeforeDrawing:YES];
//        [ProfileImageButton setUserInteractionEnabled:NO];
//        NSString *ImagePath =[thmbImage objectAtIndex:indexPath.row];
//        
//        [ProfileImageButton setImageWithURL:[NSURL URLWithString:ImagePath] placeholderImage:[UIImage imageNamed:@"nouser.png"]];
//        [cell.contentView addSubview:ProfileImageButton];
        
      
        
        UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(18,60,284,4)];
        imv.image=[UIImage imageNamed:@"iPhone_11.png"];
        [cell addSubview:imv];
    
       
        //curr loc
        
                  
            CLLocationManager *locationManager1 = [[CLLocationManager alloc] init];
            
                locationManager1.delegate = self;
                locationManager1.desiredAccuracy = kCLLocationAccuracyBest;
                locationManager1.distanceFilter = kCLDistanceFilterNone;
                [locationManager1 startUpdatingLocation];
            
            
            
            CLLocation *location = [locationManager1 location];
          
                  
        for (int curL = 0; curL < [arrayToEvents count]; curL++) {
            
            double laaat = [[latitude objectAtIndex:curL]doubleValue];
            
            double loong = [[longitude objectAtIndex:curL]doubleValue];
            
//            NSLog(@"%f%f",laaat,loong);
            
            
            CLLocation *LocationAtual = [[CLLocation alloc] initWithLatitude:laaat longitude:loong];
            
            CLLocationDistance kilometers = [location distanceFromLocation:LocationAtual] / 1000; // Error ocurring here.
            
            float miles = kilometers*0.62;
            
//            NSLog(@"%f",miles);
            
            NSString *latlong = [NSString stringWithFormat:@"%f",miles];
            
            [locationValue addObject:latlong];
            
            
        }
        
        
       
       
        
        UILabel *lblEventTime = [[UILabel alloc]initWithFrame :CGRectMake(232, 58, 10, 25)];
        lblEventTime.font = [UIFont boldSystemFontOfSize:13];
        lblEventTime.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
        lblEventTime.tag =11;
        lblEventTime.backgroundColor = [UIColor clearColor];
       
        
        //logic for difference in time here...
        
       
        NSDate *date = [NSDate date];
      //  NSLog(@"Current Time: %@", date);//Current Time: 2013-07-02 06:33:25 +0000
        
        
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        // this is imporant - we set our input date format to match our input string
        // if format doesn't match you'll get nil from your string, so be careful
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:SS"];
        
        NSString *dateString = [dateFormatter stringFromDate:date];
        
       // NSLog(@"%@",dateString);
        
        NSArray *subString1 = [dateString componentsSeparatedByString:@" "];
        NSInteger firstVal1 =  [[subString1 objectAtIndex:1]integerValue];
        NSString *thirdVal1 = [subString1 objectAtIndex:1];
//        NSString *secondVal1 = [subString1 objectAtIndex:0];
        
       // NSLog(@"Se%ddSVa%@",firstVal1,secondVal1);
        
       // NSLog(@"%@",thirdVal1);
        
        NSArray *monthStr = [thirdVal1 componentsSeparatedByString:@":"];
        NSInteger monstr = [[monthStr objectAtIndex:1]integerValue];
       // NSLog(@"%d",monstr);
        
              
       // NSLog(@"%@",eventShedule);
        
        for (int valTime = 0; valTime<[arrayToEvents count]; valTime++) {
            
            
            NSArray *subString = [[eventShedule objectAtIndex:valTime] componentsSeparatedByString:@" "];
            NSInteger firstVal =  [[subString objectAtIndex:1]integerValue];
          //  NSInteger thirdVal =  [[subString objectAtIndex:2]integerValue];
//            NSString *secondVal = [subString objectAtIndex:0];
             NSString *thirdValue1 = [subString objectAtIndex:1];
            
          //  NSLog(@"S%dSV%@",firstVal,secondVal);
            
            NSArray *monthStr1 = [thirdValue1 componentsSeparatedByString:@":"];
            NSInteger monstr1 = [[monthStr1 objectAtIndex:1]integerValue];
           // NSLog(@"%d",monstr1);

            
          //  NSLog(@"%d",thirdVal);
            
            int comVal = abs(firstVal - firstVal1);
            
            int comVal1 = abs(monstr - monstr1);
            
          //  NSLog(@"%i",comVal);
            
          //  NSLog(@"%i",comVal1);
            
            NSString *hrStr = [NSString stringWithFormat:@"%i",comVal];
            
            NSString *minStr = [NSString stringWithFormat:@"%i",comVal1];
            
            [hourTime addObject:hrStr];
            
            [minTime addObject:minStr];
                        
        }
        
        
        
        lblEventTime.text=[hourTime objectAtIndex:indexPath.row];
        UIFont *myFont1 = [ UIFont fontWithName: @"Arial" size: 10.0 ];
        lblEventTime.font  = myFont1;
        lblEventTime.textAlignment = 0;
        [cell addSubview:lblEventTime];
        
        
        NSString *lblStrVal = @"Starts in";
        
        UILabel *lblStrVa = [[UILabel alloc]initWithFrame :CGRectMake(190, 58, 40, 25)];
        lblStrVa.font = [UIFont boldSystemFontOfSize:9];
        lblStrVa.tag =21;
        lblStrVa.backgroundColor = [UIColor clearColor];
        lblStrVa.text=lblStrVal;
        lblStrVa.textAlignment = 0;
        [cell addSubview:lblStrVa];
        
        NSString *hrVal = @"hrs";
        
        UILabel *hrVa = [[UILabel alloc]initWithFrame :CGRectMake(245, 58,15, 25)];
        hrVa.font = [UIFont boldSystemFontOfSize:9];
        hrVa.tag =22;
        hrVa.backgroundColor = [UIColor clearColor];
        hrVa.text=hrVal;
        hrVa.textAlignment = 0;
        [cell addSubview:hrVa];
        
        UILabel *lblEventMin = [[UILabel alloc]initWithFrame :CGRectMake(263, 58, 15, 25)];
        lblEventMin.font = [UIFont boldSystemFontOfSize:9];
        lblEventMin.tag =27;
        lblEventMin.backgroundColor = [UIColor clearColor];
        lblEventMin.text=[minTime objectAtIndex:indexPath.row];
                
        lblEventMin.textAlignment = 0;
        [cell addSubview:lblEventMin];

        NSString *minVal = @"mins";
        
        UILabel *minVa = [[UILabel alloc]initWithFrame :CGRectMake(280, 58,30, 25)];
        minVa.font = [UIFont boldSystemFontOfSize:9];
        minVa.tag =28;
        minVa.backgroundColor = [UIColor clearColor];
        minVa.text=minVal;
        minVa.textAlignment = 0;
        [cell addSubview:minVa];
        

        
        NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
        [DateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        NSString *curDate = [DateFormatter stringFromDate:[NSDate date]];
        //NSLog(@"%@",curDate);
        
        for (id obj in eventShedule) {
            
            if (obj >= curDate) {
                
                // NSLog(@"Event will Happen");
                
            }
            
            else if (obj == curDate){
                
                // NSLog(@"Event Occuring");
            }
            
        }
        
        //menu.png
        
        
        UILabel *lblEventName = [[UILabel alloc]initWithFrame :CGRectMake(70, 5, 195, 25)];
        lblEventName.font = [UIFont boldSystemFontOfSize:13];
        lblEventName.tag =11;
        lblEventName.backgroundColor = [UIColor clearColor];
        lblEventName.text=[arrayToEvents objectAtIndex:indexPath.row];
        // cell.textLabel.text = [arrayToEvents objectAtIndex:indexPath.row];
        
        
        lblEventName.textAlignment = 0;
        [cell addSubview:lblEventName];
        
        
        UILabel *lblLocation = [[UILabel alloc]initWithFrame :CGRectMake(70, 31, 80, 25)];
        lblLocation.font = [UIFont boldSystemFontOfSize:9];
        lblLocation.tag =17;
        lblLocation.backgroundColor = [UIColor clearColor];
        lblLocation.text=[locationValue objectAtIndex:indexPath.row];
        // cell.textLabel.text = [arrayToEvents objectAtIndex:indexPath.row];
        
        
        lblLocation.textAlignment = 0;
        [cell addSubview:lblLocation];
        
        NSString *string = @"miles away";
        
        UILabel *lblStr = [[UILabel alloc]initWithFrame :CGRectMake(120, 31, 170, 25)];
        lblStr.font = [UIFont boldSystemFontOfSize:9];
        lblStr.tag =18;
        lblStr.backgroundColor = [UIColor clearColor];
        lblStr.text=string;
        // cell.textLabel.text = [arrayToEvents objectAtIndex:indexPath.row];
        
        
        lblStr.textAlignment = 0;
        [cell addSubview:lblStr];
        
        UIImageView *pinImg = [[UIImageView alloc]initWithFrame:CGRectMake(2,62,14,12)];
        pinImg.image=[UIImage imageNamed:@"orange_location.png"];
        [cell addSubview:pinImg];

        
        UILabel *lblEventSubDetails = [[UILabel alloc]initWithFrame :CGRectMake(17, 58, 150, 25)];
        lblEventSubDetails.font = [UIFont boldSystemFontOfSize:13];
        lblEventSubDetails.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
        lblEventSubDetails.tag =19;
        lblEventSubDetails.backgroundColor = [UIColor clearColor];
        lblEventSubDetails.text=[arrayToVenu objectAtIndex:indexPath.row];
        //cell.detailTextLabel.text = [arrayToDesc objectAtIndex:indexPath.row];
        
        UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 10.0 ];
        lblEventSubDetails.font  = myFont;
        
        
        lblEventSubDetails.textAlignment = 0;
        [cell addSubview:lblEventSubDetails];
        
        UIImageView *timeImg = [[UIImageView alloc]initWithFrame:CGRectMake(170,65,14,12)];
        timeImg.image=[UIImage imageNamed:@"orange_location-08.png"];
        [cell addSubview:timeImg];
        
       // NSLog(@"%@",eventType);
        
        
        
        for (int valEvent=0; valEvent<[arrayToEvents count]; valEvent++) {
            
            NSMutableString *str = [eventType objectAtIndex:valEvent];
            
            if ([str isEqualToString:@"Music"]) {
                
             
               // NSLog(@"%i",valEvent);
                
                [cellImage insertObject:@"Orange-List_Music.png" atIndex:valEvent];
                
                
            }
            
            
            else if([str isEqualToString:@"Special Event"]) {
                
                
              [cellImage insertObject:@"Blue-List_Special-Events.png" atIndex:valEvent];
                
                
            }
            
            else if([str isEqualToString:@"Sports"]) {
                
                
             [cellImage insertObject:@"Blue-List_Sports.png" atIndex:valEvent];
                
                
            }
            
            else if([str isEqualToString:@"Comedy"]) {
                
                
                [cellImage insertObject:@"Blue-List_Comedy.png" atIndex:valEvent];
                
                
            }
            
            else if([str isEqualToString:@"Art"]) {
                
                
                [cellImage insertObject:@"Blue-List_Art.png" atIndex:valEvent];
                
                
            }
            
            else if([str isEqualToString:@"Dance"]) {
                
                
                [cellImage insertObject:@"Blue-List_Dance.png" atIndex:valEvent];
                
                
            }
            
            else if([str isEqualToString:@"Theater"]) {
                
                
                [cellImage insertObject:@"Blue-List_Theater.png" atIndex:valEvent];
                
                
            }

            
        }
        
    }
    
   // NSLog(@"%@",cellImage);
    
   cell.imageView.image = [UIImage imageNamed:[cellImage objectAtIndex:indexPath.row]];
    
    UIImage *image = [UIImage imageNamed:@"blue_arrow.png"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0.0, 0.0, 20, 20);
    button.frame = frame;   // match the button's size with the image size
    
    //[button setBackgroundImage:image forState:UIControlStateNormal];
    [button setImage:image forState:UIControlStateNormal];
    // set the button's target to this table view controller so we can interpret touch events and map that to a NSIndexSet
    [button addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor clearColor];
    cell.accessoryView = button;

    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)checkButtonTapped:(id)sender{
    
    UITableViewCell *cell = ((UITableViewCell *)[sender superview]);
   
    NSIndexPath *indexPath = [tblMyEvents indexPathForCell:cell];
   
   // NSLog(@"INDEX %@",indexPath);
    
    NSString *stri = [description objectAtIndex:indexPath.row];
    
    EventsDetail *takeImage=[[EventsDetail alloc]init];
    
    takeImage.desc = stri;
    
    [[self navigationController]pushViewController:takeImage animated:YES];
    
}

-(UIImage*)displayImage:(NSString *)imageUrl

{
    
    if (imageUrl == (id)[NSNull null] || imageUrl.length == 0 || [imageUrl isEqualToString:@"null"]) {
        
        // NSLog(@"Null Value");
        
    }
    
    
    
    NSData* imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:imageUrl]];
    
    NSURL *url = [NSURL URLWithString:imageUrl];
    
    [asyncImageView loadImageFromURL:url];
    
    
    UIImage* image = [[UIImage alloc] initWithData:imageData];
    
    return image;
    
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnBackClicked:(UIButton *)sender {
    [[self navigationController]popViewControllerAnimated:YES];
}
@end
