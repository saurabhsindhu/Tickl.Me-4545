//
//  OverlayViewController.h
//  TableView
//
//  Created by iPhone SDK Articles on 1/17/09.
//  Copyright www.iPhoneSDKArticles.com 2009. 
//

#import <UIKit/UIKit.h>

@class Favorites_ViewController;

@interface OverlayViewController : UIViewController {

	Favorites_ViewController *rvController;
}

@property (nonatomic, retain) Favorites_ViewController *rvController;

@end
