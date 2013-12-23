//
//  Article.h
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/6/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Fields;
@interface Article : NSObject
// note some people like to set property to copy on mutable obj like NSString, NSDictionary etc.

@property (strong, nonatomic) NSString *articleId;
@property (strong, nonatomic) NSString *sectionId;
@property (strong ,nonatomic) NSString *webTitle;

@property (strong ,nonatomic) NSString *webURLAsString;
@property (strong, nonatomic) NSString *webPublicationDateAsString;
@property (strong,nonatomic) NSString *apiURLAsString; // this goes to a json of the article dict

// use accessors
@property (strong, nonatomic) NSDate *webPublicationDate;
@property (strong, nonatomic) NSString *webPublicanDateAsStringForPresentation;
@property (strong, nonatomic) NSURL *webURL;
@property (strong, nonatomic) NSURL *apiURL;

// to-do
@property (strong, nonatomic) Fields *fields;

-(id)initWithArticleID:(NSString *)articleID
             sectionID:(NSString *)sectionID
              webTitle:(NSString *)webTitle
        webURLAsString:(NSString *)webURLAsString
        apiURLAsString:(NSString *)apiURLasString
webPublicationDateAsString:(NSString *)webPublicationDateAsString;

-(id)initWithDictionary:(NSDictionary *)dictionaryJSON;

@end
