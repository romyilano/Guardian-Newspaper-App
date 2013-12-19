//
//  GuardianManager.h
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/9/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuardianManagerDelegate.h"
#import "GuardianCommuincatorDelegate.h"

@class Article;
@class ArticleBuilder;
@class GuardianCommunicator;

@interface GuardianManager : NSObject <GuardianCommuincatorDelegate>
@property (weak, nonatomic) id <GuardianManagerDelegate> delegate;
@property (strong) GuardianCommunicator *communicator;
@property (strong) ArticleBuilder *articleBuilder;
@property (strong) Article *articleToFetch;

// get articles on a given search term from Guardian Newspaper
-(void)fetchArticlesWithSearchTerm:(NSString *)searchTerm;


@end

extern NSString *GuardianManagerError;

enum {
    GuardianManagerErrorArticleSearchCode,

};
