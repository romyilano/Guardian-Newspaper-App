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

#import "Article.h"

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
    
    NSDictionary *parameters = @{ @"q" : searchTerm,
                                  @"show-tags" : @"all",
                                  @"date-id" : @"date%2Flast7days",
                                  @"api-key" : kGuardianKey };
    
    [[GuardianAFHTTPClient sharedClient] registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [[GuardianAFHTTPClient sharedClient] setDefaultHeader:@"Accept" value:@"application/json"];
    
    [[GuardianAFHTTPClient sharedClient] getPath:searchPath
                                      parameters:parameters
                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                            
                                             NSDictionary *responseDict = responseObject;
                                             NSDictionary *response2 = responseDict[@"response"];
                                             NSArray *resultsArray = (NSArray *)response2[@"results"];
                                             NSMutableArray *cleanArticleArrayWorking = [[NSMutableArray alloc] initWithCapacity:resultsArray.count];
                                             
                                             // clean up the array and put in clean, properly formatted Article objects
                                             for (NSDictionary *articleObj in resultsArray)
                                             {
                                                 Article *article = [[Article alloc] initWithDictionary:articleObj];
                                                 [cleanArticleArrayWorking addObject:article];
                                             }
                                             
                                             NSArray *finalArray = [NSArray arrayWithArray:cleanArticleArrayWorking];
                                             
                                             if (completionBlock)
                                             {
                                                 completionBlock(finalArray, YES, nil);
                                             }
                                             
                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                             
                                             if (completionBlock)
                                             {
                                                 completionBlock([NSArray array], NO, error);
                                             }
                                             
                                         }];
    
    
}

@end
