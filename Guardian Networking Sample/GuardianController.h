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
                          results:(void(^)(NSArray *results, BOOL success, NSError *error))completionBlock;
@end
