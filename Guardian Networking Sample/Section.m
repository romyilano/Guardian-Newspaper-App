//
//  Section.m
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/24/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import "Section.h"

@implementation Section

-(id)initWithSectionID:(NSString *)sectionID
              webTitle:(NSString *)webTitle
        webURLAsString:(NSString *)webURLAsString
        apiURLAsString:(NSString *)apiURLAsString
{
    if ((self = [super init]))
    {
        _webTitle = webTitle;
        _webURLAsString = webURLAsString;
        _apiURLAsString = apiURLAsString;
        
        _webURL = [NSURL URLWithString:_webURLAsString];
        _apiURL = [NSURL URLWithString:_apiURLAsString];
    }
    return self;
}

-(id)initWithJSONDictionary:(NSDictionary *)JSONDict
{
    return [self initWithSectionID:JSONDict[@"id"]
                          webTitle:JSONDict[@"webTitle"]
                    webURLAsString:JSONDict[@"webUrl"]
                    apiURLAsString:JSONDict[@"apiUrl"]];
}

#pragma mark - setters and getters
-(NSURL *)webURL
{
    if (!_webURL)
    {
        _webURL = [NSURL URLWithString:_webURLAsString];
    }
    return _webURL;
}

-(NSURL *)apiURL
{
    if (!_apiURL)
    {
        _apiURL = [NSURL URLWithString:_apiURLAsString];
    }
    return _apiURL;
}

@end
