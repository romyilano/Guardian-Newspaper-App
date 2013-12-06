//
//  ViewController.m
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/6/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//


#import "ViewController.h"
#import "GuardianAPIHelper.h"
#import "Constants.h"
#import "Article.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.webView.scalesPageToFit = YES;
    
    self.textView.text = @"Click on button to get latest guardian article";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)summonarticlebtnPressed:(UIButton *)sender {
    
    // summon the newest iphone article
    NSString *urlAsString = guardianSearchURL;
    // hard coding the iphone search
    urlAsString = [urlAsString stringByAppendingString:@"?q=iphone"];
    NSString *guardianKeyString = [NSString stringWithFormat:@"&api-key=%@", kGuardianKey];
    urlAsString = [urlAsString stringByAppendingString:guardianKeyString];
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:30.0f];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               
                               // sweet smell of success
                               if([data length] > 0 && connectionError == nil)
                               {
                                  
                                   // turn the results into a jsondictionary
                                   [self processJSON:data  withError:connectionError];
                                   
                                   NSDictionary *responseDict = [self.jsonDictionary objectForKey:@"response"];
                                   self.returnedArticles = [responseDict objectForKey:@"results"];
                                
                                   // replace with a model class
                                   Article *firstArticle = [[Article alloc] initWIthDictionary:self.returnedArticles[0]];
        
                                   [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                       
                                       self.textView.text = firstArticle.webTitle;
                                       
                                       // load the article in the webview
                                       [self.webView loadRequest:[NSURLRequest requestWithURL:firstArticle.webURL]];
                                      
                                       
                                   }];
                                   
                               }
                               else if ([data length] == 0 && connectionError == nil)
                               {
                                   NSLog(@"Nothing was downloaded.");
                               }
                               else if (connectionError != nil)
                               {
                                   NSLog(@"error happened = %@", connectionError);
                               }
                           }];

    
}

-(void)processJSON:(NSData *)jsonData withError:(NSError *)connectionError
{
    NSError *error = nil;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    if (jsonObject != nil && error ==nil)
    {
        NSLog(@"Successfully deserialized...");
        
        if ([jsonObject isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
            
            self.jsonDictionary = deserializedDictionary;
            
            NSLog(@"Deserialized json dictionary = %@", deserializedDictionary);
            
        } else if ([jsonObject isKindOfClass:[NSArray class]])
        {
            NSArray *deserializedArray = (NSArray *)jsonObject;
            NSLog(@"Deserialized JSON array = %@", deserializedArray);
        }
        else
        {
            // some other object was returned
            // dunno how to deal with it as the derisalizer turns only dictionary or arrays
            NSLog(@"Whatever the url gave back wasn't a dictionary or array. it was something else.");
        }
    }
    else if (error !=nil)
    {
        NSLog(@"An error happened while deserializing the JSON data and it's: %@", error);
    }
    
}

#pragma mark - UIWebView Delegate Methods
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    // show loading
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    // do something,  stop hud
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [[[UIAlertView alloc] initWithTitle:@"Sorry@"
                                message:@"Couldn't load the article from the web"
                               delegate:self
                      cancelButtonTitle:nil
                      otherButtonTitles:@"OK", nil] show];
    
    NSLog(@"Web view didn't load, error: %@", error);
    
}
@end
