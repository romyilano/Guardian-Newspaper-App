//
//  SearchChoicesViewController.m
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/23/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import "SearchChoicesViewController.h"

#import "GuardianController.h"
#import "ResultsViewController.h"

#import <MBProgressHUD/MBProgressHUD.h>

@interface SearchChoicesViewController ()

@end

@implementation SearchChoicesViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Action Methods
- (IBAction)searchBtnPressed:(UIButton *)sender {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Searching";
    
    [self.textField resignFirstResponder];
    
    // to-do - modify parameters
    
    /*
     
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
     */
    
}

- (IBAction)clearBtnPressed:(UIButton *)sender {
    
    self.textField.text = nil;
    
    [self.textField resignFirstResponder];
    
}

#pragma - UIPickerView DataSource and Delegate Methods


@end
