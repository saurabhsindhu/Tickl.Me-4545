//
//  EventSubCategoriesViewController.m
//  Tickl.Me
//
//  Created by Prakash Joshi on 5/1/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "EventSubCategoriesViewController.h"
#import "JSON.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@interface EventSubCategoriesViewController ()
{
    NSMutableArray *arrSubCategories;
    int i;
}
@end

@implementation EventSubCategoriesViewController
@synthesize strMainCategoryName;
@synthesize filterArray;


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
    self.title=self.strMainCategoryName;
    
    NSLog(@"cscsvd%@",self.title);
    
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    path = [path stringByAppendingPathComponent:@"filter.plist"];

    
    //***********************JSON Value******************************//
    
    arrayToEvents = [[NSMutableArray alloc]init];
    thmbImage = [[NSMutableArray alloc]init];
    uid = [[NSMutableArray alloc]init];
    parArr = [[NSMutableArray alloc]init];
    insertVal = [[NSMutableArray alloc]init];
    insertUID = [[NSMutableArray alloc]init];
    arr = [[NSMutableArray alloc]init];
    array = [[NSMutableArray alloc]init];
    
    SBJSON *parser = [[SBJSON alloc]init];
    
    // Prepare URL request to download statuses from Twitter
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://108.168.203.226:8123/categories/get_event_subcategory"]];
    
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
        
        [parArr addObject:[[status objectForKey:@"Category"]objectForKey:@"pcat_name"]];
        
    }
    
    //***************************************************************//
    
   // NSLog(@"VALUEEE%@",parArr);
    
    for (i = 0; i < [parArr count]; i++) {
        
               
        if([self.strMainCategoryName isEqualToString:[parArr objectAtIndex:i]]){
            
           // insertVal=[arrayToEvents objectAtIndex:i];
            [insertVal addObject:[arrayToEvents objectAtIndex:i]];
            [insertUID addObject:[uid objectAtIndex:i]];
            
          //  NSLog(@"%@%@",self.strMainCategoryName, insertVal);
            

        }


        
    }
    
    
   // NSLog(@"XYZ%@",insertVal);
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell =nil;// [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [insertVal objectAtIndex:indexPath.row];
    
  
    cell.accessoryType=UITableViewCellAccessoryNone;
    
        
    return cell;
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    if(cell.accessoryType==UITableViewCellAccessoryCheckmark){
         [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
    }
    else if(cell.accessoryType==UITableViewCellAccessoryNone){
         [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
        
        
        [arr addObject:[insertUID objectAtIndex:indexPath.row]];
       // NSLog(@"Inserted UID%@",arr);
        
        //Saving it
        [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"id"];
        
        //Loading it
        
        array = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
        
        
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:array forKey:@"id"];
        
        //NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:&error];
        
              
        NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://108.168.203.226:8123/events/get_event_data"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
//        //[request setPostValue:[arr JSONRepresentation] forKey:@"id"];
//        [request setPostValue:dict forKey:@"id"];
//        NSLog(@"%@",array);
//        [request setDelegate:self];
//        [request startAsynchronous];
        
        ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
        NSDictionary* postDict = [NSDictionary dictionaryWithObjectsAndKeys:array,@"id",nil];
       // NSDictionary* data = [NSDictionary dictionaryWithObject:postDict forKey:@"id"];
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
   
    return insertVal.count;

}

#pragma mark ASIHTTPReq Delegate
- (void)requestStarted:(ASIHTTPRequest *)request{
    
   // NSLog(@"requestStarted%@",request);
    
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    
   // NSLog(@"requestFinished%@",request);
    
    NSString *responseString=[[request responseString]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
   // NSLog(@"Response %@",responseString);
    
    NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    destPath = [destPath stringByAppendingPathComponent:@"filter.plist"];
    
    // If the file doesn't exist in the Documents Folder, copy it.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:destPath]) {
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"filter" ofType:@"plist"];
        [fileManager copyItemAtPath:sourcePath toPath:destPath error:nil];
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    [dict setObject:responseString forKey:@"Filter"];
    
    [dict writeToFile:destPath atomically:YES];
    
        
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
