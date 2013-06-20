//
//  FaqDetailsViewController.m
//  Tickl.Me
//
//  Created by Prakash Joshi on 5/2/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "FaqDetailsViewController.h"

@interface FaqDetailsViewController ()

@end

@implementation FaqDetailsViewController

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
    // Do any additional setup after loading the view from its nib.
   
    self.title=@"FAQ";
    int positionYInCommentView=15;
    
    lblFaqTitle.text=@"Title";
    lblFaqTitle.font=[UIFont fontWithName:@"MyriadPro-Semibold" size:12];
    lblFaqTitle.textColor=[UIColor blackColor];
    lblFaqTitle.backgroundColor=[UIColor clearColor];
    lblFaqTitle.numberOfLines=0;
    [lblFaqTitle sizeToFit];
    lblFaqTitle.contentMode=UIViewContentModeBottomLeft;
    CGSize constraint = CGSizeMake(190, 30000.0f);
    CGSize size = [lblFaqTitle.text sizeWithFont:[UIFont fontWithName:@"Hevetica-Regular" size:12] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    [lblFaqTitle setFrame:CGRectMake(20,positionYInCommentView, 280, size.height<20?20:size.height)];
    positionYInCommentView+= size.height<20?20:size.height+10;
    
    
    lblFaqDescription.text=@"this is description";
    lblFaqDescription.font=[UIFont fontWithName:@"MyriadPro-Regular" size:12];
    lblFaqDescription.textColor=[UIColor darkGrayColor];
    lblFaqDescription.backgroundColor=[UIColor clearColor];
    lblFaqDescription.numberOfLines=0;
    [lblFaqDescription sizeToFit];
    lblFaqDescription.contentMode=UIViewContentModeBottomLeft;
    CGSize constraint1 = CGSizeMake(190, 30000.0f);
    CGSize size1= [lblFaqDescription.text sizeWithFont:[UIFont fontWithName:@"Hevetica-Regular" size:12] constrainedToSize:constraint1 lineBreakMode:NSLineBreakByWordWrapping];
    [lblFaqDescription setFrame:CGRectMake(20,positionYInCommentView, 280, size1.height<20?20:size.height)];
    positionYInCommentView+=size.height<20?20:size.height+10;;

    imageViewtextBG.frame=CGRectMake(0,positionYInCommentView, 320, size1.height+size.height+20);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
