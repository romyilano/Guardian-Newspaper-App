//
//  SongzaClient.h
//  RomyIlano-Songza
//
//  Created by Romy Ilano on 12/17/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
// AFNetworking shared client

#import "AFHTTPClient.h"

@interface GuardianAFHTTPClient : AFHTTPClient
+(instancetype)sharedClient;
@end
