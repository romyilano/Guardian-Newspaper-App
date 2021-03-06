//
//  ResultsViewController.m
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/8/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import "ResultsViewController.h"
#import "GuardianController.h"

#import "ArticleViewController.h"
#import "ResultCell.h"

#import "Article.h"
#import "Fields.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface ResultsViewController ()
-(void)reorderArticles;
@end

@implementation ResultsViewController

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

    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.title = [NSString stringWithFormat:@"Search: %@", self.searchTerm];
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
    return self.passedArticles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ResultCell";
    ResultCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Article *article = self.passedArticles[indexPath.row];
    cell.articleTitleLabel.text = article.webTitle;
    
    [cell.articleImage setImageWithURL:article.fields.thumbnailURL
                      placeholderImage:[UIImage imageNamed:@"placeholder"]
                               options:SDWebImageRefreshCached];
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"ArticleSegue"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Article *selectedArticle = self.passedArticles[indexPath.row];
        
        ArticleViewController *articleViewController = (ArticleViewController *)segue.destinationViewController;
        articleViewController.article = selectedArticle;
    }
}

#pragma mark - Custom Methods
-(void)reorderArticles
{
    // to-do - reorder articles by date
}


@end
