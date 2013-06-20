//
//  CheckInView.h
//  Tickl.Me
//
//  Created by Saurabh Sindhu on 5/29/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckInView : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
   
    IBOutlet UIButton *cameraButton;
    
}

-(IBAction)actButton:(id)sender;

@end
