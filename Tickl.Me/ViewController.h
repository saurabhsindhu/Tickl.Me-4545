//
//  ViewController.h
//  Tickl.Me
//
//  Created by Mountain on 2/1/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FacebookManager.h"

@interface ViewController : UIViewController <FacebookManagerDelegate>
{

}
- (IBAction)clickWhyFacebook:(id)sender;
- (IBAction)clickCreateAccount:(id)sender;
- (IBAction)clickLogInWithFacebook:(id)sender;
- (IBAction)clickLogInWithEmail:(id)sender;
@end
