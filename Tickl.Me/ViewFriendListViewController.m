//
//  ViewFriendListViewController.m
//  Tickl.Me
//
//  Created by Prakash Joshi on 4/18/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "ViewFriendListViewController.h"
#import "AppDelegate.h"
#import "AddFriendViewController.h"
#import "UIButton+WebCache.h"
#import "UIImageView+WebCache.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"

@interface ViewFriendListViewController ()

@end

@implementation ViewFriendListViewController

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

    self.title=@"My Friends";
    
    
//    UIBarButtonItem *rightBarButton =[[UIBarButtonItem alloc] initWithTitle:@"Add Friends" style:UIBarButtonItemStyleDone target:self action:@selector(AddFriends:)];
//    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    
    UIButton *customMenuBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    customMenuBtn1.frame = CGRectMake(10, 7.5, 60, 30);
    [customMenuBtn1 addTarget:self action:@selector(AddFriends:) forControlEvents:UIControlEventTouchUpInside];
    [customMenuBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [customMenuBtn1 setImage:[UIImage imageNamed:@"Add-Friends.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *rightBarButton =[[UIBarButtonItem alloc] initWithCustomView:customMenuBtn1];
    self.navigationItem.rightBarButtonItem = rightBarButton;

    
    UIButton *customMenuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customMenuBtn.frame = CGRectMake(10, 7.5, 30, 30);
    [customMenuBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [customMenuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [customMenuBtn setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *leftBarButton =[[UIBarButtonItem alloc] initWithCustomView:customMenuBtn];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
      
    arrayToid = [[NSMutableArray alloc]init];
    arrayfn = [[NSMutableArray alloc]init];
    arrayToln = [[NSMutableArray alloc]init];
    thmbImage = [[NSMutableArray alloc]init];
    emailId = [[NSMutableArray alloc]init];
    array = [[NSMutableArray alloc]init];
    arr = [[NSMutableArray alloc]init];
    
    
    SBJSON *parser = [[SBJSON alloc]init];
    
    
    
    //http://108.168.203.226:8123/events/get_list_events
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://108.168.203.226:8123/users/list_users"]];
    
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
        
        [arrayToid addObject:[[status objectForKey:@"User"]objectForKey:@"id"]];
        
        [arrayfn addObject:[[status objectForKey:@"User"]objectForKey:@"first_name"]];
        
        [arrayToln addObject:[[status objectForKey:@"User"]objectForKey:@"last_name"]];
        
        [emailId addObject:[[status objectForKey:@"User"]objectForKey:@"email"]];
        
        [thmbImage addObject:[[status objectForKey:@"User"]objectForKey:@"picture"]];
   
        
    }
    
    NSLog(@"%@",arrayfn);
    

}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor=[UIColor whiteColor];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayToid.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell	*cell = [tblMyFriends dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell=nil;
    
    if(cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    

            UIButton *ProfileImageButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
            [ProfileImageButton setBackgroundColor:[UIColor clearColor]];
            [ProfileImageButton setClearsContextBeforeDrawing:YES];
            [ProfileImageButton setUserInteractionEnabled:NO];
            NSString *ImagePath =[thmbImage objectAtIndex:indexPath.row];
    
            [ProfileImageButton setImageWithURL:[NSURL URLWithString:ImagePath] placeholderImage:[UIImage imageNamed:@"nouser.png"]];
            [cell.contentView addSubview:ProfileImageButton];
    
    
    
            UILabel *lblEventName = [[UILabel alloc]initWithFrame :CGRectMake(85, 10, 70, 25)];
            lblEventName.font = [UIFont boldSystemFontOfSize:13];
            lblEventName.tag =11;
            lblEventName.backgroundColor = [UIColor clearColor];
            lblEventName.text=[arrayfn objectAtIndex:indexPath.row];
    
            lblEventName.textAlignment = 0;
            [cell addSubview:lblEventName];
    
            UILabel *lblEventSName = [[UILabel alloc]initWithFrame :CGRectMake(160, 10, 80, 25)];
            lblEventSName.font = [UIFont boldSystemFontOfSize:13];
             lblEventSName.tag =12;
            lblEventSName.backgroundColor = [UIColor clearColor];
            lblEventSName.text=[arrayToln objectAtIndex:indexPath.row];
    
            lblEventSName.textAlignment = 0;
            [cell addSubview:lblEventSName];
    
            NSString *destPath1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
            destPath1 = [destPath1 stringByAppendingPathComponent:@"userName.plist"];
    
    
            NSDictionary *dictValue1 = [[NSDictionary alloc]
                                initWithContentsOfFile:destPath1];
    
            NSString *user_id = [dictValue1 objectForKey:@"userName"];
    
            NSLog(@"tft%@",user_id);
    
    
    for (int arrCom = 0; arrCom <[arrayToid count]; arrCom++) {
        
            NSString *strValue = [arrayToid objectAtIndex:arrCom];
        
        if (strValue==user_id){
           
            UIButton *btnAddFriend=[UIButton buttonWithType:UIButtonTypeCustom];
            btnAddFriend.frame=CGRectMake(270, 5, 25, 25);
            [btnAddFriend setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [btnAddFriend addTarget:self action:@selector(sendInvitaionFormApp:) forControlEvents:UIControlEventTouchUpInside];
            //[cell addSubview:btnAddFriend];
            
        }
        
        else {
        
            UIButton *btnAddFriend=[UIButton buttonWithType:UIButtonTypeCustom];
            btnAddFriend.frame=CGRectMake(270, 5, 25, 25);
            [btnAddFriend setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
            [btnAddFriend addTarget:self action:@selector(sendInvitaionFormApp:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btnAddFriend];

        }
    }
   
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"Delete";
}
-(UITableViewCellEditingStyle)tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath   //this is called when we press delete button in table
{
    if(editingStyle==UITableViewCellEditingStyleDelete)
    {
        NSLog(@"------->%i",indexPath.row);
        [arrFriendList removeObjectAtIndex:indexPath.row];
        [tblMyFriends reloadData];
 
    }
}

-(void)sendInvitaionFormApp:(id)sender{
    
    
    //user id
    
    NSString *destPath1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    destPath1 = [destPath1 stringByAppendingPathComponent:@"userName.plist"];
    
    
    NSDictionary *dictValue1 = [[NSDictionary alloc]
                                initWithContentsOfFile:destPath1];
    
    NSString *user_id = [dictValue1 objectForKey:@"userName"];
    
    NSLog(@"tft%@",user_id);

    
    UITableViewCell *cell = ((UITableViewCell *)[sender superview]);
    NSIndexPath *indexPath = [tblMyFriends indexPathForCell:cell];
    NSLog(@"INDEX %@",indexPath);
    
    [arr addObject:[arrayToid objectAtIndex:indexPath.row]];
    
    NSLog(@"Inserted UID%@",arr);
    
    //Saving it
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"id"];
    
    //Loading it
    
    array = [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:array forKey:@"id"];
    
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://108.168.203.226:8123/users/friend_request"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
    NSDictionary* postDict = [NSDictionary dictionaryWithObjectsAndKeys:array,@"frndId",user_id,@"user_id", nil];
    NSString* jsonData = [postDict JSONRepresentation];
    NSData* postData = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
    [request appendPostData:postData];
    [request setDelegate:self];
    [request startAsynchronous];
    


    
    
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



- (void)backBtnClicked {
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app showMenu];
}


-(IBAction)MyProfile:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)AddFriends:(id)sender
{
    AddFriendViewController *objAddFriend = [[AddFriendViewController alloc] initWithNibName:@"AddFriendViewController" bundle:nil];
    [self.navigationController pushViewController:objAddFriend animated:YES];
 
}

@end
