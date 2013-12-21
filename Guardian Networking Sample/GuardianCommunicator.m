//
//  GuardianCommunicator.m
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/9/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import "GuardianCommunicator.h"
#import "GuardianAPIHelper.h"
#import "Constants.h"

@interface GuardianCommunicator ()
-(void)fetchContentAtURL:(NSURL *)url errorHandler:(void(^)(NSError *error))errorBlock successHandler:(void(^)(NSString *objectNotation)) successBlock;
-(void)launchConnectionForRequest:(NSURLRequest *)request;
@end

@implementation GuardianCommunicator

-(void)launchConnectionForRequest:(NSURLRequest *)request
{
    [self cancelAndDiscardURLConnection];
    fetchingConnection = [NSURLConnection connectionWithRequest:request
                                                       delegate:self];
}

-(void)fetchContentAtURL:(NSURL *)url errorHandler:(void (^)(NSError *))errorBlock successHandler:(void (^)(NSString *))successBlock
{
    fetchingURL = url;
    errorHandler = [errorBlock copy];
    successHandler = [successBlock copy];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:fetchingURL];
    
    [self launchConnectionForRequest:request];
}

-(void)searchForArticlesWithSearchTerm:(NSString *)searchTerm
{
  //
}

@end
