//
//  ArticleViewController.m
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/22/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import "ArticleViewController.h"

#import <MBProgressHUD/MBProgressHUD.h>

@interface ArticleViewController ()
{
    MBProgressHUD *hud;
}

@end

@implementation ArticleViewController

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
    self.title = @"Guardian Article";
    self.webView.scalesPageToFit = YES;
    
    // make sure the webview fills the entire screen
    CGRect webViewFrame = [[self view] frame];
    self.webView.frame = webViewFrame;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.article.webURL]];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading Article";
    [hud showWhileExecuting:@selector(waitForTwoSeconds:)
                   onTarget:self
                 withObject:nil animated:YES];
    
}


-(void)waitForTwoSeconds:(id)sender
{
    sleep(2);
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

#pragma mark - UIWebViewDelegate Methods


-(void)webViewDidStartLoad:(UIWebView *)webView
{

}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    [[[UIAlertView alloc] initWithTitle:@"Sorry"
                                message:@"Couldn't load the article"
                               delegate:self
                      cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}



@end
