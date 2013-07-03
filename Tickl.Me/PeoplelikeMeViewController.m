//
//  PeoplelikeMeViewController.m
//  Tickl.Me
//
//  Created by Saurabh Sindhu on 7/1/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "PeoplelikeMeViewController.h"
#import "JSON.h"
#import "ASIHTTPRequest.h"

@interface PeoplelikeMeViewController ()

@end

@implementation PeoplelikeMeViewController

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
    
    self.title = @"People Like Me";
    
    arrayToEvents = [[NSMutableArray alloc]init];
    uid = [[NSMutableArray alloc]init];
    array = [[NSMutableArray alloc]init];
    arr = [[NSMutableArray alloc]init];
    
    NSString *destPath1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    destPath1 = [destPath1 stringByAppendingPathComponent:@"userName.plist"];
    
    NSLog(@"tft%@",destPath1);
    
    
    NSDictionary *dictValue1 = [[NSDictionary alloc]
                                initWithContentsOfFile:destPath1];
    
    NSString *user_id = [dictValue1 objectForKey:@"userName"];
    
    NSLog(@"tft%@",user_id);

    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:user_id forKey:@"user_id"];
    
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://108.168.203.226:8123/events/get_people_like"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    ASIHTTPRequest* request1 = [ASIHTTPRequest requestWithURL:url];
    NSDictionary* postDict = [NSDictionary dictionaryWithObjectsAndKeys:user_id,@"user_id",nil];
    NSString* jsonData = [postDict JSONRepresentation];
    NSData* postData = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
    [request1 appendPostData:postData];
    [request1 setDelegate:self];
    [request1 startAsynchronous];

    
    

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
    
            [arrayToEvents addObject:[status objectForKey:@"event_name"]];
    
            [uid addObject:[status objectForKey:@"event_id"]];
            
        }
    

    
    [peopleTable reloadData];
    
    
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    
    NSLog(@"requestFailed%@",request);
    
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




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
