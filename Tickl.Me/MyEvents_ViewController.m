//
//  MyEvents_ViewController.m
//  Tickl.Me
//
//  Created by Mountain on 2/8/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "MyEvents_ViewController.h"
#import "AppDelegate.h"
#import "DataMyEvent.h"
#import "AddEventViewController.h"
#import "FriendRequestAndEvetnInVitaiaionViewController.h"
@interface MyEvents_ViewController ()

@end

@implementation MyEvents_ViewController

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
    self.title=@"My Events";
    
    UIBarButtonItem *rightBarButton =[[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleDone target:self action:@selector(clickEdit:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    UIButton *customMenuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customMenuBtn.frame = CGRectMake(10, 7.5, 30, 30);
    [customMenuBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [customMenuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [customMenuBtn setImage:[UIImage imageNamed:@"nav_menu_icon.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *leftBarButton =[[UIBarButtonItem alloc] initWithCustomView:customMenuBtn];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   
       arrTotalEvent=[[NSMutableArray alloc]init];
    
    for(int i=0;i<10;i++)
    {
        objMyEvent=[[DataMyEvent alloc]init];
        objMyEvent.Dayimg=@"twentyeight_day.png";
        objMyEvent.EventDateandTime=@"9:30 PM";
        objMyEvent.EventTitle=@"Simian Mobile Disco";
        objMyEvent.EventSubTitle=@"The Proxy";
        [arrTotalEvent addObject:objMyEvent];
        NSLog(@"%@",objMyEvent.EventTitle);
        NSLog(@"%@",objMyEvent.EventSubTitle);
        
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor=[UIColor whiteColor];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrTotalEvent.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell	*cell = [tblMyEvents dequeueReusableCellWithIdentifier:cellIdentifier];
     objMyEvent=(DataMyEvent*)[arrTotalEvent objectAtIndex:indexPath.row];
    cell=nil;
    
    if(cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        
      
        UIImageView *imgEvent=[[UIImageView alloc]initWithFrame:CGRectMake(35, 8, 45, 45)];
        imgEvent.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",objMyEvent.Dayimg]];
        [cell addSubview:imgEvent];
        
        
        UILabel *lblEventTime = [[UILabel alloc]initWithFrame :CGRectMake(85, 15, 80, 25)];
        lblEventTime.font = [UIFont boldSystemFontOfSize:13];
        lblEventTime.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
        lblEventTime.tag =11;
        lblEventTime.backgroundColor = [UIColor clearColor];
        lblEventTime.text=[NSString stringWithFormat:@"%@",objMyEvent.EventDateandTime];
        lblEventTime.textAlignment = 0;
        [cell addSubview:lblEventTime];
        
        UILabel *lblEventName = [[UILabel alloc]initWithFrame :CGRectMake(150, 5, 170, 25)];
        lblEventName.font = [UIFont boldSystemFontOfSize:13];
        lblEventName.tag =11;
        lblEventName.backgroundColor = [UIColor clearColor];
        lblEventName.text=[NSString stringWithFormat:@"%@",objMyEvent.EventTitle];
        lblEventName.textAlignment = 0;
        [cell addSubview:lblEventName];
        
        UILabel *lblEventSubDetails = [[UILabel alloc]initWithFrame :CGRectMake(150, 30, 170, 25)];
        lblEventSubDetails.font = [UIFont boldSystemFontOfSize:13];
        lblEventSubDetails.textColor =[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0f];
        lblEventSubDetails.tag =11;
        lblEventSubDetails.backgroundColor = [UIColor clearColor];
        lblEventSubDetails.text=[NSString stringWithFormat:@"%@",objMyEvent.EventSubTitle];
        lblEventSubDetails.textAlignment = 0;
        [cell addSubview:lblEventSubDetails];
        
    }
   // cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FriendRequestAndEvetnInVitaiaionViewController*friendRequest=[[FriendRequestAndEvetnInVitaiaionViewController alloc]initWithNibName:@"FriendRequestAndEvetnInVitaiaionViewController" bundle:nil];
        [self.navigationController pushViewController:friendRequest animated:YES];
    
 }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickAddToCalendar:(id)sender {
        AddEventViewController *objFriendList = [[AddEventViewController alloc] initWithNibName:@"AddEventViewController" bundle:nil];
    [self.navigationController  pushViewController:objFriendList animated:YES];

}

- (IBAction)clickToday:(id)sender {
}

- (void)backBtnClicked {
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app showMenu];
}

- (void)clickEdit:(id)sender
{
    UIBarButtonItem *btn=(UIBarButtonItem*)sender;
    if([btn.title isEqualToString:@"Edit"])
    {
    [tblMyEvents setEditing:YES animated:YES];
    [btn setTitle:@"Done"];
    }
    else
    {
        [tblMyEvents setEditing:NO animated:YES];
         [btn setTitle:@"Edit"];
    }
    
  
    
}
@end
