//
//  GuardianManager.m
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/8/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import "GuardianManager.h"
#import "ArticleBuilder.h"
#import "Article.h"

#import "Constants.h"
#import "GuardianAPIHelper.h"

@interface GuardianManager ()


@end

@implementation GuardianManager

-(void)setDelegate:(id<GuardianManagerDelegate>)newDelegate
{
    if (newDelegate && ![newDelegate conformsToProtocol:@protocol(GuardianManagerDelegate)])
    {
        [[NSException exceptionWithName:NSInvalidArgumentException
                                 reason:@"Delegate object does not conform to the delegate protocol"
                               userInfo:nil] raise];
    }
    _delegate = newDelegate;
}
    
// grab the list of guardian articles for the search term
-(NSURLRequest *)getURLRequest:(NSString *)searchTerm
{
    NSMutableString *urlAsString = [[NSMutableString alloc] initWithString:guardianSearchURL];
    
    NSString *searchString = [NSString stringWithFormat:@"?q=%@", searchTerm];
    NSString *guardianKeyString = [NSString stringWithFormat:@"&api-key=%@", kGuardianKey];
    
    [urlAsString appendString:searchString];
    [urlAsString appendString:guardianKeyString];
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:30.0f];

    return urlRequest;
    
}

-(NSArray *)processArticleDataResponse:(NSData *)responseData withConnectionError:(NSError *)connectionError
{

    NSString *dataString = [[NSString alloc] initWithData:responseData
                                               encoding:NSUTF8StringEncoding];

    NSArray *articles = [self.articleBuilder articlesFromJSON:dataString
                                                        erorr:connectionError];
    
    if ((articles.count < 1) || connectionError != nil)
    {
        NSLog(@"The data didn't go through");
    }

    return articles;
}



    
@end
