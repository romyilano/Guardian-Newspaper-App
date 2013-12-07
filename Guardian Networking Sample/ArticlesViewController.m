//
//  ArticlesViewController.m
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/6/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import "ArticlesViewController.h"
#import "ArticleBuilder.h"
#import "Article.h"
#import "ArticleCell.h"

#import "DetailViewController.h"

#import "GuardianAPIHelper.h"
#import "Constants.h"

@interface ArticlesViewController ()
@property (strong, nonatomic) ArticleBuilder *articleBuilder;

@end

@implementation ArticlesViewController

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
    _articleBuilder = [[ArticleBuilder alloc] init];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getGuardianArticlesWithSearchTerm:@"travel"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DetailSegue"])
    {
        NSIndexPath *indexpath = [self.tableView indexPathForSelectedRow];
        NSInteger articleNumber = indexpath.row;
        Article *thisArticle = self.articles[articleNumber];
        DetailViewController *detailViewController = segue.destinationViewController;
        detailViewController.article = thisArticle;
    }
  
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.articles.count < 1)
    {
        return 1;
    }
    else {
        
        return self.articles.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    // Configure the cell...
    if (self.articles.count == 0)
    {
         cell.articleTitle.text = @"Loading";
    }
    else
    {
        Article *thisArticle = self.articles[indexPath.row];
        cell.articleTitle.text = thisArticle.webTitle;
        
    }
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

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

#pragma mark - Custom Methods
-(void)getGuardianArticlesWithSearchTerm:(NSString *)searchTerm
{
    // summon the latest guardian article
    NSMutableString *urlAsString = [[NSMutableString alloc] initWithString:guardianSearchURL];
    
    NSString *searchString = [NSString stringWithFormat:@"?q=%@", searchTerm];
    NSString *guardianKeyString = [NSString stringWithFormat:@"&api-key=%@", kGuardianKey];
    
    // http://content.guardianapis.com/search?q=iphone&api-key=5x23fnrsr4hr23zhe58aawjf
    [urlAsString appendString:searchString];
    [urlAsString appendString:guardianKeyString];
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:30.0f];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               
                               // to-do - use the new Articlebuilder to process the reseponse
                               
                               NSString *dataString = [[NSString alloc] initWithData:data
                                                                            encoding:NSUTF8StringEncoding];
                               
                               self.articles = [self.articleBuilder articlesFromJSON:dataString
                                                                               erorr:connectionError];
                               
                              if ((self.articles.count > 0) && connectionError == nil)  // success
                              {
                                  // on the main thread relad the talbe
                                  [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                      NSNumber *articleCount = [NSNumber numberWithUnsignedLong:(unsigned long)self.articles.count];
                                      self.title = [NSString stringWithFormat:@"%@ articles", articleCount];
                                      [self.tableView reloadData];
                                      
                                  }];
                                 
                              }
                               
                           }];
    
}
@end
