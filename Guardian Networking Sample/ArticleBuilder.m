//
//  ArticleBuilder.m
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/6/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import "ArticleBuilder.h"
#import "Article.h"

@implementation ArticleBuilder

-(NSArray *)articlesFromJSON:(NSString *)objectNotation erorr:(NSError *)error
{
    NSParameterAssert(objectNotation != nil);
    
    NSData *unicodeNotation = [objectNotation dataUsingEncoding:NSUTF8StringEncoding];
    NSError *localError = nil;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:unicodeNotation
                                                    options:0
                                                      error:&localError];
    
    NSDictionary *parsedObject = (id)jsonObject;
    
    // if the parsed object is trash
    if (parsedObject == nil)
    {
        if (error != NULL)
        {
            NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithCapacity:1];
            if(localError != nil)
            {
                [userInfo setObject:localError forKey:NSUnderlyingErrorKey];
            }
            
            error = [NSError errorWithDomain:ArticleBuilderErrorDomain
                                         code:ArticleBuilderInvalidJSONError
                                     userInfo:userInfo];
        }
        return nil;
    }
    
    //
    NSDictionary *responseDict = jsonObject[@"response"];
    
    if (responseDict == nil)
    {
        if (error != NULL)
        {
            error = [NSError errorWithDomain:ArticleBuilderErrorDomain
                                        code:ArticleBuilderMissingDataError
                                    userInfo:nil];
            
        }
    }

    NSArray *returnedArticles = responseDict[@"results"];

    NSMutableArray *results = [NSMutableArray arrayWithCapacity:[returnedArticles count]];
    
    for (NSDictionary *parsedArticle in returnedArticles)
    {
        Article *thisArticle = [[Article alloc] initWithDictionary:parsedArticle];
        [results addObject:thisArticle];
        
    }
    return [results copy];
}

@end
