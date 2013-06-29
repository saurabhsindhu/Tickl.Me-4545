//
//  FriendRequestAndEvetnInVitaiaionViewController.m
//  Tickl.Me
//
//  Created by Prakash Joshi on 5/4/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "FriendRequestAndEvetnInVitaiaionViewController.h"


#import "dataFriendRequests.h"
#import "dataEventsInvitaions.h"
#import <QuartzCore/QuartzCore.h>
#define kOFFSET_FOR_KEYBOARD 160.0
#define IS_IPHONE ( [[[UIDevice currentDevice] model] isEqualToString:@"iPhone"] )
#define IS_IPOD   ( [[[UIDevice currentDevice ] model] isEqualToString:@"iPod touch"] )
#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height >= 568.0f
#define IS_IPHONE_5 ( IS_IPHONE && IS_HEIGHT_GTE_568 )

@interface FriendRequestAndEvetnInVitaiaionViewController ()
{
    
    NSMutableArray *arrFriendRequests;
    NSMutableArray *arrInvitationRequests;
    UIActionSheet *actionSheetFriendReqOptions;
    UIActionSheet *actionSheetEventReqOptions;
}
@end

@implementation FriendRequestAndEvetnInVitaiaionViewController

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
    self.navigationController.navigationBarHidden=NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
      
    
    if (IS_IPHONE_5) {
        tableFriendRequests.frame=CGRectMake(0, 35, 320, 173);
        tableEventInvitation.frame=CGRectMake(0, 243, 320, 173);
      
        //table headers
        lblFriendReq.frame=CGRectMake(0, 0, 320, 35);
        lblEventInvitaions.frame=CGRectMake(0, 252, 320, 35);
    }
    else
    {
        tableFriendRequests.frame=CGRectMake(0, 35, 320, 217);
        tableEventInvitation.frame=CGRectMake(0, 287, 320, 217);
        //tableheaders
        lblFriendReq.frame=CGRectMake(0, 0, 320, 35);
        lblEventInvitaions.frame=CGRectMake(0, 258, 320, 35);
    }
    
    arrInvitationRequests=[[NSMutableArray alloc]initWithObjects: nil];
     arrFriendRequests=[[NSMutableArray alloc]initWithObjects: nil];
    for (int index=0; index<5; index++)
    {
        dataFriendRequests *data=[[dataFriendRequests alloc]init];
        data.name=@"Name";
        [arrFriendRequests addObject:data];
       
        dataEventsInvitaions *dataE=[[dataEventsInvitaions alloc]init];
        dataE.eventName=@"Event Name";
        dataE.eventDetails=@"Invited By this person";
        [arrInvitationRequests addObject:dataE];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView==tableFriendRequests)
    {
        return 1;
    }
    if(tableView==tableEventInvitation)
    {
        return 1;
        
    }
    return nil;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==tableFriendRequests)
    {
        return arrFriendRequests.count;
    }
    if(tableView==tableEventInvitation)
    {
        return arrInvitationRequests.count;
        
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==tableFriendRequests)
    {
         return 60;
    }
    if(tableView==tableEventInvitation)
    {
        return 60;
        
    }
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell*cell = [tableEventInvitation dequeueReusableCellWithIdentifier:cellIdentifier];
    cell=nil;
    if(cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        if(tableView==tableFriendRequests)
        {
         dataFriendRequests *data=(dataFriendRequests*)[arrFriendRequests objectAtIndex:indexPath.row];
        cell.tag=indexPath.row;
        
        UIImageView *imageUser=[[UIImageView alloc]initWithFrame:CGRectMake(12, 5, 50, 50)];
       // [imageUser setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",data.image]]  placeholderImage:[UIImage imageNamed:@"users.png"]];
        imageUser.image=[UIImage imageNamed:@"UserImage.png"];
        imageUser.backgroundColor = [UIColor clearColor];
        imageUser.contentMode =  UIViewContentModeScaleAspectFit;
        imageUser.layer.borderColor=[UIColor lightGrayColor].CGColor;
        [cell addSubview:imageUser];
        
//        UIButton *btnImageButtton=[UIButton buttonWithType:UIButtonTypeCustom];
//        btnImageButtton.frame=CGRectMake(00, 0, 50, 50);
//        btnImageButtton.tag=indexPath.section;
//        btnImageButtton.backgroundColor=[UIColor clearColor];
//        [btnImageButtton addTarget:self action:@selector(friendImageClicked:) forControlEvents:UIControlEventTouchDown];
//        [imageUser addSubview:btnImageButtton];
//        
//        UIButton *btnName=[UIButton buttonWithType:UIButtonTypeCustom];
//        btnName.frame=CGRectMake(65, 20, 240, 20);
//        btnName.tag=indexPath.section;
//        [btnName addTarget:self action:@selector(friendNameClicked:) forControlEvents:UIControlEventTouchDown];
//        [cell addSubview:btnName];
        
        UILabel *lblEventTitle=[[UILabel alloc]init];
        lblEventTitle.text=data.name;
        lblEventTitle.numberOfLines=0;
        [lblEventTitle sizeToFit];
        lblEventTitle.font=[UIFont fontWithName:@"Hevetica" size:13];
        lblEventTitle.backgroundColor=[UIColor clearColor];
        lblEventTitle.textColor=[UIColor colorWithRed:85.0/255.0 green:85.0/255.0 blue:85.0/255.0 alpha:1.0];
        CGSize constraint = CGSizeMake(240 - (5 * 2), 30000.0f);
        CGSize size = [data.name sizeWithFont:[UIFont fontWithName:@"Hevetica" size:12] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
        [lblEventTitle setFrame:CGRectMake(65, 20, 240, MAX(size.height, 20.0f))];
        [cell addSubview:lblEventTitle];
        
//        UILabel *lblEmail=[[UILabel alloc]initWithFrame:CGRectMake(65, 35, 160, 20)];
//        lblEmail.text=data.email;
//        lblEmail.textColor=[UIColor colorWithRed:85.0/255.0 green:85.0/255.0 blue:85.0/255.0 alpha:1.0];
//        lblEmail.backgroundColor=[UIColor clearColor];
//        lblEmail.textAlignment=NSTextAlignmentLeft;
//        lblEmail.font=[UIFont fontWithName:@"Hevetica" size:10];
        //[cell addSubview:lblEmail];
    }
    else if (tableView==tableEventInvitation)
             {
                 dataEventsInvitaions *data=(dataEventsInvitaions*)[arrInvitationRequests objectAtIndex:indexPath.row];
                 cell.tag=indexPath.row;
                 
                 UIImageView *imageUser=[[UIImageView alloc]initWithFrame:CGRectMake(12, 5, 50, 50)];
                 // [imageUser setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",data.image]]  placeholderImage:[UIImage imageNamed:@"users.png"]];
                 imageUser.image=[UIImage imageNamed:@"1367834778_icon_stickies.png"];
                 imageUser.backgroundColor = [UIColor clearColor];
                 imageUser.contentMode =  UIViewContentModeScaleAspectFit;
                 imageUser.layer.borderColor=[UIColor lightGrayColor].CGColor;
                 [cell addSubview:imageUser];
                 
                 
                 UILabel *lblEventTitle=[[UILabel alloc]init];
                 lblEventTitle.text=data.eventName;
                 lblEventTitle.numberOfLines=0;
                 [lblEventTitle sizeToFit];
                 lblEventTitle.font=[UIFont fontWithName:@"Hevetica" size:13];
                 lblEventTitle.backgroundColor=[UIColor clearColor];
                 lblEventTitle.textColor=[UIColor colorWithRed:85.0/255.0 green:85.0/255.0 blue:85.0/255.0 alpha:1.0];
                 CGSize constraint = CGSizeMake(240 - (5 * 2), 30000.0f);
                 CGSize size = [data.eventName sizeWithFont:[UIFont fontWithName:@"Hevetica" size:12] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
                 [lblEventTitle setFrame:CGRectMake(65, 10, 240, MAX(size.height, 20.0f))];
                 [cell addSubview:lblEventTitle];
                 
        UILabel *lblEmail=[[UILabel alloc]initWithFrame:CGRectMake(65, 35, 260, 20)];
        lblEmail.text=data.eventDetails;
        lblEmail.textColor=[UIColor colorWithRed:85.0/255.0 green:85.0/255.0 blue:85.0/255.0 alpha:1.0];
        lblEmail.backgroundColor=[UIColor clearColor];
        lblEmail.textAlignment=NSTextAlignmentLeft;
        lblEmail.font=[UIFont fontWithName:@"Hevetica" size:5];
        [cell addSubview:lblEmail];


             }
    cell.backgroundColor=[UIColor clearColor];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==tableFriendRequests)
    {
        actionSheetFriendReqOptions=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Accept Friend Request" otherButtonTitles:@"Deny Friend Request", nil];
        [actionSheetFriendReqOptions showInView:self.view];
    }
    if(tableView==tableEventInvitation)
    {
        actionSheetEventReqOptions=[[UIActionSheet alloc]initWithTitle:@"" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Accept Event Invite" otherButtonTitles:@"Deny Event Invite", nil];
        [actionSheetEventReqOptions showInView:self.view];
    }

}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet==actionSheetFriendReqOptions) {
        if(buttonIndex==0)
        {
            
        }
        else if (buttonIndex==1)
        {
            
        }
    }
    else if (actionSheet==actionSheetEventReqOptions)
    {
        if(buttonIndex==0)
        {
            
        }
        else if (buttonIndex==1)
        {
            
        }

    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

  @end
