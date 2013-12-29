//
//  MainViewController.h
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/25/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//
// Abstract:
// Main View Controller with Search in Toolbar below
// Plus editor's picks

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

-(IBAction)searchBtnPressed:(id)sender;
@end
