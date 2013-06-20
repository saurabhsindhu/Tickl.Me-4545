//
//  imagePickerViewController.h
//  Tickl.Me
//
//  Created by Prakash Joshi on 5/9/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface imagePickerViewController : UIImagePickerController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
     UIButton* photoButton;
    UIButton* libraryBtn;
    UIButton* cancelButton;
    UIButton *autoMainBtn;
    UIView *overLayView;
    UIButton *offButton;
    UIButton *onButton;
    UIButton *autoBtn;
    
    
   IBOutlet UIBarButtonItem* photoButton1;
    IBOutlet UIBarButtonItem* libraryBtn1;
    IBOutlet UIBarButtonItem* cancelButton1;
    IBOutlet UIBarButtonItem *autoMainBtn1;
    IBOutlet UIBarButtonItem *offButton1;
    IBOutlet UIBarButtonItem *onButton1;
    IBOutlet UIBarButtonItem *autoBtn1;
    
    AppDelegate *appdelObj;
}
@property (nonatomic, retain) UIButton* photoButton;

- (void) resetTimer;
@end

