//
//  ArticlesTableViewController.h
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/24/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Section;
@interface ArticlesTableViewController : UITableViewController
@property (strong, nonatomic) Section *section;
@property (strong, nonatomic) NSArray *articles;
@end
