//
//  GuardianManagerDelegate.h
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/9/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Article;

// Used to indiciate when articles become avilaable, and to ask about doing further processing
@protocol GuardianManagerDelegate <NSObject>

// unable to retrieve articles
-(void)fetchingArticlesFailedWithError:(NSError *)error;

// retrieved list of articles from guardian
-(void)didReceiveArticles:(NSArray *)articles;



@end
