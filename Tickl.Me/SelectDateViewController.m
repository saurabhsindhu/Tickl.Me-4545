//
//  SelectDateViewController.m
//  Tickl.Me
//
//  Created by Prakash Joshi on 4/29/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "SelectDateViewController.h"
#import "SearchResultsViewController.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"

#define IS_IPHONE ( [[[UIDevice currentDevice] model] isEqualToString:@"iPhone"] )
#define IS_IPOD   ( [[[UIDevice currentDevice ] model] isEqualToString:@"iPod touch"] )
#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height >= 568.0f
#define IS_IPHONE_5 ( IS_IPHONE && IS_HEIGHT_GTE_568 )

@interface SelectDateViewController ()
{
    NSMutableArray *arrDataSource;
    UIBarButtonItem *doneBarButton;
    UIBarButtonItem *cancelBarButton;
    BOOL flagShowDatePicker;
    UIButton *btnStartDate;
    UIButton *btnEndDate;
    NSString *stringDate;
}
@end

@implementation SelectDateViewController

@synthesize myString;

@synthesize navC;

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
    
    navC = [[NSString alloc]initWithFormat:@"%@",@"nav"];
    
    NSLog(@"MY STRING VALUE %@",navC);
    // Do any additional setup after loading the view from its nib.
    arrDataSource=[[NSMutableArray alloc]initWithObjects:@"Start Date",@"End Date", nil];
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
    
    doneBarButton =[[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneClicked)];
    cancelBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelClicked)];
    
    NSArray *array = [NSArray arrayWithObjects:doneBarButton,flexible,cancelBarButton, nil];
 
    [datePickerToolBar setItems:array];
    
    [self.view addSubview:datePickerToolBar];
}


#pragma mark - UITableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
    
    cell.textLabel.text = [arrDataSource objectAtIndex:indexPath.row];
    
    if(indexPath.row==0)
    {
        btnStartDate=[UIButton buttonWithType:UIButtonTypeCustom];
        [btnStartDate setTitle:@"Start Date" forState:UIControlStateNormal];
        [btnStartDate setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btnStartDate.titleLabel.textAlignment=NSTextAlignmentCenter;
        [btnStartDate addTarget:self action:@selector(btnSetDateClicked:) forControlEvents:UIControlEventTouchUpInside];
        btnStartDate.tag=indexPath.row+100;
        btnStartDate.frame=CGRectMake(120, 0, 200, 50);
        [cell addSubview:btnStartDate];
    }
    
    else if (indexPath.row==1)
    {
        btnEndDate=[UIButton buttonWithType:UIButtonTypeCustom];
        [btnEndDate setTitle:@"End Date" forState:UIControlStateNormal];
        btnEndDate.titleLabel.textAlignment=NSTextAlignmentCenter;
        [btnEndDate setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnEndDate addTarget:self action:@selector(btnSetDateClicked:) forControlEvents:UIControlEventTouchUpInside];
        btnEndDate.tag=indexPath.row+100;
        btnEndDate.frame=CGRectMake(120, 0, 200, 50);
        [cell addSubview:btnEndDate];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


-(void)btnSetDateClicked:(UIButton*)sender
{
    
    if (sender.tag==100) {
      stringDate=@"Start Date";
    }
    if (sender.tag==101) {
      stringDate=@"End Date";

    }
      if(!flagShowDatePicker)
           {
  
    if (IS_IPHONE_5) {
          
                [UIView animateWithDuration:1.0
                                 animations:^(void) {
                                     datePicker.frame=CGRectMake(0, 568, 320, 200);
                                     datePickerToolBar .frame=CGRectMake(0, 568, 320, 44);
                                 }];
                [UIView animateWithDuration:1.0
                                 animations:^(void) {
                                     datePicker.frame=CGRectMake(0, 304, 320, 200);
                                     datePickerToolBar .frame=CGRectMake(0, 260, 320, 44);
                                 }];
                
            }
            else {
                [UIView animateWithDuration:1.0
                                 animations:^(void) {
                                     datePicker.frame=CGRectMake(0, 480, 320, 200);
                                    datePickerToolBar .frame=CGRectMake(0, 480, 320, 44);
                                 }];
                [UIView animateWithDuration:1.0
                                 animations:^(void) {
                                     datePicker.frame=CGRectMake(0, 216, 320, 200);
                                     datePickerToolBar .frame=CGRectMake(0, 172, 320, 44);
                                 }];
            }
            flagShowDatePicker=YES;
        }
//        else
//        {
//            if(flagShowDatePicker)
//            {
//                
//                [UIView animateWithDuration:1.0
//                                 animations:^(void) {
//                                     datePicker.frame=CGRectMake(0, 480, 320, 200);
//                                     datePickerToolBar .frame=CGRectMake(0, 480, 320, 44);
//                                 }];
//                [UIView animateWithDuration:1.0
//                                 animations:^(void) {
//                                     datePicker.frame=CGRectMake(0, 216, 320, 200);
//                                     datePickerToolBar .frame=CGRectMake(0, 172, 320, 44);
//                                 }];
//                
//            }
//            else {
//                [UIView animateWithDuration:1.0
//                                 animations:^(void) {
//                                     datePicker.frame=CGRectMake(0, 216, 320, 200);
//                                     datePickerToolBar .frame=CGRectMake(0, 172, 320, 44);
//                                 }];
//                [UIView animateWithDuration:1.0
//                                 animations:^(void) {
//                                     datePicker.frame=CGRectMake(0, 480, 320, 200);
//                                     datePickerToolBar .frame=CGRectMake(0, 480, 320, 44);
//                                 }];
//            }
//            
//        }

}
-(void)doneClicked
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd-MM-yyyy"];
    
    myString = [NSString stringWithFormat:@"%@",[df stringFromDate:[datePicker date]]];
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setObject:myString forKey:@"start"];
        [standardUserDefaults synchronize];
    }

    
    if([stringDate isEqualToString:@"Start Date"])
    
        
    [btnStartDate setTitle:myString forState:UIControlStateNormal];
    
    NSLog(@"MY STRING VALUE %@",btnStartDate.titleLabel.text);
    
    if([stringDate isEqualToString:@"End Date"])
      [btnEndDate setTitle:[NSString stringWithFormat:@"%@",[df stringFromDate:[datePicker date]]] forState:UIControlStateNormal];
    
     [[NSUserDefaults standardUserDefaults] setObject:[df stringFromDate:[datePicker date]] forKey:@"Edate"];
    
     NSLog(@"MY STRING VALUE END %@",btnEndDate.titleLabel.text);
    
    
    flagShowDatePicker=NO;
     if (IS_IPHONE_5) {
    [UIView animateWithDuration:1.0
                     animations:^(void) {
                         datePicker.frame=CGRectMake(0, 304, 320, 200);
                         datePickerToolBar .frame=CGRectMake(0, 260, 320, 44);
                     }];
    [UIView animateWithDuration:1.0
                     animations:^(void) {
                         datePicker.frame=CGRectMake(0, 568, 320, 200);
                         datePickerToolBar .frame=CGRectMake(0, 568, 320, 44);
                         
                     }];
     }
     else
     {
    [UIView animateWithDuration:1.0
                     animations:^(void) {
                         datePicker.frame=CGRectMake(0, 216, 320, 200);
                         datePickerToolBar .frame=CGRectMake(0, 172, 320, 44);
                     }];
    [UIView animateWithDuration:1.0
                     animations:^(void) {
                         datePicker.frame=CGRectMake(0, 480, 320, 200);
                         datePickerToolBar .frame=CGRectMake(0, 480, 320, 44);
                     }];
                     }
    
    
    NSString *destPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    destPath = [destPath stringByAppendingPathComponent:@"dateRange.plist"];
    
    // If the file doesn't exist in the Documents Folder, copy it.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:destPath]) {
        NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"dateRange" ofType:@"plist"];
        [fileManager copyItemAtPath:sourcePath toPath:destPath error:nil];
    }
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    
    [dict setObject:btnStartDate.titleLabel.text forKey:@"startVal"];
    
    [dict setObject:btnEndDate.titleLabel.text forKey:@"endVal"];
    
    [dict writeToFile:destPath atomically:YES];

    
//    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://108.168.203.226:8123/events/get_date_events"]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    ASIHTTPRequest* request = [ASIHTTPRequest requestWithURL:url];
//    NSDictionary* postDict = [NSDictionary dictionaryWithObjectsAndKeys:btnStartDate.titleLabel.text,@"startDate",btnEndDate.titleLabel.text,@"endDate",nil];
//    
//    NSString* jsonData = [postDict JSONRepresentation];
//    NSData* postData = [jsonData dataUsingEncoding:NSUTF8StringEncoding];
//    [request appendPostData:postData];
//    [request setDelegate:self];
//    [request startAsynchronous];

}

#pragma mark ASIHTTPReq Delegate
- (void)requestStarted:(ASIHTTPRequest *)request{
    
    NSLog(@"requestStarted%@",request);
    
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    
    NSLog(@"requestFinished%@",request);
    
    responseString=[[request responseString]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@"Response %@",responseString);

    
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    
    NSLog(@"requestFailed%@",request);
    
}




-(void)cancelClicked{
     flagShowDatePicker=NO;
    if (IS_IPHONE_5) {
        [UIView animateWithDuration:1.0
                         animations:^(void) {
                             datePicker.frame=CGRectMake(0, 304, 320, 200);
                             datePickerToolBar .frame=CGRectMake(0, 260, 320, 44);
                         }];
        [UIView animateWithDuration:1.0
                         animations:^(void) {
                             datePicker.frame=CGRectMake(0, 568, 320, 200);
                             datePickerToolBar .frame=CGRectMake(0, 568, 320, 44);
                             
                         }];
    }
    else
    {
        [UIView animateWithDuration:1.0
                         animations:^(void) {
                             datePicker.frame=CGRectMake(0, 216, 320, 200);
                             datePickerToolBar .frame=CGRectMake(0, 172, 320, 44);
                         }];
        [UIView animateWithDuration:1.0
                         animations:^(void) {
                             datePicker.frame=CGRectMake(0, 480, 320, 200);
                             datePickerToolBar .frame=CGRectMake(0, 480, 320, 44);
                         }];
    }
}

- (void)backBtnClicked:(UIButton *)sender
{
    [[self navigationController]popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
