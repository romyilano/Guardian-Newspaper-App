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
        
        NSString *searchTerm = self.textField.text;
        
        // use the search term to get the json
        [self getGuardianArticlesWithSearchTerm:searchTerm];
        

    }
}
#pragma mark - networking methods
-(void)getGuardianArticlesWithSearchTerm:(NSString *)searchTerm
{
    // get the latest guardian article
    NSString *urlAsString = guardianSearchURL;
    NSString *searchString = [NSString stringWithFormat:@"?q=%@", searchTerm];
    [urlAsString stringByAppendingString:searchString];
    
    NSString *guardianKeyString = [NSString stringWithFormat:@"&api-key=%@", kGuardianKey];
    [urlAsString stringByAppendingString:guardianKeyString];
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setTimeoutInterval:30.0f];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               
                               NSString *dataAsString = [[NSString alloc] initWithData:data
                                                                              encoding:NSUTF8StringEncoding];
                               
                               NSArray *articles = [self.articleBuilder articlesFromJSON:dataAsString
                                                                                   erorr:connectionError];
                               if ((self.articles.count != 0) && connectionError ==  nil)
                               {
                                   self.articles = articles;
                                   NSLog(@"First article is: %@", self.articles[0]);
                                   
                                   
                               }
                               
                           }];
     
}


#pragma mark - UITextView Delegate Methods

#pragma mark - UITableView Delegate and Datasource Methods

@end
