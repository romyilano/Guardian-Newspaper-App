//
//  GuardianController.h
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/21/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GuardianController : NSObject
+ (id)sharedController;

// to do enumerate this
-(void)loadArticlesWithParameters:(NSDictionary *)parameters
                             path:(NSString *)path
                           ofType:(NSString *)type
               andCompletionBlock:(void (^)(NSArray *array, BOOL success, NSError *error))completionBlock;

// refactoring so there doesn't have to be a separate sections/editors pick block
-(void)loadArticlesWithParameters:(NSDictionary *)searchParamters
               andCompletionBlock:(void(^)(NSArray *results, BOOL success, NSError *error))completionBlock;

// to-do - phase this out as loadArticlesWithParameters:andCompletionBlock: does the job
// loads articles based on search terms with paramters dictionary
-(void)loadArticlesWithSearchTerm:(NSString *)searchTerm
                    andParameters:(NSDictionary *)searchParameters
                          results:(void(^)(NSArray *results, BOOL success, NSError *error))completionBlock;

// returns an Array of Article objects from a JSON Response Object
-(NSArray *)articlesFromJSONResponseObject:(id)responseObject;

-(NSArray *)goodSections;

@end
