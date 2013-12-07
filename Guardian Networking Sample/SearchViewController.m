//
//  SearchViewController.m
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/6/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import "SearchViewController.h"

#import "Article.h"
#import "ArticleBuilder.h"
#import "ArticleCell.h"

#import "GuardianAPIHelper.h"
#import "Constants.h"

@interface SearchViewController ()
@property (strong, nonatomic) ArticleBuilder *articleBuilder;
@end

@implementation SearchViewController

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
    
    self.articleBuilder = [[ArticleBuilder alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Methods

-(IBAction)clearButtonPressed:(UIButton *)sender
{
    self.textField.text = nil;
}

-(IBAction)goButtonPressed:(UIButton *)sender
{
    // get the json data using the search term
    if (self.textField.text == nil)
    {
        [[[UIAlertView alloc] initWithTitle:@"Need Search Term"
                                    message:@"Please enter a search term"
                                   delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        
    } else
    {
        
        [self.textField resignFirstResponder];
        
        NSString *searchTerm = self.textField.text;
        
        // use the search term to get the json
        [self getGuardianArticlesWithSearchTerm:searchTerm];
        

    }
}
#pragma mark - networking methods
-(void)getGuardianArticlesWithSearchTerm:(NSString *)searchTerm
{
    
    
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
                               
                               NSString *dataString = [[NSString alloc] initWithData:data
                                                                            encoding:NSUTF8StringEncoding];
                               
                               self.articles = [self.articleBuilder articlesFromJSON:dataString
                                                                               erorr:connectionError];
                               
                               
                               if ((self.articles.count > 0) && connectionError == nil)  // success
                               {
                                   /*
                                   // on the main thread relad the talbe
                                   [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                       NSNumber *articleCount = [NSNumber numberWithUnsignedLong:(unsigned long)self.articles.count];
                                       self.title = [NSString stringWithFormat:@"%@ articles", articleCount];
                                       [self.tableView reloadData];
                                       
                                   }];
                                    */
                                   
                                   // got the articles
                                   NSLog(@"%@ are the articles", self.articles);
                                   
                                   // on main thread
                                   [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                       
                                       //
                                       [self.tableView reloadData];
                                       
                                   }];
                               }
                               
                           }];
    
}

#pragma mark - UITextView Datasource
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

#pragma mark - UITableView Delegate and Datasource Methods

@end
