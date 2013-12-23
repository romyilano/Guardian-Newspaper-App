//
//  Article.m
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/6/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import "Article.h"
#import "Fields.h"

@implementation Article

-(id)initWithArticleID:(NSString *)articleID
             sectionID:(NSString *)sectionID
              webTitle:(NSString *)webTitle
        webURLAsString:(NSString *)webURLAsString
        apiURLAsString:(NSString *)apiURLasString
        webPublicationDateAsString:(NSString *)webPublicationDateAsString
                 fieldDictionary:(NSDictionary *)fieldDict
{
    if (self = [super init])
    {
        _articleId = articleID;
        _sectionId = sectionID;
        _webTitle = webTitle;
        _webURLAsString = webURLAsString;
        _apiURLAsString = apiURLasString;
        _webPublicationDateAsString = webPublicationDateAsString;
        _fieldDictionary = fieldDict;
        
        _webURL = [NSURL URLWithString:_webURLAsString];
        _apiURL = [NSURL URLWithString:_apiURLAsString];
        
        _fields = [Fields fieldsWithJSONDictionary:_fieldDictionary];
        
        NSDateFormatter  *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
        
        NSDate *shortDate = [dateFormatter dateFromString:_webPublicationDateAsString];
        _webPublicationDate = shortDate;
        
        

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
        webPublicationDateAsString:dictionaryJSON[@"webPublicationDate"]
            fieldDictionary:dictionaryJSON[@"fields"]];
    
}

#pragma mark - setters + getters
-(NSDate *)webPublicationDate
{
    if (!_webPublicationDate)
    {
        NSDateFormatter  *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
       
        NSDate *shortDate = [dateFormatter dateFromString:_webPublicationDateAsString];
        _webPublicationDate = shortDate;
    }
    return _webPublicationDate;
}

// to-do this isn't working yet
-(NSString *)webPublicanDateAsStringForPresentation
{
    if (!_webPublicanDateAsStringForPresentation)
    {
        if (_webPublicationDate)
        {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
           //  [dateFormatter setDateStyle:NSDateFormatterShortStyle];
            [dateFormatter setDateFormat:@"MM-dd-yyyy"];
            NSString *formattedDateString = [dateFormatter stringFromDate:_webPublicationDate];
            _webPublicanDateAsStringForPresentation = formattedDateString;

        }
        else
        {
            return nil;
        }
    }
    return _webPublicanDateAsStringForPresentation;
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

-(Fields *)fields
{
    if (!_fields)
    {
        _fields = [Fields fieldsWithJSONDictionary:_fieldDictionary];
    }
    
    return _fields;
}

@end
