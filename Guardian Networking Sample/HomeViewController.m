//
//  HomeViewController.m
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/24/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import "HomeViewController.h"

#import "GuardianController.h"
#import "ResultCell.h"
#import "ResultsViewController.h"
#import "ArticlesTableViewController.h"

#import "Section.h"
#import "Article.h"

#import <MBProgressHUD/MBProgressHUD.h>


@interface HomeViewController ()
{
    GuardianController *_guardianController;
}
@property (strong, nonatomic) NSArray *articles;
@property (strong, nonatomic) NSArray *sections;
@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _guardianController = [GuardianController sharedController];
    self.title = @"Guardian Newspaper";
    
 }

-(void)viewDidAppear:(BOOL)animated
{
    [_guardianController loadSectionsWithBlock:^(NSArray *results, BOOL success, NSError *error) {
        if (!error)
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            self.sections = results;
            [self.tableView reloadData];
            
        }
        else
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            [[[UIAlertView alloc] initWithTitle:@"Sorry"
                                        message:@"No Sections found"
                                       delegate:self
                              cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
            
        }
    }];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"HomeSearchSegue"])
    {
        ResultsViewController *resultsViewController = segue.destinationViewController;
        resultsViewController.passedArticles = self.articles;
        resultsViewController.searchTerm = self.textField.text;
        
    } else if ([segue.identifier isEqualToString:@"HomeSectionsArticlesSegue"])
    {
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        Section *selectedSection = self.sections[selectedRowIndex.row];
        ArticlesTableViewController *articlesTBC = segue.destinationViewController;
        articlesTBC.section = selectedSection;
    }
}

#pragma mark - Action Methods
- (IBAction)searchBarButtonItemPressed:(UIBarButtonItem *)sender {
    
    NSString *searchTerm = self.textField.text;
    [self.textField resignFirstResponder];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Searching";

    NSDictionary *parameters =  @{ @"q" : searchTerm,
                                   @"show-tags" : @"all",
                                   @"date-id" : @"date%2Flast7days",
                                   @"show-fields" : @"all",
                                   @"api-key" : kGuardianKey };
    
    [_guardianController loadArticlesWithParameters:parameters
                                 andCompletionBlock:^(NSArray *results, BOOL success, NSError *error) {
                                     if (!error)
                                     {
                                         
                                         self.articles = results;
                                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                                         
                                         [self performSegueWithIdentifier:@"HomeSearchSegue" sender:self];
                                     }
                                     else
                                     {
                                         NSLog(@"Sorry results didn't go through: %@", error);
                                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                                     }
                                     
                                 }];
}

#pragma mark - UITableViewDataSource & Delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sections.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SectionCell";
    ResultCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // configure cell
    
    Section *section = self.sections[indexPath.row];
    cell.articleTitleLabel.text = section.webTitle;
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Sections";
}
@end
