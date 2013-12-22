//
//  GuardianController.m
//  Guardian Networking Sample
//
//  Created by Romy Ilano on 12/21/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import "GuardianController.h"
#import "AFNetworking/AFNetworking.h"

@implementation GuardianController
+ (id)sharedController
{
    static dispatch_once_t onceToken;
    static GuardianController *guardianController;
    dispatch_once(&onceToken, ^{
        
        // to-do ask
        // difference between self alloc / GuardianController malloc
        guardianController = [[self alloc] init];
    });
    return guardianController;
}

-(id)init
{
    self = [super init];
    if (!self) return nil;
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    return self;
}

@end
