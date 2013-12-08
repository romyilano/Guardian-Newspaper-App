//
//  GuardianManager.h
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/8/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
// Learning from Graham Lee's Test Driven Development - nice classes

#import <Foundation/Foundation.h>

@class ArticleBuilder, Article;

@protocol GuardianManagerDelegate <NSObject>
// to-do
-(void)fetchingArticlesFailedWithError:(NSError *)error;
-(void)didReceiveQuestions:(NSArray *)questions;

@end

@interface GuardianManager : NSObject

// delegates are weakly held
@property (weak, nonatomic) id <GuardianManagerDelegate> delegate;

@property (strong, nonatomic) ArticleBuilder *articleBuilder;

    
-(NSArray *)processArticleDataResponse:(NSData *)responseData withConnectionError:(NSError *)connectionError;
-(NSURLRequest *)getURLRequest:(NSString *)searchTerm;
@end

#define guardianManagerError    @"GuardianManagerError"


