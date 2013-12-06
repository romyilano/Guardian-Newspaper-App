//
//  ViewController.m
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/6/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//


#import "ViewController.h"
#import "GuardianAPIHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
                               
                               if([data length] > 0 && connectionError == nil)
                               {
                                   NSString *jsondata = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   NSLog(@"json data: %@", jsondata);
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
@end
