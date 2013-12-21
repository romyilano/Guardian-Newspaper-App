//
//  SongzaClient.m
//  RomyIlano-Songza
//
//  Created by Romy Ilano on 12/17/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import "GuardianAFHTTPClient.h"
#import "GuardianAPIHelper.h"

@implementation GuardianAFHTTPClient
+(instancetype)sharedClient
{
    static GuardianAFHTTPClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[GuardianAFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:guardianBaseURL]];
        
    });
    return _sharedClient;
}
@end
