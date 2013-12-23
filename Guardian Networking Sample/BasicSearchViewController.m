//
//  BasicSearchViewController.m
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/22/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import "BasicSearchViewController.h"
#import "GuardianController.h"
#import "ResultsViewController.h"

#import <MBProgressHUD/MBProgressHUD.h>

@interface BasicSearchViewController ()
{
    GuardianController *_guardianController;
}

@property (strong, nonatomic) NSArray *articles;

@end

@implementation BasicSearchViewController

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
    self.textField.text = @"iPhone";

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
    if ([segue.identifier isEqualToString:@"SearchSegue"])
    {
        ResultsViewController *resultsVC = [[ResultsViewController alloc] init];
        resultsVC = segue.destinationViewController;
        resultsVC.passedArticles = self.articles;
        resultsVC.searchTerm = self.textField.text;
    }

}

#pragma mark - Action Methods
- (IBAction)searchBtnPressed:(UIButton *)sender {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Searching";
    
    [self.textField resignFirstResponder];
    
    NSDictionary *parameters =  @{ @"show-tags" : @"all",
                                   @"date-id" : @"date%2Flast7days",
                                   @"show-fields" : @"all",
                                   @"api-key" : kGuardianKey };
    
    [_guardianController loadArticlesWithSearchTerm:self.textField.text
                                      andParameters:parameters
                                            results:^(NSArray *results, BOOL success, NSError *error) {
                                                if (!error && results.count > 0)
                                                {
                                                    
                                                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                    
                                                    self.articles = results;
                                                    [self performSegueWithIdentifier:@"SearchSegue" sender:self];
                                                }
                                                else
                                                {
                                                    
                                                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                    
                                                    NSLog(@"Fail! because %@", error);
                                                    
                                                    [[[UIAlertView alloc] initWithTitle:@"Sorry"
                                                                                message:@"No search results found"
                                                                               delegate:self
                                                                      cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                                                }
                                            }];
    
}

- (IBAction)clearBtnPressed:(UIButton *)sender {
    
    self.textField.text = nil;
    
    [self.textField resignFirstResponder];
    
}

@end
