//
//  imagePickerViewController.m
//  Tickl.Me
//
//  Created by Prakash Joshi on 5/9/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import "imagePickerViewController.h"

@interface imagePickerViewController ()

@end

@implementation imagePickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self = [super init];
        
        self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
#if !TARGET_IPHONE_SIMULATOR
        self.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.showsCameraControls = NO;
#endif
        //self.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        self.navigationBarHidden = YES;
        self.toolbarHidden = YES;
        self.wantsFullScreenLayout = YES;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.frame=CGRectMake(0,0, 320, 568);
    if ( self.sourceType == UIImagePickerControllerSourceTypeCamera) {
        self.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
    }
    else if ( self.sourceType == UIImagePickerControllerSourceTypeCamera) {
        self.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
        
    }
    else if (self.sourceType == UIImagePickerControllerSourceTypeCamera) {
        self.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
        
    }
    NSLog(@"Initial settings");
    
    appdelObj = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [self initialSettings];

}
- (void) initialSettings {
    self.photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.photoButton.frame = CGRectMake(105, 0, 110, 54);
    self.photoButton.titleLabel.text = @"Photo";
    [self.photoButton setImage:[UIImage imageNamed:@"cam_icon.png"] forState:UIControlStateNormal];
    [self.photoButton addTarget:self action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
    
    //    UIButton* flashOn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    flashOn.frame = CGRectMake(250, self.view.frame.size.height-43, 27, 27);
    //    [flashOn setImage:[UIImage imageNamed:@"IM_Photo_FlashOn_Button.png"] forState:UIControlStateNormal];
    //    [flashOn addTarget:self action:@selector(flashOnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    libraryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    libraryBtn.frame = CGRectMake(52,0, 53, 54);
    [libraryBtn setImage:[UIImage imageNamed:@"img_listing.png"] forState:UIControlStateNormal];
    [libraryBtn addTarget:self action:@selector(libraryPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView* back = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-54, 320, 54)];
    // back.backgroundColor = [UIColor colorWithHex:0x04465c];
    back.image = [UIImage imageNamed:@"camera_bg.png"];
    
    //    UIView* divider = [[[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-55, 320, 1)] autorelease];
    //    divider.backgroundColor = [UIColor colorWithHex:0x11c2f4];
    
    cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(0, 0, 52, 54);
    //    cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    //    [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    //    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [cancelButton setBackgroundImage:[Util getDarkButton] forState:UIControlStateNormal];
    [cancelButton setImage:[UIImage imageNamed:@"close_cambtn.png"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    autoMainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    autoMainBtn.frame = CGRectMake(215, 0, 106, 54);
    [autoMainBtn setImage:[UIImage imageNamed:@"automain_btn.png"] forState:UIControlStateNormal];
    
    [autoMainBtn addTarget:self action:@selector(automain_btn:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        //   autoMainBtn.userInteractionEnabled = NO;
        autoMainBtn.enabled = NO;
        self.photoButton.enabled = NO;
        [libraryBtn setImage:[UIImage imageNamed:@"img_listinghover.png"] forState:UIControlStateNormal];
    }
    
    overLayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height-54)];
    overLayView.backgroundColor = [UIColor clearColor];
    overLayView.hidden = YES;
    [self.view bringSubviewToFront:overLayView];
    
    offButton = [UIButton buttonWithType:UIButtonTypeCustom];
    offButton.frame = CGRectMake(overLayView.frame.size.width-106, 50, 106, 50);
    [offButton setImage:[UIImage imageNamed:@"off_btn.png"] forState:UIControlStateNormal];
    [offButton addTarget:self action:@selector(flashOffPressed:) forControlEvents:UIControlEventTouchUpInside];
    [overLayView addSubview:offButton];
    
    onButton = [UIButton buttonWithType:UIButtonTypeCustom];
    onButton.frame = CGRectMake(overLayView.frame.size.width-106, 100, 106, 50);
    [onButton setImage:[UIImage imageNamed:@"on_btn.png"] forState:UIControlStateNormal];
    [onButton addTarget:self action:@selector(flashOnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [overLayView addSubview:onButton];
    
    autoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    autoBtn.frame = CGRectMake(overLayView.frame.size.width-106, 150, 106, 50);
    [autoBtn setImage:[UIImage imageNamed:@"auto_btn.png"] forState:UIControlStateNormal];
    [autoBtn addTarget:self action:@selector(flashAutoPressed:) forControlEvents:UIControlEventTouchUpInside];
    [overLayView addSubview:autoBtn];
    
    
    [self.view addSubview:back];
    //   [self.view addSubview:divider];
    [self.view addSubview:cancelButton];
    [self.view addSubview:self.photoButton];
    // [self.view addSubview:flashOn];
    [self.view addSubview:libraryBtn];
    [self.view addSubview:autoMainBtn];
    [self.view addSubview:overLayView];
    
    if ([appdelObj.mFlashType isEqualToString:@"1"]) {
        
        [autoMainBtn setImage:[UIImage imageNamed:@"automain_btn.png"] forState:UIControlStateNormal];
        
        [onButton setImage:[UIImage imageNamed:@"on_btn.png"] forState:UIControlStateNormal];
        [offButton setImage:[UIImage imageNamed:@"off_btn.png"] forState:UIControlStateNormal];
        [autoBtn setImage:[UIImage imageNamed:@"auto_btnhover.png"] forState:UIControlStateNormal];
    }
    else if ([appdelObj.mFlashType isEqualToString:@"2"]) {
        [autoMainBtn setImage:[UIImage imageNamed:@"on_btnSelect.png"] forState:UIControlStateNormal];
        [onButton setImage:[UIImage imageNamed:@"on_btnhover.png"] forState:UIControlStateNormal];
        [offButton setImage:[UIImage imageNamed:@"off_btn.png"] forState:UIControlStateNormal];
        [autoBtn setImage:[UIImage imageNamed:@"auto_btn.png"] forState:UIControlStateNormal];
        
    }
    else if ([appdelObj.mFlashType isEqualToString:@"3"]) {
        [autoMainBtn setImage:[UIImage imageNamed:@"off_btnSelect.png"] forState:UIControlStateNormal];
        
        [onButton setImage:[UIImage imageNamed:@"on_btn.png"] forState:UIControlStateNormal];
        [offButton setImage:[UIImage imageNamed:@"off_btnhover.png"] forState:UIControlStateNormal];
        [autoBtn setImage:[UIImage imageNamed:@"auto_btn.png"] forState:UIControlStateNormal];
    }
}

- (void) takePicture:(id)sender {
    [autoMainBtn setImage:[UIImage imageNamed:@"automain_btn.png"] forState:UIControlStateNormal];
    [cancelButton setImage:[UIImage imageNamed:@"close_cambtn.png"] forState:UIControlStateNormal];
    [libraryBtn setImage:[UIImage imageNamed:@"img_listing.png"] forState:UIControlStateNormal];
    [self.photoButton setImage:[UIImage imageNamed:@"cam_iconhover.png"] forState:UIControlStateNormal];
    
    [self.photoButton addTarget:self action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
    
    //[self dismissModalViewControllerAnimated:YES];
}

- (void) cancelPressed:(id)sender {
    
    // self.photoButton.hidden = YES;
    //    if (self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary) {
    //        self.sourceType = UIImagePickerControllerSourceTypeCamera;
    //    }
    
    //   [self.parentViewController dismissModalViewControllerAnimated:TRUE];
    //  [self.presentedViewController dismissViewControllerAnimated:YES completion:NULL];
    
    // [self dismissModalViewControllerAnimated:YES];
    //  [self.parentViewController dismissViewControllerAnimated:YES completion:NULL];
    [self dismissViewControllerAnimated:YES completion:NULL];
    // [self.navigationController popViewControllerAnimated:TRUE];
    // [self.delegate performSelector:@selector(cancelledPhoto)];
}

//- (void) resetTimer {
//    LoginVC* login = (LoginVC*)[[self.navigationController viewControllers] objectAtIndex:0];
//    [login stopTimer];
//    [login startTimer];
//}


- (void) flashOnPressed:(id)sender {
    overLayView.hidden = YES;
    
    appdelObj.mFlashType = (NSMutableString *)@"2";
    [autoMainBtn setImage:[UIImage imageNamed:@"on_btnSelect.png.png"] forState:UIControlStateNormal];
    [onButton setImage:[UIImage imageNamed:@"on_btnhover.png"] forState:UIControlStateNormal];
    [offButton setImage:[UIImage imageNamed:@"off_btn.png"] forState:UIControlStateNormal];
    [autoBtn setImage:[UIImage imageNamed:@"auto_btn.png.png"] forState:UIControlStateNormal];
    self.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
}

- (void) flashOffPressed:(id)sender {
    overLayView.hidden = YES;
    
    
    appdelObj.mFlashType = (NSMutableString *)@"3";
    
    [autoMainBtn setImage:[UIImage imageNamed:@"off_btnSelect.png.png"] forState:UIControlStateNormal];
    
    [onButton setImage:[UIImage imageNamed:@"on_btn.png"] forState:UIControlStateNormal];
    [offButton setImage:[UIImage imageNamed:@"off_btnhover.png"] forState:UIControlStateNormal];
    [autoBtn setImage:[UIImage imageNamed:@"auto_btn.png.png"] forState:UIControlStateNormal];
    self.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
    
    //    self.photoButton.hidden = YES;
    //    self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    //   self.photoButton.hidden = YES;
    
    //    [self.parentViewController dismissModalViewControllerAnimated:TRUE];
    //    [self dismissModalViewControllerAnimated:YES];
    
    //  [self removeFromParentViewController];
    //       if (self.sourceType = UIImagePickerControllerSourceTypeCamera) {
    
    //      }
    // [mydelegate performSelector:@selector(photoLibrary)];
}

- (void) flashAutoPressed:(id) sender {
    overLayView.hidden = YES;
    
    appdelObj.mFlashType = (NSMutableString *)@"1";
    
    [autoMainBtn setImage:[UIImage imageNamed:@"automain_btn.png"] forState:UIControlStateNormal];
    
    [onButton setImage:[UIImage imageNamed:@"on_btn.png"] forState:UIControlStateNormal];
    [offButton setImage:[UIImage imageNamed:@"off_btn.png"] forState:UIControlStateNormal];
    [autoBtn setImage:[UIImage imageNamed:@"auto_btnhover.png"] forState:UIControlStateNormal];
    self.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
}

- (void)libraryPressed:(id)sender {
    
    overLayView.hidden = YES;
    
    // [libraryBtn setEnabled:NO];
    if (self.sourceType == UIImagePickerControllerSourceTypeCamera) {
        [autoMainBtn setImage:[UIImage imageNamed:@"automain_btn.png"] forState:UIControlStateNormal];
        [cancelButton setImage:[UIImage imageNamed:@"close_cambtn.png"] forState:UIControlStateNormal];
        [libraryBtn setImage:[UIImage imageNamed:@"img_listinghover.png"] forState:UIControlStateNormal];
        [self.photoButton setImage:[UIImage imageNamed:@"cam_icon.png"] forState:UIControlStateNormal];
        appdelObj.librarySelect = NO;
        appdelObj.camera = NO;
        self.photoButton.enabled = NO;
        // [self dismissModalViewControllerAnimated:YES];
        //  [self dismissViewControllerAnimated:YES completion:NULL];
        self.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        
        //   self.navigationBarHidden = YES;
        //   self.toolbarHidden = YES;
    }
    
    else
    {
        [autoMainBtn setImage:[UIImage imageNamed:@"automain_btn.png"] forState:UIControlStateNormal];
        [cancelButton setImage:[UIImage imageNamed:@"close_cambtn.png"] forState:UIControlStateNormal];
        [libraryBtn setImage:[UIImage imageNamed:@"img_listing.png"] forState:UIControlStateNormal];
        [self.photoButton setImage:[UIImage imageNamed:@"cam_icon.png"] forState:UIControlStateNormal];
        appdelObj.librarySelect = YES;
        appdelObj.camera = YES;
        
        [self dismissViewControllerAnimated:YES completion:NULL];
        
        
        self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
        
        // self.navigationBarHidden = YES;
        // self.toolbarHidden = YES;
        
    }
    
}

- (void) automain_btn:(id)sender {
    if (overLayView.hidden == YES) {
        overLayView.hidden = NO;
        [libraryBtn setImage:[UIImage imageNamed:@"img_listing.png"] forState:UIControlStateNormal];
        [autoMainBtn setImage:[UIImage imageNamed:@"automain_btnhover.png"] forState:UIControlStateNormal];
    }
    else {
        overLayView.hidden = YES;
        [libraryBtn setImage:[UIImage imageNamed:@"img_listing.png"] forState:UIControlStateNormal];
        [autoMainBtn setImage:[UIImage imageNamed:@"automain_btn.png"] forState:UIControlStateNormal];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
