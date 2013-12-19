//
//  GuardianCommunicator.h
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/9/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuardianCommuincatorDelegate.h"

@interface GuardianCommunicator : NSObject <NSURLConnectionDataDelegate>
{
    @protected
    NSURL *fetchingURL;
    NSURLConnection *fetchingConnection;
    NSMutableData *receivedData;
    
    @private
    id <GuardianCommuincatorDelegate> __weak delegate;
    void (^errorHandler)(NSError *);
    void (^successHandler)(NSString *);
    
}

@property (weak) id <GuardianCommuincatorDelegate> delegate;

-(void)searchForArticlesWithSearchTerm:(NSString *)searchTerm;

-(void)cancelAndDiscardURLConnection;

@end

extern NSString *GuardianCommunicatorErrorDomain;