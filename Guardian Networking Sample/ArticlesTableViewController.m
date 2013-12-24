//
//  ArticlesTableViewController.m
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/24/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import "ArticlesTableViewController.h"
#import "GuardianController.h"
#import "ArticleViewController.h"
#import "ResultCell.h"

#import <MBProgressHUD/MBProgressHUD.h>
#import <SDWebImage/UIImageView+WebCache.h>

#import "Section.h"
#import "Article.h"
#import "Fields.h"

@interface ArticlesTableViewController ()
{
    GuardianController *_controller;
}

@end

@implementation ArticlesTableViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // get articles
    
    _controller = [GuardianController sharedController];
    
    
    NSDictionary *parameters = @{ @"section" : self.section.sectionID,
                                  @"show-fields" : @"all",
                                  @"show-tags" : @"all",
                                  @"date-id" : @"date%2Flast30days",
                                  @"api-key" : kGuardianKey};

    [_controller loadArticlesWithParameters:parameters andCompletionBlock:^(NSArray *results, BOOL success, NSError *error) {
        
        if (!error)
        {
            self.articles = results;
            
            if (self.articles.count > 0)
            {
               [self.tableView reloadData];
            } else
            {
                [[[UIAlertView alloc] initWithTitle:@"Sorry"
                                            message:@"No articles found for this section"
                                           delegate:self
                                  cancelButtonTitle:nil
                                  otherButtonTitles:@"OK", nil] show];
            }
        }
        else
        {
            NSLog(@"error: %@", error);
        }
    }];
    
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
    return self.articles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SectionArticleCell" forIndexPath:indexPath];
    
    // Configure the
    Article *article = self.articles[indexPath.row];
    cell.articleTitleLabel.text = article.webTitle;
    
    [cell.articleImage setImageWithURL:article.fields.thumbnailURL
                      placeholderImage:[UIImage imageNamed:@"placeholder"]
                               options:SDWebImageRefreshCached];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SectionIndividualArticleSegue"])
    {
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        Article *selectedArticle = self.articles[selectedIndexPath.row];
        ArticleViewController *articleViewController = segue.destinationViewController;
        articleViewController.article = selectedArticle;
    }
}


@end
