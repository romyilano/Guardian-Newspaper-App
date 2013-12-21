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
    }
    return self;
}

-(id)initWithDictionary:(NSDictionary *)dictionaryJSON
{
    
    return [self initWithArticleID:dictionaryJSON[@"apiUrl"]
                         sectionID:dictionaryJSON[@"sectionId"]
                          webTitle:dictionaryJSON[@"webTitle"]
                    webURLAsString:dictionaryJSON[@"webUrl"]
                    apiURLAsString:dictionaryJSON[@"apiUrl"]
        webPublicationDateAsString:dictionaryJSON[@"webPublicationDate"]];
    
}

#pragma mark - setters + getters
-(NSDate *)webPublicationDate
{
    if (!_webPublicationDate)
    {
        NSDateFormatter  *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        // what if there isn't a web publican date as string? to-do
        NSDate *shortDate = [dateFormatter dateFromString:_webPublicationDateAsString];
        _webPublicationDate = shortDate;
    }
    return _webPublicationDate;
}

-(NSURL *)webURL
{
    if (!_webURL)
    {
        _webURL = [NSURL URLWithString:_webURLAsString];
    }
    return _webURL;
}

-(NSURL*)apiURL
{
    if (!_apiURL)
    {
        _apiURL = [NSURL URLWithString:_apiURLAsString];
    }
    return _apiURL;
}


@end
