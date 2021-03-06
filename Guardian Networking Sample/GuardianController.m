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
#import "Section.h"

#import "GuardianAPIHelper.h"

@interface GuardianController ()
@property (strong, nonatomic) NSDictionary *defaultParameters;
@end


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
    
    self.defaultParameters =  @{     @"show-tags" : @"all",
                                     @"date-id" : @"date%2Flast7days",
                                     @"api-key" : kGuardianKey };
    
    return self;
}

#pragma mark - Networking Methods

-(void)loadArticlesWithParameters:(NSDictionary *)parameters
                             path:(NSString *)path
                           ofType:(NSString *)type
               andCompletionBlock:(void (^)(NSArray *, BOOL, NSError *))completionBlock
{
    NSMutableDictionary *workingParameters = [[NSMutableDictionary alloc] init];
    
    [workingParameters addEntriesFromDictionary:parameters];
    [workingParameters setObject:kGuardianKey forKey:@"api-key"];
    
    
    [[GuardianAFHTTPClient sharedClient] registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [[GuardianAFHTTPClient sharedClient] setDefaultHeader:@"Accept" value:@"application/json"];
    
    
    [[GuardianAFHTTPClient sharedClient] getPath:path
                                      parameters:[workingParameters copy]
                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                             
                                             NSDictionary *responseObjectDictionary =(NSDictionary *)responseObject;
                                             NSDictionary *responseDictionary = responseObjectDictionary[@"response"];
                                             
                                             NSMutableArray *finalArray = [[NSMutableArray alloc] init];
                                             
                                             if ([type isEqualToString:@"editorsPicks"])
                                             {
                                                 NSArray *editorsPickArray = (NSArray *)responseDictionary[@"editorsPicks"];
                                                 
                                                 for (NSDictionary *articleObj in editorsPickArray)
                                                 {
                                                     Article *article = [[Article alloc] initWithDictionary:articleObj];
                                                     [finalArray addObject:article];
                                                 }
                                                 
                                             } else if ([type isEqualToString:@"sections"])
                                             {
                                                 
                                                 NSArray *sectionsResultsArray = (NSArray *)responseDictionary[@"results"];
                                                
                                                 for (NSDictionary *sectionObj in sectionsResultsArray)
                                                 {
                                                     Section *section = [[Section alloc] initWithJSONDictionary:sectionObj];
                                                     if ([[self goodSections] containsObject:section.sectionID])
                                                     {
                                                          [finalArray addObject:section];
                                                     }
                                                    
                                                 }
                                             } else if ([type isEqualToString:@"articles"])
                                             {
                                                 NSArray *articlesArray = (NSArray *)responseDictionary[@"results"];
                                                 
                                                 for (NSDictionary *articleObj in articlesArray)
                                                 {
                                                     Article *article = [[Article alloc] initWithDictionary:articleObj];
                                                     [finalArray addObject:article];
                                                 }
                                             }
                                             
                                             if (completionBlock)
                                             {
                                                 completionBlock([finalArray copy], YES, nil);
                                             }
                                             
                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                             
                                             if (completionBlock)
                                             {
                                                 completionBlock([NSArray array], NO, error);
                                             }
                                             
                                         }];

}


#pragma mark - Methods to Phase Out
-(void)loadArticlesWithParameters:(NSDictionary *)searchParamters
               andCompletionBlock:(void (^)(NSArray *, BOOL, NSError *))completionBlock
{
    NSString *searchPath = @"search";
    
    [[GuardianAFHTTPClient sharedClient] registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [[GuardianAFHTTPClient sharedClient] setDefaultHeader:@"Accept" value:@"application/json"];
    
    [[GuardianAFHTTPClient sharedClient] getPath:searchPath
                                      parameters:searchParamters
                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                             
                                             NSArray *finalArray = [self articlesFromJSONResponseObject:responseObject];
                                             
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

// to-do- phase this one out as it's redundant
-(void)loadArticlesWithSearchTerm:(NSString *)searchTerm
                    andParameters:(NSDictionary *)searchParameters
                          results:(void (^)(NSArray *, BOOL, NSError *))completionBlock
{
    NSString *searchPath = @"search";

    NSMutableDictionary *finalParameters = [[NSMutableDictionary alloc] init];
    
    if (searchParameters == nil)
    {
        finalParameters = [self.defaultParameters copy];
        
    } else
    {
        [finalParameters setObject:searchTerm forKey:@"q"];
        [finalParameters addEntriesFromDictionary:searchParameters];
    }
    
    [[GuardianAFHTTPClient sharedClient] registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [[GuardianAFHTTPClient sharedClient] setDefaultHeader:@"Accept" value:@"application/json"];
    
    [[GuardianAFHTTPClient sharedClient] getPath:searchPath
                                      parameters:[finalParameters copy]
                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                             
                                             NSArray *finalArray = [self articlesFromJSONResponseObject:responseObject];
                                             
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


#pragma mark - Model Builder Methods
-(NSArray *)articlesFromJSONResponseObject:(id)responseObject
{
    NSDictionary *responseObjectDictionary = responseObject;
    NSDictionary *responseDictionary = responseObjectDictionary[@"response"];
    NSArray *resultsArray = (NSArray *)responseDictionary[@"results"];
    NSMutableArray *cleanArticleArrayWorking = [[NSMutableArray alloc] initWithCapacity:resultsArray.count];
    
    // clean up the array and put in clean, properly formatted Article objects
    
    for (NSDictionary *articleObj in resultsArray)
    {
        Article *article = [[Article alloc] initWithDictionary:articleObj];
        [cleanArticleArrayWorking addObject:article];
    }
    
    return  [NSArray arrayWithArray:cleanArticleArrayWorking];
}

-(NSArray *)goodSections
{
    return @[ @"commentisfree",
              @"world",
              @"lifeandstyle",
              @"technology",
              @"environment",
              @"books",
              @"science",
              @"artanddesign",
              @"film",
              @"music",
              @"politics",
              @"sport",
              @"society"
              ];
}


@end
