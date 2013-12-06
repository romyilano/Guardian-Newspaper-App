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
        webPublicationDateAsString:(NSString *)webPublicanDateAsString
{
    if (self = [super init])
    {
        _articleId = articleID;
        _sectionId = sectionID;
        _webTitle = webTitle;
        _webURLAsString = webURLAsString;
        _apiURLAsString = apiURLasString;
        _webPublicationDateAsString = webPublicanDateAsString;
      
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
