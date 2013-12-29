//
//  SectionsTableViewController.m
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/24/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import "SectionsTableViewController.h"
#import "ArticlesTableViewController.h"

#import "GuardianController.h"
#import "Section.h"

#import <MBProgressHUD/MBProgressHUD.h>

@interface SectionsTableViewController ()
{
    GuardianController *_controller;
}
@property (strong, nonatomic) NSArray *sections;
@end

@implementation SectionsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _controller = [GuardianController sharedController];
    
    [_controller loadArticlesWithParameters:nil
                                               path:@"sections"
                                             ofType:@"sections"
                                 andCompletionBlock:^(NSArray *array, BOOL success, NSError *error) {
                                     
                                     if (!error)
                                     {
                                         
                                         // to-do - take the array and clean it out with an acceptable array
                                         self.sections = array;
                                         [self.tableView reloadData];
                                         
                                     }
                                     else
                                     {
                                         [[[UIAlertView alloc] initWithTitle:@"Sorry"
                                                                     message:@"No Sections found"
                                                                    delegate:self
                                                           cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                                         
                                     }
                                 }];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.sections count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SectionCell"
                                                            forIndexPath:indexPath];
    
    // Configure the cell...
  
    Section *section = self.sections[indexPath.row];
    cell.textLabel.text = section.webTitle;
    
    return cell;
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"SectionsArticlesSegue"])
    {
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        Section *selectedSection = self.sections[selectedRowIndex.row];
        ArticlesTableViewController *articlesTableViewController = segue.destinationViewController;
        articlesTableViewController.section = selectedSection;
    }
}

#pragma mark - Custom Methods


@end
