//
//  SelectDateViewController.h
//  Tickl.Me
//
//  Created by Prakash Joshi on 4/29/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface SelectDateViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate>
{
    UIDatePicker *datePicker;
    UIToolbar *datePickerToolBar;
    NSString *myString,*myString1;
    
    NSString *responseString;
    
    NSString *navC;
    
}
@property (retain, nonatomic) IBOutlet UITableView *tableViewSelectDateRange;
@property (retain, nonatomic) NSString *myString;
@property (retain, nonatomic) NSString *navC;

- (void)backBtnClicked:(UIButton *)sender;



@end
