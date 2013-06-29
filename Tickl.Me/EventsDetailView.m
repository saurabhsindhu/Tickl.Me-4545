//
//  EventsDetailView.m
//  Tickl.Me
//
//  Created by Saurabh Sindhu on 6/21/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "EventsDetailView.h"

@interface EventsDetailView ()

@end

@implementation EventsDetailView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction) newEvent {
    
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
    event.title     = @"saurabh";
    
    event.startDate = [[NSDate alloc] init];
    event.endDate   = [[NSDate alloc] initWithTimeInterval:600 sinceDate:event.startDate];
    
    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
    NSError *err;
    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
			
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
