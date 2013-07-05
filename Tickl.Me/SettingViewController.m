//
//  SettingViewController.m
//  Tickl.Me
//
//  Created by Saurabh Sindhu on 5/29/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "SettingViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "NearbyVenuesViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)clickMenu
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app showMenu];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"Account Settings";
    
    UIButton *customMenuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customMenuBtn.frame = CGRectMake(10, 7.5, 30, 30);
    [customMenuBtn addTarget:self action:@selector(clickMenu) forControlEvents:UIControlEventTouchUpInside];
    [customMenuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [customMenuBtn setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *leftBarButton =[[UIBarButtonItem alloc] initWithCustomView:customMenuBtn];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    
    arrtitleForHeader=[[NSMutableArray alloc]init];
    [arrtitleForHeader addObject:@"My Filters"];
    [arrtitleForHeader addObject:@"Notification"];
    [arrtitleForHeader addObject:@"Email Notification"];
    [arrtitleForHeader addObject:@"Social Networks"];
    [arrtitleForHeader addObject:@"Calendar"];
    
}
#pragma mark------TableviewDelegate------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  5;
    
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return  [arrtitleForHeader objectAtIndex:section];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
        return 1;
    else if (section==1)
        return 2;
    else if (section==2)
        return 3;
    else if (section==3)
        return 3;
    else if (section==4)
        return 1;
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section==4)
        return 85;
    else
        return 0;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if(section==4)
    {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 80)];
        
        UILabel *lblInfo = [[UILabel alloc]initWithFrame :CGRectMake(0, 5, 294, 50)];
        lblInfo.font = [UIFont boldSystemFontOfSize:13];
        lblInfo.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
        lblInfo.tag =11;
        lblInfo.backgroundColor = [UIColor clearColor];
        lblInfo.text=[NSString stringWithFormat:@"You can use this link to sync tickl.me calendar with most kinds of calendar\n programs."];
        lblInfo.textAlignment=NSTextAlignmentCenter;
        lblInfo.numberOfLines=3;
        [view addSubview:lblInfo];
        
        UIButton *btnLearnMore=[UIButton buttonWithType:UIButtonTypeCustom];
        btnLearnMore.frame=CGRectMake(13, 55, 294, 25);
        btnLearnMore.backgroundColor=[UIColor clearColor];
        [btnLearnMore setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btnLearnMore setTitle:@"Learn more about syncing  your Calendar here" forState:UIControlStateNormal];
        btnLearnMore.titleLabel.font=[UIFont boldSystemFontOfSize:12];
        [view addSubview:btnLearnMore];
        return view;
        
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil)
    {
        return nil;
    }
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 5, 484, 23);
    label.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0];
    label.font =[UIFont boldSystemFontOfSize:15];
    label.text = sectionTitle;
    label.numberOfLines = 1;
    [label sizeToFit];
    label.backgroundColor = [UIColor clearColor];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 300, 320, 400)];
    view.backgroundColor=[UIColor clearColor];
    [view addSubview:label];
    
    
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell*cell = [tblView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell=nil;
    if(cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        int section=[indexPath section];
        if(section==0)
        {
            if(indexPath.row==0)
            {
                
                UILabel *lblFilter = [[UILabel alloc]initWithFrame :CGRectMake(15, 6, 120, 25)];
                lblFilter.font = [UIFont boldSystemFontOfSize:13];
                lblFilter.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
                lblFilter.tag =11;
                lblFilter.backgroundColor = [UIColor clearColor];
                lblFilter.text=@"4 Active";
                lblFilter.textAlignment = 0;
                [cell addSubview:lblFilter];
            }
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        if(section==1)
        {
            if(indexPath.row==0)
            {
                
                UILabel *lblNotification = [[UILabel alloc]initWithFrame :CGRectMake(15, 6, 120, 25)];
                lblNotification.font = [UIFont boldSystemFontOfSize:13];
                lblNotification.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
                lblNotification.tag =11;
                lblNotification.backgroundColor = [UIColor clearColor];
                lblNotification.text=@"Push Notification";
                lblNotification.textAlignment = 0;
                [cell addSubview:lblNotification];
                
                CGRect frame = CGRectMake(210, 10, 60.0, 26.0);
                UISwitch *switchControlNotification = [[UISwitch alloc] initWithFrame:frame];
                [switchControlNotification addTarget:self action:@selector(actionSwitch:) forControlEvents:UIControlEventTouchUpInside];
                [switchControlNotification setBackgroundColor:[UIColor clearColor]];
                [cell addSubview:switchControlNotification];
            }
            if(indexPath.row==1)
            {
                
                UILabel *lblWithIn = [[UILabel alloc]initWithFrame :CGRectMake(15, 6, 120, 25)];
                lblWithIn.font = [UIFont boldSystemFontOfSize:13];
                lblWithIn.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
                lblWithIn.tag =11;
                lblWithIn.backgroundColor = [UIColor clearColor];
                lblWithIn.text=@"Within";
                lblWithIn.textAlignment = 0;
                [cell addSubview:lblWithIn];
                
                UILabel *ValueWithIn = [[UILabel alloc]initWithFrame :CGRectMake(220, 10, 110, 25)];
                ValueWithIn.font = [UIFont boldSystemFontOfSize:13];
                ValueWithIn.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
                ValueWithIn.tag =11;
                ValueWithIn.backgroundColor = [UIColor clearColor];
                ValueWithIn.text=@"10 miles";
                ValueWithIn.textAlignment = 0;
                [cell addSubview:ValueWithIn];
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                
            }
            
        }
        if(section==2)
        {
            if(indexPath.row==0)
            {
                UILabel *lblNewEvent = [[UILabel alloc]initWithFrame :CGRectMake(15, 6, 120, 25)];
                lblNewEvent.font = [UIFont boldSystemFontOfSize:13];
                lblNewEvent.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
                lblNewEvent.tag =11;
                lblNewEvent.backgroundColor = [UIColor clearColor];
                lblNewEvent.text=@"New Event";
                lblNewEvent.textAlignment = 0;
                [cell addSubview:lblNewEvent];
                
                CGRect frame = CGRectMake(210, 10, 60.0, 26.0);
                UISwitch *switchControlNewEvent = [[UISwitch alloc] initWithFrame:frame];
                [switchControlNewEvent addTarget:self action:@selector(actionSwitch:) forControlEvents:UIControlEventTouchUpInside];
                
                [switchControlNewEvent setBackgroundColor:[UIColor clearColor]];
                [cell addSubview:switchControlNewEvent];
            }
            if(indexPath.row==1)
            {
                UILabel *lblNearby = [[UILabel alloc]initWithFrame :CGRectMake(15, 6, 250, 25)];
                lblNearby.font = [UIFont boldSystemFontOfSize:13];
                lblNearby.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
                lblNearby.tag =11;
                lblNearby.backgroundColor = [UIColor clearColor];
                lblNearby.text=@"Favorite Artists Nearby";
                lblNearby.textAlignment = 0;
                [cell addSubview:lblNearby];
                
                CGRect frame = CGRectMake(210, 10, 60.0, 26.0);
                UISwitch *switchControlNearby = [[UISwitch alloc] initWithFrame:frame];
                [switchControlNearby addTarget:self action:@selector(actionSwitch:) forControlEvents:UIControlEventTouchUpInside];
                [switchControlNearby setBackgroundColor:[UIColor clearColor]];
                [cell addSubview:switchControlNearby];
            }
            if(indexPath.row==2)
            {
                UILabel *lblFriendRequest = [[UILabel alloc]initWithFrame :CGRectMake(15, 6, 250, 25)];
                lblFriendRequest.font = [UIFont boldSystemFontOfSize:13];
                lblFriendRequest.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
                lblFriendRequest.tag =11;
                lblFriendRequest.backgroundColor = [UIColor clearColor];
                lblFriendRequest.text=@"Friend Request";
                lblFriendRequest.textAlignment = 0;
                [cell addSubview:lblFriendRequest];
                
                CGRect frame = CGRectMake(210, 10, 60.0, 26.0);
                UISwitch *switchControlFriendRequest = [[UISwitch alloc] initWithFrame:frame];
                [switchControlFriendRequest addTarget:self action:@selector(actionSwitch:) forControlEvents:UIControlEventTouchUpInside];
                [switchControlFriendRequest setBackgroundColor:[UIColor clearColor]];
                [cell addSubview:switchControlFriendRequest];
            }
            
        }
        if(section==3)
        {
            if(indexPath.row==0)
            {
                
                UIImageView *imgFB=[[UIImageView alloc]initWithFrame:CGRectMake(15, 8, 25, 25)];
                imgFB.image=[UIImage imageNamed:@"iconFB.png"];
                [cell addSubview:imgFB];
                
                UILabel *lblFacebook = [[UILabel alloc]initWithFrame :CGRectMake(55, 6, 120, 25)];
                lblFacebook.font = [UIFont boldSystemFontOfSize:13];
                lblFacebook.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
                lblFacebook.tag =11;
                lblFacebook.backgroundColor = [UIColor clearColor];
                lblFacebook.text=@"Facebook";
                lblFacebook.textAlignment = 0;
                [cell addSubview:lblFacebook];
                
                UIButton *btnFBConnect=[UIButton buttonWithType:UIButtonTypeCustom];
                btnFBConnect.frame=CGRectMake(210, 10, 90, 25);
                btnFBConnect.backgroundColor=[UIColor lightGrayColor];
                [btnFBConnect setTitle:@"Connect" forState:UIControlStateNormal];
                btnFBConnect.layer.cornerRadius=7.0;
                btnFBConnect.titleLabel.font=[UIFont boldSystemFontOfSize:13];
                btnFBConnect.layer.borderWidth=1.0;
                btnFBConnect.layer.borderColor=[UIColor lightGrayColor].CGColor;
                [cell addSubview:btnFBConnect];
                
            }
            if(indexPath.row==1)
            {
                
                UIImageView *imgTwi=[[UIImageView alloc]initWithFrame:CGRectMake(15,8, 25, 25)];
                imgTwi.image=[UIImage imageNamed:@"IconTwitter.png"];
                [cell addSubview:imgTwi];
                
                UILabel *lblTwiter = [[UILabel alloc]initWithFrame :CGRectMake(55, 6, 250, 25)];
                lblTwiter.font = [UIFont boldSystemFontOfSize:13];
                lblTwiter.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
                lblTwiter.tag =11;
                lblTwiter.backgroundColor = [UIColor clearColor];
                lblTwiter.text=@"Twitter";
                lblTwiter.textAlignment = 0;
                [cell addSubview:lblTwiter];
                
                UIButton *btnTwiteConnect=[UIButton buttonWithType:UIButtonTypeCustom];
                btnTwiteConnect.frame=CGRectMake(210, 10, 90, 25);
                btnTwiteConnect.backgroundColor=[UIColor lightGrayColor];
                [btnTwiteConnect setTitle:@"Connect" forState:UIControlStateNormal];
                btnTwiteConnect.layer.cornerRadius=7.0;
                btnTwiteConnect.titleLabel.font=[UIFont boldSystemFontOfSize:13];
                btnTwiteConnect.layer.borderWidth=1.0;
                btnTwiteConnect.layer.borderColor=[UIColor lightGrayColor].CGColor;
                [cell addSubview:btnTwiteConnect];
            }
            if(indexPath.row==2)
            {
                
                UIImageView *img4Sq=[[UIImageView alloc]initWithFrame:CGRectMake(15, 8, 25, 25)];
                img4Sq.image=[UIImage imageNamed:@"iconFourSqa.png"];
                [cell addSubview:img4Sq];
                
                UILabel *lblForesquare = [[UILabel alloc]initWithFrame :CGRectMake(55, 6, 250, 25)];
                lblForesquare.font = [UIFont boldSystemFontOfSize:13];
                lblForesquare.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
                lblForesquare.tag =11;
                lblForesquare.backgroundColor = [UIColor clearColor];
                lblForesquare.text=@"Foresquare";
                lblForesquare.textAlignment = 0;
                [cell addSubview:lblForesquare];
                
                UIButton *btnForesquareConnect=[UIButton buttonWithType:UIButtonTypeCustom];
                btnForesquareConnect.frame=CGRectMake(210, 10, 90, 25);
                btnForesquareConnect.backgroundColor=[UIColor lightGrayColor];
                [btnForesquareConnect setTitle:@"Connect" forState:UIControlStateNormal];
                btnForesquareConnect.layer.cornerRadius=7.0;
                btnForesquareConnect.titleLabel.font=[UIFont boldSystemFontOfSize:13];
                btnForesquareConnect.layer.borderWidth=1.0;
                [btnForesquareConnect addTarget:self action:@selector(clickFsq:) forControlEvents:UIControlEventTouchUpInside];
                btnForesquareConnect.layer.borderColor=[UIColor lightGrayColor].CGColor;
                
                [cell addSubview:btnForesquareConnect];
            }
            
        }
        if(section==4)
        {
            if(indexPath.row==0)
            {
                UIButton *btnCal=[UIButton buttonWithType:UIButtonTypeCustom];
                btnCal.frame=CGRectMake(13, 3, 294, 40);
                btnCal.backgroundColor=[UIColor lightGrayColor];
                [btnCal setTitle:@"Cope Link to Calendar" forState:UIControlStateNormal];
                btnCal.layer.cornerRadius=7.0;
                btnCal.titleLabel.font=[UIFont boldSystemFontOfSize:17];
                btnCal.layer.borderWidth=1.0;
                btnCal.layer.borderColor=[UIColor lightGrayColor].CGColor;
                [cell addSubview:btnCal];
            }
        }
        
    }
    return cell;
}

-(void)clickFsq:(id)sender{

    NearbyVenuesViewController *nearBy = [[NearbyVenuesViewController alloc]initWithNibName:@"NearbyVenuesViewController" bundle:nil];

    [self.navigationController pushViewController:nearBy animated:YES];

}

-(void)actionSwitch:(id)sender
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
