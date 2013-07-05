//
//  MyEvents_ViewController.m
//  Tickl.Me
//
//  Created by Mountain on 2/8/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "MyEvents_ViewController.h"
#import "AppDelegate.h"
#import "DataMyEvent.h"
#import "AddEventViewController.h"
#import "FriendRequestAndEvetnInVitaiaionViewController.h"
#import "EventsDetailView.h"
#import "JSON.h"

#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#define ASYNC_IMAGE_TAG 9999

@interface MyEvents_ViewController ()

@end

@implementation MyEvents_ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
       
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   
    self.title=@"My Events";
    
     arrayToEvents = [[NSMutableArray alloc]init];
     arrayToVenu = [[NSMutableArray alloc]init];
     thmbImage = [[NSMutableArray alloc]init];
     eventShedule = [[NSMutableArray alloc]init];
    
    UIBarButtonItem *rightBarButton =[[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleDone target:self action:@selector(clickEdit:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    UIButton *customMenuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customMenuBtn.frame = CGRectMake(10, 7.5, 30, 30);
    [customMenuBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [customMenuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [customMenuBtn setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    
    NSString *destPath1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    destPath1 = [destPath1 stringByAppendingPathComponent:@"userName.plist"];
    
    NSLog(@"tft%@",destPath1);
    
    
    NSDictionary *dictValue1 = [[NSDictionary alloc]
                                initWithContentsOfFile:destPath1];
    
    NSString *user_id = [dictValue1 objectForKey:@"userName"];
    
    NSLog(@"tft%@",user_id);
    
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:user_id forKey:@"user_id"];
    
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://108.168.203.226:8123/events/show_my_events"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    ASIHTTPRequest* request1 = [ASIHTTPRequest requestWithURL:url];
    NSDictionary* postDict = [NSDictionary dictionaryWithObjectsAndKeys:user_id,@"user_id",nil];
    NSString* jsonData = [postDict JSONRepresentation];
    NSData* postData = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
    [request1 appendPostData:postData];
    [request1 setDelegate:self];
    [request1 startAsynchronous];
    
    UIBarButtonItem *leftBarButton =[[UIBarButtonItem alloc] initWithCustomView:customMenuBtn];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    myActivityIndicator=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [myActivityIndicator setFrame:CGRectMake(140, 170, 40, 40)];
    [self.view addSubview:myActivityIndicator];
    [myActivityIndicator startAnimating];
    

    
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
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell	*cell = [tblMyEvents dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell=nil;
    
    asyncImageView = nil;
       

    
    if(cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        
      
        if (arrayToEvents != nil) {
            
            [myActivityIndicator stopAnimating];
        }
        
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
        
        imgEvent.image=[self displayImage:[thmbImage objectAtIndex:indexPath.row]];
               
        
//        UILabel *lblEventTime = [[UILabel alloc]initWithFrame :CGRectMake(85, 15, 80, 25)];
//        lblEventTime.font = [UIFont boldSystemFontOfSize:13];
//        lblEventTime.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
//        lblEventTime.tag =11;
//        lblEventTime.backgroundColor = [UIColor clearColor];
//        lblEventTime.text=[NSString stringWithFormat:@"%@",eventShedule];
//        lblEventTime.textAlignment = 0;
//        [cell addSubview:lblEventTime];
        
        
        
        UILabel *lblEventName = [[UILabel alloc]initWithFrame :CGRectMake(85, 25, 200, 25)];
        lblEventName.font = [UIFont boldSystemFontOfSize:9];
        lblEventName.tag =11;
        lblEventName.backgroundColor = [UIColor clearColor];
        lblEventName.text=[arrayToEvents objectAtIndex:indexPath.row];
        [cell addSubview:lblEventName];
        
        
        UILabel *lblEventSubDetails = [[UILabel alloc]initWithFrame :CGRectMake(85, 36, 200, 25)];
        lblEventSubDetails.font = [UIFont boldSystemFontOfSize:9];
        //lblEventSubDetails.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
        lblEventSubDetails.tag =12;
        lblEventSubDetails.backgroundColor = [UIColor clearColor];
        lblEventName.text=[arrayToVenu objectAtIndex:indexPath.row];
        [cell addSubview:lblEventSubDetails];
        
    }
   // cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    EventsDetailView *objFriendList = [[EventsDetailView alloc] initWithNibName:@"EventsDetailView" bundle:nil];
    [self.navigationController  pushViewController:objFriendList animated:YES];
//    FriendRequestAndEvetnInVitaiaionViewController*friendRequest=[[FriendRequestAndEvetnInVitaiaionViewController alloc]initWithNibName:@"FriendRequestAndEvetnInVitaiaionViewController" bundle:nil];
//        [self.navigationController pushViewController:friendRequest animated:YES];
    
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


#pragma mark ASIHTTPReq Delegate
- (void)requestStarted:(ASIHTTPRequest *)request{
    
    NSLog(@"requestStarted%@",request);
    
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    
    NSLog(@"requestFinished%@",request);
    
    
    NSString *responseString=[[request responseString]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSLog(@"Response %@",responseString);
    
    SBJSON *parser = [[SBJSON alloc]init];
    
    // Here we're using NSArray since we're parsing an array of JSON status objects
    statuses = [parser objectWithString:responseString error:nil];
    
    // Each element in statuses is a single status
    // represented as a NSDictionary
    for (NSDictionary *status in statuses) {
        // You can retrieve individual values using objectForKey on the status NSDictionary
        
        
        [arrayToEvents addObject:[[status objectForKey:@"Event"]objectForKey:@"event_name"]];
        
        [arrayToVenu addObject:[[status objectForKey:@"Venue"]objectForKey:@"venue_name"]];
        
        [thmbImage addObject:[[status objectForKey:@"Venue"]objectForKey:@"thumbnail"]];
        
        [eventShedule addObject:[[status objectForKey:@"MyEvent"]objectForKey:@"date"]];
        
            
        [venueAddress addObject:[[status objectForKey:@"Venue"]objectForKey:@"address"]];
        
              
    }
    
    NSLog(@"%@",arrayToEvents);
    
  
    [tblMyEvents reloadData];
    
    
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    
    NSLog(@"requestFailed%@",request);
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickAddToCalendar:(id)sender {
        AddEventViewController *objFriendList = [[AddEventViewController alloc] initWithNibName:@"AddEventViewController" bundle:nil];
    [self.navigationController  pushViewController:objFriendList animated:YES];

}

- (IBAction)clickToday:(id)sender {
}

- (void)backBtnClicked {
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app showMenu];
}

- (void)clickEdit:(id)sender
{
    UIBarButtonItem *btn=(UIBarButtonItem*)sender;
    if([btn.title isEqualToString:@"Edit"])
    {
    [tblMyEvents setEditing:YES animated:YES];
    [btn setTitle:@"Done"];
    }
    else
    {
        [tblMyEvents setEditing:NO animated:YES];
         [btn setTitle:@"Edit"];
    }
 
}
@end
