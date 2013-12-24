//
//  Section.h
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/24/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Section : NSObject
@property (strong, nonatomic) NSString *sectionID;  // id
@property (strong, nonatomic) NSString *webTitle;
@property (strong, nonatomic) NSString *webURLAsString; // webUrl
@property (strong, nonatomic) NSString *apiURLAsString; // apiUrl

@property (strong, nonatomic) NSURL *webURL;
@property (strong, nonatomic) NSURL *apiURL;

-(id)initWithSectionID:(NSString *)sectionID
              webTitle:(NSString *)webTitle
        webURLAsString:(NSString *)webURLAsString
        apiURLAsString:(NSString *)apiURLAsString;

-(id)initWithJSONDictionary:(NSDictionary *)JSONDict;

@end
