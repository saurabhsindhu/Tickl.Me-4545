//
//  EventSubCategoriesViewController.h
//  Tickl.Me
//
//  Created by Prakash Joshi on 5/1/13.
//  Copyright (c) 2013 HongYing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"

@interface EventSubCategoriesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate>
{
    
    IBOutlet UITableView *tableSubCategories;
    
    //get data parameters
    NSMutableArray *statuses;
    NSMutableArray *arrayToEvents;
    NSMutableArray *thmbImage;
    NSMutableArray *uid;
    NSMutableArray *parArr;
    NSMutableArray *insertVal;
    NSMutableArray *insertUID;
    NSMutableArray *arr;
    NSMutableArray *array;
    NSMutableArray *filterArray;
    NSMutableDictionary *selectedIndexDict;
    
}

@property(nonatomic,retain) NSString *strMainCategoryName;
@property(nonatomic,retain) NSMutableArray *filterArray;

@end
