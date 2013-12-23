//
//  Fields.h
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/22/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//
// to-do  make appropriate getterseverything is strings

#import <Foundation/Foundation.h>

@interface Fields : NSObject

@property (strong, nonatomic) NSString *shortURLAsString;               // shortUrl
@property (strong, nonatomic) NSString *thumbnailURLAsString;           // thumbnail
@property (strong, nonatomic) NSString *lastModifiedDateAsString;       // lastModified
@property (strong, nonatomic) NSString *wordcountAsString;              // wordcount

@property (strong, nonatomic) NSString *trailText;
@property (strong, nonatomic) NSString *headline;
@property (strong, nonatomic) NSString *standfirst;

@property (strong, nonatomic) NSString *newspaperEditionDateAsString;   // newspaperEditionDate
@property (strong, nonatomic) NSString *newspaperPageNumberAsString;    // newspaperPageNumber
@property (strong, nonatomic) NSString *commentableAsString;            // commentable


@property (strong, nonatomic) NSURL *thumbnailURL;
@property (strong, nonatomic) NSURL *shortURL;
@property (assign, nonatomic, getter = isCommentable) BOOL commentable;

// **** to-do - these need getters
@property (strong, nonatomic) NSDate *lastModifiedDate;
@property (strong, nonatomic) NSNumber *wordCount;

-(id)initWithHeadline:(NSString *)headline
            trailText:(NSString *)trailText
           standFirst:(NSString *)standfirst
     shortURLAsString:(NSString *)shortURLAsString
 thumbnailURLAsString:(NSString *)thumbnailURLAsString
lastModifiedDateAsString:(NSString *)lastModifiedDateAsString
    wordCountAsString:(NSString *)wordCountAsString
newspaperEditionDateAsString:(NSString *)newspaperEditionDateAsString
newspaperPageNumberAsString:(NSString *)newspaperPageNumberAsString
  commentableAsString:(NSString *)commentableAsString;

-(id)initWithJSONDictionary:(NSDictionary*)JSONDictionary;

+(Fields *)fieldFromJSONDict:(NSDictionary *)jsonDict;


@end
