//
//  Article.h
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/6/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject
// note some people like to set property to copy on mutable obj like NSString, NSDictionary etc.

@property (strong, nonatomic) NSString *articleId;
@property (strong, nonatomic) NSString *sectionId;
@property (strong ,nonatomic) NSString *webTitle;

// to be worked on
@property (strong ,nonatomic) NSString *webURLAsString;
@property (strong, nonatomic) NSString *webPublicationDateAsString;
@property (strong,nonatomic) NSString *apiURLAsString; // this goes to a json of the article dict

// initialized
@property (strong, nonatomic) NSDate *webPublicationDate;
@property (strong, nonatomic) NSURL *webURL;
@property (strong, nonatomic) NSURL *apiURL;


-(id)initWithArticleID:(NSString *)articleID
             sectionID:(NSString *)sectionID
              webTitle:(NSString *)webTitle
        webURLAsString:(NSString *)webURLAsString
        apiURLAsString:(NSString *)apiURLasString
webPublicationDateAsString:(NSString *)webPublicanDateAsString;



@end
