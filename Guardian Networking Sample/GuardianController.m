//
//  GuardianController.m
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/21/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import "GuardianController.h"
#import "AFNetworking/AFNetworking.h"

#import "GuardianAFHTTPClient.h"

#import "Constants.h"
#import "GuardianAPIHelper.h"


@implementation GuardianController
+ (id)sharedController
{
    static dispatch_once_t onceToken;
    static GuardianController *guardianController;
    dispatch_once(&onceToken, ^{
        
        // to-do ask
        // difference between self alloc / GuardianController malloc
        guardianController = [[self alloc] init];
    });
    return guardianController;
}

-(id)init
{
    self = [super init];
    if (!self) return nil;
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    return self;
}

-(void)loadArticlesWithSearchTerm:(NSString *)searchTerm results:(void (^)(NSArray *, BOOL, NSError *))completionBlock
{
    
   // NSString *baseURLString = guardianBaseURL;
    NSString *searchPath = @"search";
    
    // http://content.guardianapis.com/search?q=snowboard&show-tags=all&date-id=date%2Flast7days&api-key=5x23fnrsr4hr23zhe58aawjf
    NSDictionary *parameters = @{ @"q" : searchTerm,
                                  @"show-tags" : @"all",
                                  @"date-id" : @"date%2Flast7days",
                                  @"api-key" : kGuardianKey };
    
    [[GuardianAFHTTPClient sharedClient] registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [[GuardianAFHTTPClient sharedClient] setDefaultHeader:@"Accept" value:@"application/json"];
    
    [[GuardianAFHTTPClient sharedClient] getPath:searchPath
                                      parameters:parameters
                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                             
                                             NSLog(@"response obj: %@", responseObject);
                                             
                                             NSArray *rawArticleArray = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                                                        options:kNilOptions
                                                                                                                 error:nil];
                                             
                                             NSLog(@"what does the response look like? %@", rawArticleArray);
                                             
                                             if (completionBlock)
                                             {
                                                 completionBlock((NSArray *)responseObject, YES, nil);
                                             }
                                             
                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                             
                                             if (completionBlock)
                                             {
                                                 completionBlock([NSArray array], NO, error);
                                             }
                                             
                                         }];
    
    
}

@end
