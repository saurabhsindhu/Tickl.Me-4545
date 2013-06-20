//
//  VultureCategory.m
//  Tickl.Me
//
//  Created by Saurabh Sindhu on 6/11/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "VultureCategory.h"
#import "JSON.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface VultureCategory ()

@end

@implementation VultureCategory

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
    
    self.title = @"Vultures";
    
    arrayToEvents = [[NSMutableArray alloc]init];
    uid = [[NSMutableArray alloc]init];
    array = [[NSMutableArray alloc]init];
    arr = [[NSMutableArray alloc]init];
    
    SBJSON *parser = [[SBJSON alloc]init];
    
    // Prepare URL request to download statuses from Twitter
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://108.168.203.226:8123/vultures/get_vulture_category/"]];
    
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
        
        [arrayToEvents addObject:[[status objectForKey:@"Vulture"]objectForKey:@"vulture_name"]];
        
        [uid addObject:[[status objectForKey:@"Vulture"]objectForKey:@"id"]];
        
    }

    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell =nil;// [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [arrayToEvents objectAtIndex:indexPath.row];
    
    
    cell.accessoryType=UITableViewCellAccessoryNone;
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if(cell.accessoryType==UITableViewCellAccessoryCheckmark){
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    else if(cell.accessoryType==UITableViewCellAccessoryNone){
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
        
        [arr addObject:[uid objectAtIndex:indexPath.row]];
        NSLog(@"Inserted UID%@",arr);
        
        //Saving it
        [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"id"];

            
        //Loading it
        
        array = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
        
        
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:array forKey:@"id"];
             
        NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://108.168.203.226:8123/events/get_vulture_data"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
             
        ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
        NSDictionary* postDict = [NSDictionary dictionaryWithObjectsAndKeys:array,@"id",nil];
        NSString* jsonData = [postDict JSONRepresentation];
        NSData* postData = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
        [request appendPostData:postData];
        [request setDelegate:self];
        [request startAsynchronous];
        
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return arrayToEvents.count;
    
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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
