//
//  SearchResultsViewController.m
//  Tickl.Me
//
//  Created by Prakash Joshi on 4/29/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "SearchResultsViewController.h"
#import "DataMyEvent.h"
#import "TakePicEventPlaceViewController.h"
#import "AppDelegate.h"
#import "MapView_ViewController.h"
#import "AsyncImageView.h"
#import "JSON.h"
#import "MBProgressHUD.h"

#define ASYNC_IMAGE_TAG 9999


@interface SearchResultsViewController ()
{
    DataMyEvent *objMyEvent;
   
}
@end

@implementation SearchResultsViewController

@synthesize strVal;

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
    // Do any additional setup after loading the view from its nib.
    self.title=@"Search Results";
    
    NSLog(@"STRING VAL %@",strVal);
    
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

    arrTotalEvent=[[NSMutableArray alloc]initWithObjects: nil];
    
    SBJSON *parser = [[SBJSON alloc]init];
    statuses = [parser objectWithString:strVal error:nil];
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

    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor=[UIColor whiteColor];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayToEvents.count;
    NSLog(@"%u",arrayToEvents.count);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    asyncImageView = nil;
    
	NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell	*cell = [tableSearchResults dequeueReusableCellWithIdentifier:cellIdentifier];
    // objMyEvent=(DataMyEvent*)[arrTotalEvent objectAtIndex:indexPath.row];
    cell=nil;
    
    if(cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        
        CGRect frame;
        frame.origin.x = 5;
        frame.origin.y = 5;
        frame.size.width = 56;
        frame.size.height = 43;
        asyncImageView = [[AsyncImageView alloc] initWithFrame:frame];//61;48
        asyncImageView.tag = ASYNC_IMAGE_TAG;
        [cell.contentView addSubview:asyncImageView];
        frame.origin.x = 52 + 10;
        frame.size.width = 200;
        
        UIImageView *imgEvent=[[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 45, 45)];
        //imgEvent.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",objMyEvent.Dayimg]];
        //imgEvent.image=[UIImage imageNamed:[thumImages objectAtIndex:14]];
        //imgEvent.image=[thmbImage objectAtIndex:indexPath.row];
        imgEvent.image=[self displayImage:[thmbImage objectAtIndex:indexPath.row]];
        // [cell addSubview:imgEvent];
        //NSURL *url = [NSURL URLWithString:[thmbImage objectAtIndex:indexPath.row]];
        //[asyncImageView loadImageFromURL:url];
        
        
        
        UILabel *lblEventTime = [[UILabel alloc]initWithFrame :CGRectMake(185, 50, 80, 25)];
        lblEventTime.font = [UIFont boldSystemFontOfSize:13];
        lblEventTime.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
        lblEventTime.tag =11;
        lblEventTime.backgroundColor = [UIColor clearColor];
        //NSString* foo = @"safgafsfhsdhdfs gfdgdsgsdggdfsgsdgsd";
        //NSArray* stringComponents = [foo componentsSeparatedByString:@" "];
        
        
        
        lblEventTime.text=[eventShedule objectAtIndex:indexPath.row];
        UIFont *myFont1 = [ UIFont fontWithName: @"Arial" size: 10.0 ];
        lblEventTime.font  = myFont1;
        lblEventTime.textAlignment = 0;
        [cell addSubview:lblEventTime];
        
        // NSLog(@"Shedule%@",eventShedule);
        
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
        
        
        UILabel *lblEventName = [[UILabel alloc]initWithFrame :CGRectMake(70, 5, 195, 25)];
        lblEventName.font = [UIFont boldSystemFontOfSize:13];
        lblEventName.tag =11;
        lblEventName.backgroundColor = [UIColor clearColor];
        lblEventName.text=[arrayToEvents objectAtIndex:indexPath.row];
        // cell.textLabel.text = [arrayToEvents objectAtIndex:indexPath.row];
        
        
        lblEventName.textAlignment = 0;
        [cell addSubview:lblEventName];
        
        UILabel *lblEventSubDetails = [[UILabel alloc]initWithFrame :CGRectMake(15, 52, 165, 25)];
        lblEventSubDetails.font = [UIFont boldSystemFontOfSize:13];
        lblEventSubDetails.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
        lblEventSubDetails.tag =11;
        lblEventSubDetails.backgroundColor = [UIColor clearColor];
        lblEventSubDetails.text=[venueAddress objectAtIndex:indexPath.row];
        //cell.detailTextLabel.text = [arrayToDesc objectAtIndex:indexPath.row];
        
        UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 10.0 ];
        lblEventSubDetails.font  = myFont;
        
        
        lblEventSubDetails.textAlignment = 0;
        [cell addSubview:lblEventSubDetails];
        
    }
    
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
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


- (void)backBtnClicked:(UIButton *)sender {
    [[self navigationController]popViewControllerAnimated:YES];
}


@end
