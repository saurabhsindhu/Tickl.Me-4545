//
//  FindEvents_ViewController.m
//  Tickl.Me
//
//  Created by Mountain on 2/4/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "FindEvents_ViewController.h"
#import "AppDelegate.h"
#import "SelectDateViewController.h"
#import "SearchResultsViewController.h"
#import "EventSubCategoriesViewController.h"
#import "EventCategories_ViewController.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"

#import "VultureCategory.h"


@interface FindEvents_ViewController ()

@end

@implementation FindEvents_ViewController

@synthesize selDate;

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
    self.title=@"Find Events";
    
    
    
    UIButton *customMenuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customMenuBtn.frame = CGRectMake(10, 7.5, 30, 30);
    [customMenuBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [customMenuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [customMenuBtn setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *leftBarButton =[[UIBarButtonItem alloc] initWithCustomView:customMenuBtn];
    self.navigationItem.leftBarButtonItem = leftBarButton;

    stringArray = [[NSArray alloc] initWithObjects:@"People Like Me",@"Vultures",@"Category",@"Price", nil];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    currentLocation = newLocation;
    currentLat =  newLocation.coordinate.latitude;
    currentLong =  newLocation.coordinate.longitude;
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
    
    NSLog(@"%@",selDate.navC);
    
    
    
    NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    destPath = [destPath stringByAppendingPathComponent:@"dateRange.plist"];
    
    NSLog(@"tft%@",destPath);
    
    
    NSDictionary *dictValue = [[NSDictionary alloc]
                               initWithContentsOfFile:destPath];
    
    
    strVal = [dictValue objectForKey:@"startVal"];
    
    endVal = [dictValue objectForKey:@"endVal"];
    
    if (strVal != nil && endVal != nil)
        
    {
        
        NSLog(@"JSON String%@%@",strVal,endVal);
        
        NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://108.168.203.226:8123/events/get_date_events"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
        NSDictionary* postDict = [NSDictionary dictionaryWithObjectsAndKeys:strVal,@"startDate",endVal,@"endDate",nil];
        
        NSString* jsonData = [postDict JSONRepresentation];
        NSData* postData = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
        [request appendPostData:postData];
        [request setDelegate:self];
        [request startAsynchronous];
        
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.//[MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
}

#pragma mark
#pragma UISearchBarDelegate - 

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://108.168.203.226:8123/events/get_search_data"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    NSDictionary* postDict = [NSDictionary dictionaryWithObjectsAndKeys:searchBar.text,@"keyword",nil];
    NSString* jsonData = [postDict JSONRepresentation];
    NSData* postData = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
    [request appendPostData:postData];
    [request setDelegate:self];
    [request startAsynchronous];
    
    [searchBar resignFirstResponder];
    
    
    
}


- (IBAction)costRangeButtonClicked:(UISegmentedControl *)sender {
}

- (IBAction)clickSearch:(id)sender {
    
           SearchResultsViewController *searchRC=[[SearchResultsViewController alloc]initWithNibName:@"SearchResultsViewController" bundle:nil];
  
            searchRC.strVal = responseString;

           [[self navigationController]pushViewController:searchRC animated:YES];
    
}

#pragma mark

-(IBAction)sliderValue:(id)sender{
    
    
    NSString *lat = [NSString stringWithFormat:@"%.3f", currentLat];
    
    NSString *longit = [NSString stringWithFormat:@"%.3f", currentLong];
    
    
    NSLog(@"%f",slide.value);
    
    if (slide.value >0.23 && slide.value < 0.25) {
        
        NSInteger five;
        
        five= 5;
        
        NSLog(@"%i LAT%f LONG%f",five,currentLat,currentLong);
        
        NSString *val1 = [NSString stringWithFormat:@"%i",five];
        
        
        NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://108.168.203.226:8123/events/get_mile_events"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
        NSDictionary* postDict = [NSDictionary dictionaryWithObjectsAndKeys:lat,@"lat",longit,@"long",val1,@"miles",nil];
        
        NSString* jsonData = [postDict JSONRepresentation];
        NSData* postData = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
        [request appendPostData:postData];
        [request setDelegate:self];
        [request startAsynchronous];

        
    }
    
    if (slide.value >0.48 && slide.value < 0.50) {
        
        NSInteger ten;
        
        ten= 10;
        
        NSLog(@"%i LAT%f LONG%f",ten,currentLat,currentLong);
        
        NSString *val2 = [NSString stringWithFormat:@"%i",ten];
        
        
        NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://108.168.203.226:8123/events/get_mile_events"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
        NSDictionary* postDict = [NSDictionary dictionaryWithObjectsAndKeys:lat,@"lat",longit,@"long",val2,@"miles",nil];
        
        NSString* jsonData = [postDict JSONRepresentation];
        NSData* postData = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
        [request appendPostData:postData];
        [request setDelegate:self];
        [request startAsynchronous];


    }
    
    if (slide.value >0.73 && slide.value < 0.75) {
        
        NSInteger fiften;
        
        fiften= 15;
        
        NSLog(@"%i LAT%f LONG%f",fiften,currentLat,currentLong);
        
        NSString *val3 = [NSString stringWithFormat:@"%i",fiften];
        
        
        NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://108.168.203.226:8123/events/get_mile_events"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
        NSDictionary* postDict = [NSDictionary dictionaryWithObjectsAndKeys:lat,@"lat",longit,@"long",val3,@"miles",nil];
        
        NSString* jsonData = [postDict JSONRepresentation];
        NSData* postData = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
        [request appendPostData:postData];
        [request setDelegate:self];
        [request startAsynchronous];

        
    }
    
    if (slide.value == 1.0) {
        
        NSInteger fifty;
        
        fifty= 50;
        
       NSLog(@"%i LAT%f LONG%f",fifty,currentLat,currentLong);
        
        NSString *val4 = [NSString stringWithFormat:@"%i",fifty];
        
        
        NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://108.168.203.226:8123/events/get_mile_events"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
        NSDictionary* postDict = [NSDictionary dictionaryWithObjectsAndKeys:lat,@"lat",longit,@"long",val4,@"miles",nil];
        
        NSString* jsonData = [postDict JSONRepresentation];
        NSData* postData = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
        [request appendPostData:postData];
        [request setDelegate:self];
        [request startAsynchronous];

        
    }

    
}


#pragma mark ASIHTTPReq Delegate
- (void)requestStarted:(ASIHTTPRequest *)request{
    
    NSLog(@"requestStarted%@",request);
    
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    
    NSLog(@"requestFinished%@",request);
    
    responseString=[[request responseString]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@"Response %@",responseString);
    
//    if (responseString==nil) {
//        
//        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    }
//    
//    else {
//       
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        
//    }
    

}

- (void)requestFailed:(ASIHTTPRequest *)request{
    
    NSLog(@"requestFailed%@",request);
    
}



- (IBAction)clickFree:(id)sender {
}

- (IBAction)click1_49:(id)sender {
}

- (IBAction)click50_99:(id)sender {
}

- (IBAction)click100:(id)sender {
}

- (void)backBtnClicked {
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    [appDelegate showMenu];
}

#pragma mark - UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
       
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}

    if (indexPath.section == 0) {
        
        cell.textLabel.text = [stringArray objectAtIndex:indexPath.row];
        
        
               
    }
    else {
       
        cell.textLabel.text = @"Date Range";
        
//        NSLog(@"%@",strVal);
//        startDate =[[NSMutableString alloc]initWithString:strVal];
//        endDate =[[NSMutableString alloc]initWithString:endVal];
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",startDate,endDate];
//        cell.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:10];
       
       
    }
    
    if (indexPath.section == 0 && indexPath.row==3) {
        
        switchBtn=[[UISwitch alloc]initWithFrame:CGRectMake(200, 03, 60, 25)];
        [switchBtn setOn:NO];
        [cell addSubview:switchBtn];
        switchBtn.tag = 112;
        
        [switchBtn addTarget:self action:@selector(methodPriceCategorySwith:) forControlEvents:UIControlEventValueChanged];
        
    }

    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section==0)
    {
        if (indexPath.row == 0) {
            EventSubCategoriesViewController *eventSub=[[EventSubCategoriesViewController alloc]initWithNibName:@"EventSubCategoriesViewController" bundle:nil];
            eventSub.strMainCategoryName=@"People Like Me";
            [self.navigationController pushViewController:eventSub animated:YES];
            
        }
        else if (indexPath.row == 1){
            VultureCategory *eventSub=[[VultureCategory alloc]initWithNibName:@"VultureCategory" bundle:nil];
            [self.navigationController pushViewController:eventSub animated:YES];
            
        }
        else if (indexPath.row == 2){
            EventCategories_ViewController *event =  [[EventCategories_ViewController alloc] initWithNibName:@"EventCategories_ViewController" bundle:nil];
            [self.navigationController pushViewController:event animated:YES];
        }
        
        else if (indexPath.row == 3){
            
            
            
        }

    }
    else if(indexPath.section==1)
    {
        if(indexPath.row==0)
        {
               SelectDateViewController *setDate=[[SelectDateViewController alloc]initWithNibName:@"SelectDateViewController" bundle:nil];
            [[self navigationController]pushViewController:setDate animated:YES];
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 32;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }
    else
        return 1;
    return 0;
}

-(void)methodPriceCategorySwith:(id)sender{
    
    if ([sender isOn]==YES) {
        
        
        NSString *price = @"price";
        
    
        NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://108.168.203.226:8123/events/get_price_data/"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
        NSDictionary* postDict = [NSDictionary dictionaryWithObjectsAndKeys:price,@"1",nil];
        
        NSString* jsonData = [postDict JSONRepresentation];
        NSData* postData = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
        [request appendPostData:postData];
        [request setDelegate:self];
        [request startAsynchronous];

              
    }
    
    else if ([sender isOn]==NO){
      
        NSString *price = @"price";
        
        
        NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://108.168.203.226:8123/events/get_price_data/"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
        NSDictionary* postDict = [NSDictionary dictionaryWithObjectsAndKeys:price,@"0",nil];
        
        NSString* jsonData = [postDict JSONRepresentation];
        NSData* postData = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
        [request appendPostData:postData];
        [request setDelegate:self];
        [request startAsynchronous];
        

        
        
    }
    
    
}



@end
