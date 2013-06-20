//
//  TakePicEventPlaceViewController.h
//  Tickl.Me
//
//  Created by Prakash Joshi on 5/8/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TakePicEventPlaceViewController : UIViewController
{
    IBOutlet UILabel *lblPlaceholder;
    IBOutlet UITextView *txtComments;
}
- (IBAction)cameraButtonClicked:(UIButton *)sender;
@end
