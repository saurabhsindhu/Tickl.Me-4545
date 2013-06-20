//
//  AddEventViewController.h
//  Tickl.Me
//
//  Created by Prakash Joshi on 5/2/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddEventViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    IBOutlet UITableView *tableAddEvents;
    UIDatePicker *datePicker;
    UIToolbar *datePickerToolBar;
    BOOL flagShowDatePicker;
    UIButton *btnStartDate;
    UIButton *btnEndDate;
}
-(void)btnDoneClicked:(UIBarButtonItem*)sender;
@end
