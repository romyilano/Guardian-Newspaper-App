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
                               
                               // sweet smell of success
                               if([data length] > 0 && connectionError == nil)
                               {
                                   NSError *error = nil;
                                   
                                   id jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                                                   options:NSJSONReadingAllowFragments
                                                                                     error:&error];
                                   
                                   if (jsonObject != nil && error ==nil)
                                   {
                                       NSLog(@"Successfully deserialized...");
                                       
                                       if ([jsonObject isKindOfClass:[NSDictionary class]])
                                       {
                                           NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
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
                                       }
                                   }
                                   else if (error !=nil)
                                   {
                                       NSLog(@"An error happened while deserializing the JSON data and it's: %@", error);
                                   }
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
