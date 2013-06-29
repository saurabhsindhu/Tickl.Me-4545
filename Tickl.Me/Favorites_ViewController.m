//
//  Favorites_ViewController.m
//  Tickl.Me
//
//  Created by Mountain on 2/1/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "Favorites_ViewController.h"
#import "Notification_ViewController.h"
#import "MapView_ViewController.h"
#import "AppDelegate.h"
#import "FacebookManager.h"
#import "JSON.h"
#import "ASIHTTPRequest.h"

@interface Favorites_ViewController ()
{
    NSString *clickedSegmentBarTitle;
}
@end

@implementation Favorites_ViewController

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
    NSLog(@"====>>> %@",self.navigationController.viewControllers);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    copyListOfItems = [[NSMutableArray alloc] init];
    searchTable.autocorrectionType = UITextAutocorrectionTypeNo;
	
	searching = NO;
	letUserSelectRow = YES;
    
    
    fbMgr = [FacebookManager sharedInstance];
    
     NSLog(@"%@",fbMgr.responseString);
    
    
    SBJSON *parser = [[SBJSON alloc]init];
    
    statuses = [parser objectWithString:fbMgr.responseString error:nil];
    
    arrayToMusic = [[NSMutableArray alloc]init];
    
    arrayToMusic = [arrayToMusic mutableCopy];
    
    arrayToSports = [[NSMutableArray alloc]init];
    
    musicID = [[NSMutableArray alloc]init];
    
    sportsID = [[NSMutableArray alloc]init];
    
    searchData = [[NSMutableArray alloc] init];
    
   
    NSLog(@"Array Contents: %@", [statuses valueForKey:@"Sport"]);
    NSLog(@"Array Count: %d", [statuses count]);
    
    arrayToSports = [[statuses valueForKey:@"Sport"]valueForKey:@"perf_name"];
    
    arrayToMusic = [[statuses valueForKey:@"Music"]valueForKey:@"perf_name"];
    
    musicID = [[statuses valueForKey:@"Music"]valueForKey:@"like_id"];
    
    sportsID = [[statuses valueForKey:@"Sport"]valueForKey:@"like_id"];
   
    NSLog(@"Array Count: %@", arrayToSports);
       
    clickedSegmentBarTitle=@"performers";
    self.title=@"Favorites";
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if(app.isFirstRun)
    {
   
    UIBarButtonItem *rightBarButton =[[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(clickNext:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
        btnSkip.hidden=NO;
    }
    else
    {
        btnSkip.hidden=YES;
    }
    arrPerformers=[[NSMutableArray alloc]initWithObjects: nil];
    arrTeams=[[NSMutableArray alloc]initWithObjects: nil];
    
    for (int index=0; index<10; index++) {
        objPerformers=[[dataPerformers alloc]init];
        objTeams=[[dataTeams alloc]init];
        
        objPerformers.pID=@"id";
        objPerformers.pAge=@"23";
        objPerformers.pBest=@"Best";
        objPerformers.pName=@"pName";
        objPerformers.pGame=@"Game";
        
        [arrPerformers addObject:objPerformers];
        
        objTeams.tID=@"id";
        objTeams.tAge=@"age";
        objTeams.tBest=@"best";
        objTeams.tGame=@"game";
        objTeams.tName=@"tName";
        
        [arrTeams addObject:objTeams];
    }
//    suffixArray = [[NSMutableArray alloc] initWithObjects:@"{search}", @"#", @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"K", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
	
	if(searching)
		return nil;
	
	NSMutableArray *tempArray = [[NSMutableArray alloc] init];
	[tempArray addObject:@"A"];
	[tempArray addObject:@"B"];
	[tempArray addObject:@"C"];
	[tempArray addObject:@"D"];
	[tempArray addObject:@"E"];
	[tempArray addObject:@"F"];
	[tempArray addObject:@"G"];
	[tempArray addObject:@"H"];
	[tempArray addObject:@"I"];
	[tempArray addObject:@"J"];
	[tempArray addObject:@"K"];
	[tempArray addObject:@"L"];
	[tempArray addObject:@"M"];
	[tempArray addObject:@"N"];
	[tempArray addObject:@"O"];
	[tempArray addObject:@"P"];
	[tempArray addObject:@"Q"];
	[tempArray addObject:@"R"];
	[tempArray addObject:@"S"];
	[tempArray addObject:@"T"];
	[tempArray addObject:@"U"];
	[tempArray addObject:@"V"];
	[tempArray addObject:@"W"];
	[tempArray addObject:@"X"];
	[tempArray addObject:@"Y"];
	[tempArray addObject:@"Z"];
    
	return tempArray;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)clickNext:(id)sender
{
//    MapView_ViewController *map = [[MapView_ViewController alloc] init];
//    [self.navigationController pushViewController:map animated:YES];
    Notification_ViewController *notif = [[Notification_ViewController alloc] init];
    [self.navigationController pushViewController:notif animated:YES];
}

- (IBAction)clickSkip:(id)sender
{
    MapView_ViewController *map = [[MapView_ViewController alloc] init];
    [self.navigationController pushViewController:map animated:YES];
}

- (IBAction)clickOK:(id)sender
{
    self.welcomeView.hidden = YES;
}

- (IBAction)btnEditToolbarClicked:(UIButton *)sender {
        if([sender.titleLabel.text isEqualToString:@"Edit"])
        {
            [tableListView setEditing:YES animated:YES];
            [sender setTitle:@"Done" forState:UIControlStateNormal];
            btnSkip.hidden=YES;
        }
        else
        {
            [tableListView setEditing:NO animated:YES];
            [sender setTitle:@"Edit" forState:UIControlStateNormal];
             btnSkip.hidden=NO;
        }

}
- (IBAction)topSegmentControllClicked:(UISegmentedControl*)sender {
    if(sender.selectedSegmentIndex == 0) {
        clickedSegmentBarTitle=@"performers";
        NSLog(@"action for the first button (All)");
        [tableListView reloadData];
    }else if(sender.selectedSegmentIndex == 1){
        clickedSegmentBarTitle=@"teams";
        NSLog(@"action for the second button (Present)");
        [tableListView reloadData];
    }
}

#pragma mark - TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;//[suffixArray count];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
	if(searching)
		return -1;
	
	return index % 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
    
    if (searching) {
        
       cell.textLabel.text=[copyListOfItems objectAtIndex:indexPath.row]; 
    }
    
    if([clickedSegmentBarTitle isEqualToString:@"performers"])
    {
        
         //objPerformers=[fbMgr.myLikes objectAtIndex:indexPath.row];
       NSLog(@"%@",arrayToMusic);
        
       cell.textLabel.text=[arrayToMusic objectAtIndex:indexPath.row];
    }
    
    else if([clickedSegmentBarTitle isEqualToString:@"teams" ])
    {
        cell.textLabel.text=[arrayToSports objectAtIndex:indexPath.row];

    }
    
    return cell;
}
- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (searching)
		return [copyListOfItems count];
    
    if([clickedSegmentBarTitle isEqualToString:@"performers"])
        return arrayToMusic.count;
     if([clickedSegmentBarTitle isEqualToString:@"teams"])
         return arrayToSports.count;
    
    return 0;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing  animated:animated];
    [tableListView setEditing:editing animated:YES];
}
- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell=[tableListView cellForRowAtIndexPath:indexPath];
    if (cell.editingStyle == UITableViewCellEditingStyleDelete)
	{
        
        [musicID objectAtIndex:indexPath.row];
        if([clickedSegmentBarTitle isEqualToString:@"performers"])
        {
            
          NSLog(@"%@", [musicID objectAtIndex:indexPath.row]);
            
            NSString *mID = [musicID objectAtIndex:indexPath.row];
            
            NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://108.168.203.226:8123/categories/get_delete_like"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
            NSDictionary* postDict = [NSDictionary dictionaryWithObjectsAndKeys:mID,@"like_id",nil];
            
            NSString* jsonData = [postDict JSONRepresentation];
            NSData* postData = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
            [request appendPostData:postData];
            [request setDelegate:self];
            
                       
            [request startAsynchronous];
            
         
            
            [super setEditing:YES animated:YES];
            [tableListView setEditing:YES animated:NO];
            
            [tableListView reloadData];
            
        }
            else if([clickedSegmentBarTitle isEqualToString:@"teams" ])
        {
            NSLog(@"%@", [sportsID objectAtIndex:indexPath.row]);
            
             NSString *sID = [sportsID objectAtIndex:indexPath.row];
            
            NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://108.168.203.226:8123/categories/get_delete_like"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
            NSDictionary* postDict = [NSDictionary dictionaryWithObjectsAndKeys:sID,@"like_id",nil];
            
            NSString* jsonData = [postDict JSONRepresentation];
            NSData* postData = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
            [request appendPostData:postData];
            [request setDelegate:self];
            [request startAsynchronous];
        
            
          // [arrayToSports removeObjectAtIndex:indexPath.row];
        }
        
       
	}
    
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



#pragma UISearchBar delegate

#pragma mark -
#pragma mark Search Bar

//- (void) searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
//	
//	//This method is called again when the user clicks back from teh detail view.
//	//So the overlay is displayed on the results, which is something we do not want to happen.
//	if(searching)
//		return;
//	
//	//Add the overlay view.
//	if(ovController == nil)
//		ovController = [[OverlayViewController alloc] initWithNibName:@"OverlayView" bundle:[NSBundle mainBundle]];
//	
//	CGFloat yaxis = self.navigationController.navigationBar.frame.size.height;
//	CGFloat width = self.view.frame.size.width;
//	CGFloat height = self.view.frame.size.height;
//	
//	//Parameters x = origion on x-axis, y = origon on y-axis.
//	CGRect frame = CGRectMake(0, yaxis, width, height);
//	ovController.view.frame = frame;
//	ovController.view.backgroundColor = [UIColor grayColor];
//	ovController.view.alpha = 0.5;
//	
//	ovController.rvController = self;
//	
//	[self.tableView insertSubview:ovController.view aboveSubview:self.parentViewController.view];
//	
//	searching = YES;
//	letUserSelectRow = NO;
//	self.tableView.scrollEnabled = NO;
//	
//	//Add the done button.
//	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
//											   initWithBarButtonSystemItem:UIBarButtonSystemItemDone
//											   target:self action:@selector(doneSearching_Clicked:)];
//	
//}
//
//- (void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *)searchText {
//    
//	//Remove all objects first.
//	[copyListOfItems removeAllObjects];
//	
//	if([searchText length] > 0) {
//		
//		[ovController.view removeFromSuperview];
//		searching = YES;
//		letUserSelectRow = YES;
//		self.tableView.scrollEnabled = YES;
//		[self searchTableView];
//	}
//	else {
//		
//		[self.tableView insertSubview:ovController.view aboveSubview:self.parentViewController.view];
//		
//		searching = NO;
//		letUserSelectRow = NO;
//		self.tableView.scrollEnabled = NO;
//	}
//	
//	[self.tableView reloadData];
//}
//
//- (void) searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
//	
//	[self searchTableView];
//}
//
//- (void) searchTableView {
//	
//	NSString *searchText = searchTable.text;
//	NSMutableArray *searchArray = [[NSMutableArray alloc] init];
//	
//	for (NSDictionary *dictionary in arrayToMusic)
//	{
//		NSArray *array1 = [dictionary objectForKey:@"Countries"];
//		[searchArray addObjectsFromArray:array1];
//	}
//	
//	for (NSString *sTemp in searchArray)
//	{
//		NSRange titleResultsRange = [sTemp rangeOfString:searchText options:NSCaseInsensitiveSearch];
//		
//		if (titleResultsRange.length > 0)
//			[copyListOfItems addObject:sTemp];
//	}
//	
//}
//
//- (void) doneSearching_Clicked:(id)sender {
//	
//	searchTable.text = @"";
//	[searchTable resignFirstResponder];
//	
//	letUserSelectRow = YES;
//	searching = NO;
//	self.navigationItem.rightBarButtonItem = nil;
//	self.tableView.scrollEnabled = YES;
//	
//	[ovController.view removeFromSuperview];
//	
//	ovController = nil;
//	
//	[self.tableView reloadData];
//}
//



- (void)viewDidUnload {
    viewAssistance = nil;
    btnSkip = nil;
    [super viewDidUnload];
}
@end
