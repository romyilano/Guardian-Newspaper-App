//
//  MainViewController.m
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/25/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import "MainViewController.h"
#import "GuardianController.h"
#import "ResultCell.h"
#import "ResultsViewController.h"
#import "ArticleViewController.h"

#import "Section.h"
#import "Article.h"
#import "Fields.h"

#import <MBProgressHUD/MBProgressHUD.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface MainViewController ()
{
    GuardianController *_controller;
}

@property (strong, nonatomic) NSArray *editorsPicksArticles;

@end


@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillToggle:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillToggle:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _controller = [GuardianController sharedController];
     self.title = @"Guardian Newspaper";
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
    NSDictionary *loadParameters = @{@"page-size" : @"40",
                                     @"show-fields" : @"all",
                                     @"show-editors-picks" : @"true" };
    

    [_controller loadArticlesWithParameters:loadParameters
                                       path:nil
                                     ofType:@"editorsPicks"
                         andCompletionBlock:^(NSArray *array, BOOL success, NSError *error) {
                             if (!error)
                             {
                                 self.editorsPicksArticles = array;
                                 [self.tableView reloadData];
                                 
                             }
                         }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"EditorsPickArticleSegue"])
    {
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        Article *selectedArticle = self.editorsPicksArticles[selectedRowIndex.row];
        
        ArticleViewController *articleViewController = segue.destinationViewController;
        articleViewController.article = selectedArticle;
        
    }
}


#pragma mark - UITableViewDataSource & Delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.editorsPicksArticles.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EditorsPickCell";
    ResultCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // configure cell
    Article *article = self.editorsPicksArticles[indexPath.row];
    
    cell.articleTitleLabel.text = article.webTitle;
    [cell.articleImage setImageWithURL:article.fields.thumbnailURL
                      placeholderImage:[UIImage imageNamed:@"placeholder"]
                               options:SDWebImageRefreshCached];
  
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Editor's Picks";
}


#pragma mark - Action Methods
-(IBAction)searchBtnPressed:(id)sender
{
    [self.textField resignFirstResponder];
    
}
@end
