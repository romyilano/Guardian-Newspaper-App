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

-(void)loadArticlesWithSearchTerm:(NSString *)searchTerm
                    andParameters:(NSDictionary *)searchParameters
                          results:(void(^)(NSArray *results, BOOL success, NSError *error))completionBlock;

-(void)loadSectionsWithBlock:(void(^)(NSArray *results, BOOL success, NSError *error))completionBlock;

// returns an Array of Article objects from a JSON Response Object
-(NSArray *)articlesFromJSONResponseObject:(id)responseObject;

// returns an Array of Section Objects from a JSON Response Object
-(NSArray *)sectionsFromJSONResponseObject:(id)resopnseObject;

@end
