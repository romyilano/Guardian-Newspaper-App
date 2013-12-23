//
//  ResultsViewController.h
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/8/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultsViewController : UITableViewController
@property (strong, nonatomic) NSArray *passedArticles;
@property (strong, nonatomic) NSString *searchTerm;
@end
