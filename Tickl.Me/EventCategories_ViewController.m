//
//  EventCategories_ViewController.m
//  Tickl.Me
//
//  Created by Mountain on 2/4/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "EventCategories_ViewController.h"
#import "EventSubCategoriesViewController.h"
#import "JSON.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface EventCategories_ViewController ()
{
    BOOL flagCategorySwitchOnOff;
}
-(void)methodEventCategorySwith:(UISwitch*)sender;

-(void)methodEventCategoryOnOff:(UISwitch*)sender;
@end

@implementation EventCategories_ViewController

@synthesize tableView;

@synthesize switchOn;

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
   // NSLog(@"====>>> %@",self.navigationController.viewControllers);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    flagCategorySwitchOnOff = NO;
    
    switchOn = NO;
    
    self.title=@"Event Categories";
    
    UIBarButtonItem *rightBarButton =[[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleDone target:self action:@selector(clickEditBarButton:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    isEditing = NO;
    arrCategoriesArray = [[NSMutableArray alloc ]initWithObjects:@"Art",@"Comedy",@"Dance",@"Movies",@"Music",@"Special Events", @"Sports",@"Talks & Readings",@"Theater",nil];
    
    thumbNail = [[NSMutableArray alloc]initWithObjects:@"arts.png",@"comedy.png",@"dance.png",@"movies.png",@"music.png",@"special-event.png",@"sports.png",@"talks-and-reading.png",@"theater.png",nil];
    
    
    //***********************JSON Value******************************//
    
    arrayToEvents = [[NSMutableArray alloc]init];
    thmbImage = [[NSMutableArray alloc]init];
    uid = [[NSMutableArray alloc]init];
    array = [[NSMutableArray alloc]init];
    arr = [[NSMutableArray alloc]init];
    
    SBJSON *parser = [[SBJSON alloc]init];
    
    // Prepare URL request to download statuses from Twitter
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://108.168.203.226:8123/categories/get_event_category"]];
    
    // Perform request and get JSON back as a NSData object
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    // Get JSON as a NSString from NSData response
    NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    // parse the JSON response into an object
    // Here we're using NSArray since we're parsing an array of JSON status objects
    statuses = [parser objectWithString:json_string error:nil];
    
    // Each element in statuses is a single status
    // represented as a NSDictionary
    for (NSDictionary *status in statuses) {
        // You can retrieve individual values using objectForKey on the status NSDictionary
        
        [arrayToEvents addObject:[[status objectForKey:@"Category"]objectForKey:@"cat_name"]];
        
        [thmbImage addObject:[[status objectForKey:@"Category"]objectForKey:@"image"]];
        
        [uid addObject:[[status objectForKey:@"Category"]objectForKey:@"id"]];
        
    }
    
    //***************************************************************//
    
    

    
    arrCategoriesSelectionStatus=[[NSMutableArray alloc]initWithObjects: nil];
    for (int index=0; index<arrayToEvents.count; index++) {
        [arrCategoriesSelectionStatus addObject:@"0"];//0 means off
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)clickFilters:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickEditBarButton:(id)sender
{
    isEditing=!isEditing;
    if(isEditing)
    {
        [sender setTitle:@"Done"];
        [self.tableView setEditing:YES animated:YES];
    }
    else
    {
        [sender setTitle:@"Edit"];
        [self.tableView setEditing:NO animated:YES];
    }
}

- (IBAction)clickOnOff:(id)sender
{
}

#pragma mark - UITableView Delegate
- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // if(indexPath.section==1)
        return UITableViewCellEditingStyleNone;
   // return nil;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if(indexPath.section==1)
        return YES;
   // else
   //     return NO;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell =[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]init];
        
        lblEventName = [[UILabel alloc]initWithFrame :CGRectMake(70, 15, 195, 25)];
        lblEventName.font = [UIFont boldSystemFontOfSize:11];
        lblEventName.tag =11;
        lblEventName.backgroundColor = [UIColor clearColor];
        lblEventName.textAlignment = 0;
        [cell addSubview:lblEventName];
        
        switchBtn=[[UISwitch alloc]initWithFrame:CGRectMake(200, 15, 60, 25)];
        [switchBtn setOn:NO];
        [cell addSubview:switchBtn];
        
        imgEvent=[[UIImageView alloc]initWithFrame:CGRectMake(10, 4, 40, 40)];
        [cell addSubview:imgEvent];
        
    }
    
    if(indexPath.section==0)
    {
      
     cell.textLabel.text=@"Event categories";
        
        switchBtn.tag = 111;
        
        
    [switchBtn addTarget:self action:@selector(methodEventCategorySwith:) forControlEvents:UIControlEventValueChanged];

     cell.accessoryType=UITableViewCellAccessoryNone;   
        
    }
    
    else if(indexPath.section==1){
    
        if([[arrCategoriesSelectionStatus objectAtIndex:indexPath.row] isEqualToString:@"0"])
            switchBtn.on=NO;
        else
            switchBtn.on=YES;
    
        
        lblEventName.text=[arrayToEvents objectAtIndex:indexPath.row];
        
        cell.textLabel.font=[UIFont fontWithName:@"Hevetica-Bold" size:10];
           
        [switchBtn addTarget:self action:@selector(methodEventCategoryOnOff:) forControlEvents:UIControlEventValueChanged];
        switchBtn.tag=indexPath.row+2000;
        
        imgEvent.image=[self displayImage:[thmbImage objectAtIndex:indexPath.row]];
       
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
    
        if(flagCategorySwitchOnOff)
        {
            cell.alpha=1.0;
            cell.userInteractionEnabled=NO;
        }
        else
        {
            cell.alpha=0.3;
            cell.userInteractionEnabled=YES;
        }


    }
        
           
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==1 && flagCategorySwitchOnOff==YES && switchOn==YES){
    
        EventSubCategoriesViewController *eventSubCategories=[[EventSubCategoriesViewController alloc]initWithNibName:@"EventSubCategoriesViewController" bundle:nil];
        eventSubCategories.strMainCategoryName=[arrayToEvents objectAtIndex:indexPath.row];
        [[self navigationController]pushViewController:eventSubCategories animated:YES];
    }
    
   }
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
//
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==1)
        return 90;
    else
        return 0;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 70)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = @"Filtering by event categories cab be activated\n here. You may then activate individual\n categories and sub-categories.\nHit edit to prioritize them.";
        titleLabel.textAlignment = UITextAlignmentCenter;
        titleLabel.numberOfLines=4;
        titleLabel.font = [UIFont systemFontOfSize:15];
        return titleLabel;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section==0) {
       
        return 1;
    }
    
  return arrayToEvents.count;

}

#pragma mark Row reordering

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
	  toIndexPath:(NSIndexPath *)toIndexPath {
	NSString *item = [arrayToEvents objectAtIndex:fromIndexPath.row];
	[arrayToEvents removeObject:item];
	[arrayToEvents insertObject:item atIndex:toIndexPath.row];
}

-(UIImage*)displayImage:(NSString *)imageUrl

{
    
    if (imageUrl == (id)[NSNull null] || imageUrl.length == 0 || [imageUrl isEqualToString:@"null"]) {
        
        NSLog(@"Null Value");
        
    }
    
    NSData* imageData = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:imageUrl]];
    
    
    UIImage* image = [[UIImage alloc] initWithData:imageData];
    
    return image;
    
}


-(void)methodEventCategorySwith:(UISwitch*)sender
{
    
    if (sender.on) {
        flagCategorySwitchOnOff=YES;
        
        NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        destPath = [destPath stringByAppendingPathComponent:@"Eswitch.plist"];
        
        // If the file doesn't exist in the Documents Folder, copy it.
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if (![fileManager fileExistsAtPath:destPath]) {
            NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"Eswitch" ofType:@"plist"];
            [fileManager copyItemAtPath:sourcePath toPath:destPath error:nil];
        }
        
        NSMutableDictionary *arrValue = [[NSMutableDictionary alloc]init];
        
        [arrValue setObject:[NSNumber numberWithBool:YES] forKey:@"Eswitch"];
        
        [arrValue writeToFile:destPath atomically:YES];

    }
    else{
        
       flagCategorySwitchOnOff=NO;
    }
    
//    if (sender.on) {
//        
//        switchOn = YES;
//        
//    }
//    
//    else {
//        
//        switchOn = NO;
//    }
//    
//    NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    destPath = [destPath stringByAppendingPathComponent:@"Eswitch.plist"];
//    
//    // If the file doesn't exist in the Documents Folder, copy it.
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    
//    if (![fileManager fileExistsAtPath:destPath]) {
//        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"Eswitch" ofType:@"plist"];
//        [fileManager copyItemAtPath:sourcePath toPath:destPath error:nil];
//    }
//    
//    NSMutableDictionary *arrValue = [[NSMutableDictionary alloc]init];
//    
//    [arrValue setObject:[NSNumber numberWithBool:switchOn] forKey:@"Eswitch"];
//    
//    [arrValue writeToFile:destPath atomically:YES];
//    

//    if(!sender.on)
//    {
//        flagCategorySwitchOnOff=YES;
//    }
//    else
//    {
//        flagCategorySwitchOnOff=NO;
//    }
//    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1]  withRowAnimation:UITableViewRowAnimationFade];
}


-(void)methodEventCategoryOnOff:(UISwitch*)sender
{
    
       
    if (sender.on && flagCategorySwitchOnOff==YES) {
        
        UITableViewCell *cell = (UITableViewCell *)sender.superview;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        NSLog(@"INDEX %@",indexPath);
        
        [arr addObject:[uid objectAtIndex:indexPath.row]];
       
        NSLog(@"Inserted UID%@",arr);
        
        //Saving it
        [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"id"];
        
        //Loading it
        
        array = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
        
        
        
//        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//        [dict setObject:array forKey:@"id"];
//        
//        NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://108.168.203.226:8123/events/get_cat_data"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//               
//        ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
//        NSDictionary* postDict = [NSDictionary dictionaryWithObjectsAndKeys:array,@"id",nil];
//        NSString* jsonData = [postDict JSONRepresentation];
//        NSData* postData = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
//        [request appendPostData:postData];
//        [request setDelegate:self];
//        [request startAsynchronous];
//


        switchOn=YES;
        
    }
    
    else if(sender.on && flagCategorySwitchOnOff==NO){
        
        switchOn =NO;
    }
    
    else if([sender isOn]==NO){
        
        switchOn =NO;
    }
   
    
}


    
- (void)requestStarted:(ASIHTTPRequest *)request{
    
    NSLog(@"requestStarted%@",request);
    
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    
   NSLog(@"requestFinished%@",request);
  
    NSString *responseString=[[request responseString]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //NSLog(@"%@",[responseString JSONValue]);
    
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    
   NSLog(@"requestFailed%@",request);
    
}

-(void)getResponse:(NSString *)responseString{
    

}


@end
