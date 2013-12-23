//
//  BasicSearchViewController.m
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/22/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import "BasicSearchViewController.h"
#import "GuardianController.h"

@interface BasicSearchViewController ()

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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark - Action Methods
- (IBAction)searchBtnPressed:(UIButton *)sender {
    
    [self.textField resignFirstResponder];
    
}

- (IBAction)clearBtnPressed:(UIButton *)sender {
    
    self.textField.text = nil;
    
    [self.textField resignFirstResponder];
    
}

@end
