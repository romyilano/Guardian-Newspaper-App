//
//  Fields.m
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/22/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import "Fields.h"

@implementation Fields

+(Fields *)fieldsWithJSONDictionary:(NSDictionary *)JSONDictionary
{
    Fields *fields = [[Fields alloc] initWithJSONDictionary:JSONDictionary];
    return fields;
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
        
        _shortURL = [NSURL URLWithString:_shortURLAsString];
        _thumbnailURL = [NSURL URLWithString:_thumbnailURLAsString];
        
        _commentable = [_commentableAsString isEqualToString:@"true"] ? YES : NO;
        _lastModifiedDate = [self formatShortDateFromString:_lastModifiedDateAsString];
        
        _wordCount = [NSNumber numberWithInt:[_wordcountAsString integerValue]];
        
        // to-do: newspaper editation date
        // to-do - newpspaer page number
        
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

-(NSNumber *)wordCount
{
    if (!_wordCount)
    {
        _wordCount = [NSNumber numberWithInt:[_wordcountAsString integerValue]];
    }
    
    return _wordCount;
}

#pragma mark - DateFormat Helper
-(NSDate *)formatShortDateFromString:(NSString *)dateAsString
{
    NSDateFormatter  *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    
    NSDate *shortDate = [dateFormatter dateFromString:dateAsString];
    return shortDate;
}

@end
