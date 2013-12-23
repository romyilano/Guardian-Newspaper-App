//
//  Fields.m
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/22/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import "Fields.h"

@implementation Fields

+(Fields *)fieldFromJSONDict:(NSDictionary *)jsonDict
{
    return [self initWithHeadline:JSONDictionary[@"headline"]
                        trailText:JSONDictionary[@"trailText"]
                       standFirst:JSONDictionary[@"standFirst"]
                 shortURLAsString:JSONDictionary[@"shortUrl"]
             thumbnailURLAsString:JSONDictionary[@"thumbnail"]
         lastModifiedDateAsString:JSONDictionary[@"lastModified"]
                wordCountAsString:JSONDictionary[@"wordcount"]
     newspaperEditionDateAsString:JSONDictionary[@"newspaperEditionDate"]
      newspaperPageNumberAsString:JSONDictionary[@"newspaperPageNumber"]
              commentableAsString:JSONDictionary[@"commentable"]];
}

-(id)initWithHeadline:(NSString *)headline
            trailText:(NSString *)trailText
           standFirst:(NSString *)standfirst
     shortURLAsString:(NSString *)shortURLAsString
 thumbnailURLAsString:(NSString *)thumbnailURLAsString
lastModifiedDateAsString:(NSString *)lastModifiedDateAsString
    wordCountAsString:(NSString *)wordCountAsString
newspaperEditionDateAsString:(NSString *)newspaperEditionDateAsString
newspaperPageNumberAsString:(NSString *)newspaperPageNumberAsString
  commentableAsString:(NSString *)commentableAsString
{
    if ((self = [super init]))
    {
        _headline = headline;
        _trailText = trailText;
        _standfirst = standfirst;
        _shortURLAsString = shortURLAsString;
        _thumbnailURLAsString = thumbnailURLAsString;
        _lastModifiedDateAsString = lastModifiedDateAsString;
        _wordcountAsString = wordCountAsString;
        
        _newspaperEditionDateAsString = newspaperEditionDateAsString;
        _newspaperPageNumberAsString = newspaperPageNumberAsString;
        _commentableAsString = commentableAsString;
        
    }
    return self;
}

-(id)initWithJSONDictionary:(NSDictionary *)JSONDictionary
{
    return [self initWithHeadline:JSONDictionary[@"headline"]
                        trailText:JSONDictionary[@"trailText"]
                       standFirst:JSONDictionary[@"standFirst"]
                 shortURLAsString:JSONDictionary[@"shortUrl"]
             thumbnailURLAsString:JSONDictionary[@"thumbnail"]
         lastModifiedDateAsString:JSONDictionary[@"lastModified"]
                wordCountAsString:JSONDictionary[@"wordcount"]
     newspaperEditionDateAsString:JSONDictionary[@"newspaperEditionDate"]
      newspaperPageNumberAsString:JSONDictionary[@"newspaperPageNumber"]
              commentableAsString:JSONDictionary[@"commentable"]];
}

#pragma mark - Setters & Getters
-(NSURL *)thumbnailURL
{
   return [NSURL URLWithString:_thumbnailURLAsString];
}

-(NSURL *)shortURL
{
    if (!_shortURL)
    {
        if (_shortURLAsString)
        {
            _shortURL = [NSURL URLWithString:_shortURLAsString];
        }
        else
        {
            return nil;
        }
    }
    return _shortURL;
}

-(BOOL)isCommentable
{
    if (!_commentable)
    {
        if (!_commentableAsString)
        {
            return NO;
        }
        else
        {
            if ([_commentableAsString isEqualToString:@"true"])
            {
                _commentable = YES;
            } else if ([_commentableAsString isEqualToString:@"false"])
            {
                _commentable = NO;
            }
            else
            {
                return NO;
            }
        }
    }
    return _commentable;
}


@end
