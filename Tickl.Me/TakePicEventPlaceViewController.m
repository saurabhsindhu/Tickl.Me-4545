//
//  TakePicEventPlaceViewController.m
//  Tickl.Me
//
//  Created by Prakash Joshi on 5/8/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "TakePicEventPlaceViewController.h"
#import "PhotoTaker.h"
@interface TakePicEventPlaceViewController ()

@end

@implementation TakePicEventPlaceViewController

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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cameraButtonClicked:(UIButton *)sender {
    
    PhotoTaker *photoTaker=[[PhotoTaker alloc]init];
  //  photoTaker.sourceType=UIImagePickerControllerSourceTypeCamera;
    [[self navigationController] presentModalViewController:photoTaker animated:YES];
    
}
- (void)viewDidUnload {
    txtComments = nil;
    lblPlaceholder = nil;
    [super viewDidUnload];
}
@end
