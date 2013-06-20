//
//  AddEventViewController.m
//  Tickl.Me
//
//  Created by Prakash Joshi on 5/2/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "AddEventViewController.h"
#import "InviteFriendsViewController.h"
#define IS_IPHONE ( [[[UIDevice currentDevice] model] isEqualToString:@"iPhone"] )
#define IS_IPOD   ( [[[UIDevice currentDevice ] model] isEqualToString:@"iPod touch"] )
#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height >= 568.0f
#define IS_IPHONE_5 ( IS_IPHONE && IS_HEIGHT_GTE_568 )
@interface AddEventViewController ()
{
    
    NSMutableArray *arrtitleForHeader;
}
@end

@implementation AddEventViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)btnDoneClicked:(UIBarButtonItem*)sender
{
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"Add Events";
    
//    UIBarButtonItem *rightBarButton =[[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleDone target:self action:@selector(btnDoneClicked:)];
//    self.navigationItem.leftBarButtonItem = rightBarButton;
//    [rightBarButton release];
    
    flagShowDatePicker=NO;
    
    if (IS_IPHONE_5) {
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake( 0, 568, 320, 200)];
    }
    else {
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake( 0, 480, 320, 200)];
    }
    
    
    
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.hidden = NO;
    datePicker.date = [NSDate date];
    [self.view addSubview:datePicker];
    
    
    //datePicker ToolBar
    
    datePickerToolBar = [[UIToolbar alloc] init];
    if (IS_IPHONE_5) {
        datePickerToolBar.frame =CGRectMake(0, 568, 320, 44); //CGRectMake(0, 246, 320, 44);
    }
    else {
        datePickerToolBar.frame =CGRectMake( 0, 480, 320, 44); //CGRectMake(0, 157, 320, 44);
    }
    
    datePickerToolBar.autoresizingMask =UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    datePickerToolBar.translatesAutoresizingMaskIntoConstraints = YES;
    datePickerToolBar.barStyle = UIBarStyleBlackTranslucent;
    
    
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *doneBarButton =[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneClicked)];
    UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelClicked)];
    
    NSArray *array = [NSArray arrayWithObjects:doneBarButton,flexible,cancelBarButton, nil];
    
    [datePickerToolBar setItems:array];
    
    [self.view addSubview:datePickerToolBar];


}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  4;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
        return 2;
    else if (section==1)
        return 2;
    else if (section==2)
        return 1;
    else if (section==3)
        return 2;
      return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell*cell = nil;//[tableAddEvents dequeueReusableCellWithIdentifier:cellIdentifier];
    cell=nil;
    if(cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        int section=[indexPath section];
        if(section==0)
        {
            if(indexPath.row==0)
            {
                UILabel *lblFilter = [[UILabel alloc]initWithFrame :CGRectMake(15, 5, 300, 35)];
                lblFilter.font = [UIFont boldSystemFontOfSize:14];
                lblFilter.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
                lblFilter.tag =11;
                lblFilter.backgroundColor = [UIColor clearColor];
                lblFilter.text=@"Event Title";
                lblFilter.textAlignment = 0;
                [cell addSubview:lblFilter];
            }
            if(indexPath.row==1)
            {
                
                UILabel *lblFilter = [[UILabel alloc]initWithFrame :CGRectMake(15, 5, 300, 35)];
                lblFilter.font = [UIFont boldSystemFontOfSize:14];
                lblFilter.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
                lblFilter.tag =11;
                lblFilter.backgroundColor = [UIColor clearColor];
                lblFilter.text=@"Event Details";
                lblFilter.textAlignment = 0;
                [cell addSubview:lblFilter];
            }

            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        if(section==1)
        {
            if(indexPath.row==0)
            {
                
                UILabel *lblStartTime = [[UILabel alloc]initWithFrame :CGRectMake(15, 5, 120, 35)];
                lblStartTime.font = [UIFont boldSystemFontOfSize:14];
                lblStartTime.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
                lblStartTime.tag =11;
                lblStartTime.backgroundColor = [UIColor clearColor];
                lblStartTime.text=@"Starts";
                lblStartTime.textAlignment = 0;
                [cell addSubview:lblStartTime];
                
                UILabel *lblStartdate = [[UILabel alloc]initWithFrame :CGRectMake(130, 5, 180, 35)];
                lblStartdate.font = [UIFont boldSystemFontOfSize:14];
                lblStartdate.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
                lblStartdate.tag =11;
                lblStartdate.backgroundColor = [UIColor clearColor];
                lblStartdate.text=@"Wed, Oct 31, 2013";
                lblStartdate.textAlignment = 0;
                [cell addSubview:lblStartdate];
                
//                btnStartDate=[UIButton buttonWithType:UIButtonTypeCustom];
//                [btnStartDate setTitle:@"Start Date" forState:UIControlStateNormal];
//                [btnStartDate setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//                btnStartDate.titleLabel.textAlignment=NSTextAlignmentCenter;
//                [btnStartDate addTarget:self action:@selector(btnSetDateClicked:) forControlEvents:UIControlEventTouchUpInside];
//                btnStartDate.tag=indexPath.row+100;
//                btnStartDate.frame=CGRectMake(130, 0, 200, 50);
//                [cell addSubview:btnStartDate];
                       }
            if(indexPath.row==1)
            {
                
                UILabel *lblEndDate = [[UILabel alloc]initWithFrame :CGRectMake(15, 5, 120, 35)];
                lblEndDate.font = [UIFont boldSystemFontOfSize:14];
                lblEndDate.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
                lblEndDate.tag =11;
                lblEndDate.backgroundColor = [UIColor clearColor];
                lblEndDate.text=@"Ends";
                lblEndDate.textAlignment = 0;
                [cell addSubview:lblEndDate];
                
                UILabel *lblEndTime = [[UILabel alloc]initWithFrame :CGRectMake(130, 5, 180, 35)];
                lblEndTime.font = [UIFont boldSystemFontOfSize:14];
                lblEndTime.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
                lblEndTime.tag =11;
                lblEndTime.backgroundColor = [UIColor clearColor];
                lblEndTime.text=@"07:30 PM";
                lblEndTime.textAlignment = 0;
                [cell addSubview:lblEndTime];

//                btnEndDate=[UIButton buttonWithType:UIButtonTypeCustom];
//                [btnEndDate setTitle:@"End Date" forState:UIControlStateNormal];
//                btnEndDate.titleLabel.textAlignment=NSTextAlignmentCenter;
//                [btnEndDate setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//                [btnEndDate addTarget:self action:@selector(btnSetDateClicked:) forControlEvents:UIControlEventTouchUpInside];
//                btnEndDate.tag=indexPath.row+100;
//                btnEndDate.frame=CGRectMake(130, 0, 200, 50);
//                [cell addSubview:btnEndDate];
                
            }
            
        }
        if(section==2)
        {
            if(indexPath.row==0)
            {
                UILabel *lblNewEvent = [[UILabel alloc]initWithFrame :CGRectMake(15, 5, 120, 35)];
                lblNewEvent.font = [UIFont boldSystemFontOfSize:14];
                lblNewEvent.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
                lblNewEvent.tag =11;
                lblNewEvent.backgroundColor = [UIColor clearColor];
                lblNewEvent.text=@"Invitees";
                lblNewEvent.textAlignment = 0;
                [cell addSubview:lblNewEvent];
                
               UIButton *btninvitee=[UIButton buttonWithType:UIButtonTypeCustom];
                [btninvitee setTitle:@"None" forState:UIControlStateNormal];
                btninvitee.titleLabel.font = [UIFont boldSystemFontOfSize:14];
                btninvitee.titleLabel.textAlignment=NSTextAlignmentCenter;
                [btninvitee setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [btninvitee addTarget:self action:@selector(btnInviteeClicked:) forControlEvents:UIControlEventTouchUpInside];
                btninvitee.tag=indexPath.row+100;
                btninvitee.frame=CGRectMake(130, 5, 200, 35);
                [cell addSubview:btninvitee];

            }
         }
        if(section==3)
        {
            if(indexPath.row==0)
            {
                
                 UILabel *lblAlert = [[UILabel alloc]initWithFrame :CGRectMake(15, 5, 120, 35)];
                lblAlert.font = [UIFont boldSystemFontOfSize:13];
                lblAlert.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
                lblAlert.tag =11;
                lblAlert.backgroundColor = [UIColor clearColor];
                lblAlert.text=@"Alert";
                lblAlert.textAlignment = 0;
                [cell addSubview:lblAlert];
                
                UIButton *btnAlert=[UIButton buttonWithType:UIButtonTypeCustom];
                btnAlert.frame=CGRectMake(210, 10, 90, 25);
                btnAlert.backgroundColor=[UIColor lightGrayColor];
                [btnAlert setTitle:@"None" forState:UIControlStateNormal];
        //        btnFBConnect.layer.cornerRadius=7.0;
                btnAlert.titleLabel.font=[UIFont boldSystemFontOfSize:13];
                [btnAlert addTarget:self action:@selector(btnAlertClicked:) forControlEvents:UIControlEventTouchUpInside];
//                btnFBConnect.layer.borderWidth=1.0;
//                btnFBConnect.layer.borderColor=[UIColor lightGrayColor].CGColor;
                [cell addSubview:btnAlert];
                
            }
            if(indexPath.row==1)
            {
                
                UILabel *lblSecondAlert = [[UILabel alloc]initWithFrame :CGRectMake(15, 5, 120, 25)];
                lblSecondAlert.font = [UIFont boldSystemFontOfSize:13];
                lblSecondAlert.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
                lblSecondAlert.tag =11;
                lblSecondAlert.backgroundColor = [UIColor clearColor];
                lblSecondAlert.text=@"Second Alert";
                lblSecondAlert.textAlignment = 0;
                [cell addSubview:lblSecondAlert];
                
                UIButton *btnSecondAlert=[UIButton buttonWithType:UIButtonTypeCustom];
                btnSecondAlert.frame=CGRectMake(210, 10, 90, 25);
                btnSecondAlert.backgroundColor=[UIColor lightGrayColor];
                [btnSecondAlert setTitle:@"None" forState:UIControlStateNormal];
                [btnSecondAlert addTarget:self action:@selector(btnSecondAlertClicked:) forControlEvents:UIControlEventTouchUpInside];
            //    btnTwiteConnect.layer.cornerRadius=7.0;
                btnSecondAlert.titleLabel.font=[UIFont boldSystemFontOfSize:13];
//                btnTwiteConnect.layer.borderWidth=1.0;
//                btnTwiteConnect.layer.borderColor=[UIColor lightGrayColor].CGColor;
                [cell addSubview:btnSecondAlert];
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
              //  btnForesquareConnect.layer.cornerRadius=7.0;
                btnForesquareConnect.titleLabel.font=[UIFont boldSystemFontOfSize:13];
//                btnForesquareConnect.layer.borderWidth=1.0;
//                btnForesquareConnect.layer.borderColor=[UIColor lightGrayColor].CGColor;
                [cell addSubview:btnForesquareConnect];
            }
            
        }
             
    }
    return cell;
}
-(void)btnInviteeClicked:(UIButton *)sender
{
    InviteFriendsViewController *inviteFrnd=[[InviteFriendsViewController alloc]initWithNibName:@"InviteFriendsViewController" bundle:nil];
    [[self navigationController]pushViewController:inviteFrnd animated:YES];
}
-(void)btnAlertClicked:(UIButton *)sender
{
    
}
-(void)btnSecondAlertClicked:(UIButton *)sender
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
