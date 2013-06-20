//
//  PhotoTaker.h
//  Inspection Manager
//
//  Created by Alex Skorulis on 22/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface PhotoTaker : UIImagePickerController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    UIButton* photoButton;
    UIButton* libraryBtn;
    UIButton* cancelButton;
    UIButton *autoMainBtn;
    UIView *overLayView;
    UIButton *offButton;
    UIButton *onButton;
    UIButton *autoBtn;
    AppDelegate *appdelObj;
}
@property (nonatomic, retain) UIButton* photoButton;

- (void) resetTimer;
@end
