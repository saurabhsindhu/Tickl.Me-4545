//
//  GalleryImageInFullViewController.m
//  Tickl.Me
//
//  Created by Prakash Joshi on 4/18/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "GalleryImageInFullViewController.h"

@interface GalleryImageInFullViewController ()

@end

@implementation GalleryImageInFullViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
