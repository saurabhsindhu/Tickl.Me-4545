//
//  CheckInView.m
//  Tickl.Me
//
//  Created by Saurabh Sindhu on 5/29/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "CheckInView.h"
#import "AppDelegate.h"
#import "EventsDetail.h"

@interface CheckInView ()

@end

@implementation CheckInView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Check In";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *rightBarButton =[[UIBarButtonItem alloc] initWithTitle:@"Check In" style:UIBarButtonItemStyleDone target:self action:@selector(listViewButtonClicked:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
//    UIBarButtonItem *leftBarButton =[[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonSystemItemCancel target:self action:@selector(cancelViewButtonClicked:)];
//    self.navigationItem.leftBarButtonItem = leftBarButton;

}

-(IBAction)actButton:(id)sender{
   
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
    
    imgPicker.delegate = self;
    
    imgPicker.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imgPicker animated:YES completion:nil];
    }


    
}


#pragma mark ActionSheet

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
       
    
}

#pragma mark UIImagePickerDel

#pragma UIImagePickerController Deleagate

- (void)imagePickerController:(UIImagePickerController *)picker1 didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker1 dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [cameraButton setImage:[AppDelegate compressImage:img scaledToSize:CGSizeMake(cameraButton.frame.size.width, cameraButton.frame.size.height)] forState:UIControlStateNormal];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker1
{
    [picker1 dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


-(void)listViewButtonClicked:(id)sender{
    
    
}

-(void)cancelViewButtonClicked:(id)sender{
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
