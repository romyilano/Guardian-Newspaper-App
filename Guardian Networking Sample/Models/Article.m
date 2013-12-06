//
//  Article.m
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/6/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import "Article.h"

@implementation Article

-(id)initWithArticleID:(NSString *)articleID
             sectionID:(NSString *)sectionID
              webTitle:(NSString *)webTitle
        webURLAsString:(NSString *)webURLAsString
        apiURLAsString:(NSString *)apiURLasString
        webPublicationDateAsString:(NSString *)webPublicationDateAsString
{
    if (self = [super init])
    {
        _articleId = articleID;
        _sectionId = sectionID;
        _webTitle = webTitle;
        _webURLAsString = webURLAsString;
        _apiURLAsString = apiURLasString;
        _webPublicationDateAsString = webPublicationDateAsString;
      
        // set url
        _webURL = [NSURL URLWithString:_webURLAsString];
        _apiURL = [NSURL URLWithString:_apiURLAsString];
        
        // set the date
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        NSDate *shortDate = [dateFormatter dateFromString:_webPublicationDateAsString];
        
        _webPublicationDate = shortDate;
        
    }
    return self;
}

-(id)initWIthDictionary:(NSDictionary *)dictionaryJSON
{
    if (self = [super init])
    {
        _articleId = dictionaryJSON[@"apiUrl"];
        _sectionId = dictionaryJSON[@"sectionId"];
        _webTitle = dictionaryJSON[@"webTitle"];
        _webURLAsString = dictionaryJSON[@"webUrl"];
        _apiURLAsString = dictionaryJSON[@"apiUrl"];
        _webPublicationDateAsString = dictionaryJSON[@"webPublicationDate"];
        
        // set url
        _webURL = [NSURL URLWithString:_webURLAsString];
        _apiURL = [NSURL URLWithString:_apiURLAsString];
        
        // set the date
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        NSDate *shortDate = [dateFormatter dateFromString:_webPublicationDateAsString];
        
        _webPublicationDate = shortDate;
    }
    
    return self;
}


@end
