//
//  HomeViewController.h
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/24/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchBarButtonItem;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

- (IBAction)searchBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
