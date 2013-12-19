//
//  GuardianCommuincatorDelegate.h
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/9/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GuardianCommuincatorDelegate <NSObject>

// signal from communicator that fetching articles has failed

-(void)searchingForArticlesFailedWithError:(NSError *)error;

// communicator received a response from the guardian search
-(void)receivedArticlesJSON:(NSString *)objectNotation;


@end
