//
//  ArticleBuilder.h
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/6/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import <Foundation/Foundation.h>
#define ArticleBuilderErrorDomain @"ArticleBuilderErrorDomain"

@class Article;
@interface ArticleBuilder : NSObject
/**
 * from Graham lee's browseroverflow
 * Given a string containing a JSON Dict, return
 * a list of Article objects
 * @param objectNotation - the JSON Sring
 * @param error by - ref error signaling
 * @return an array of Articl eobjects, or nil (with error set) if objectnotation can't be parsed
 * @see Article
 */
-(NSArray *)articlesFromJSON:(NSString *)objectNotation erorr:(NSError *)error;

@end


enum {
    ArticleBuilderInvalidJSONError,
    ArticleBuilderMissingDataError
};