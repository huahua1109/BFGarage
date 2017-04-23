//
//  AppContext.m
//  BFGarage
//
//  Created by baiyufei on 2017/4/23.
//  Copyright © 2017年 com.autohome. All rights reserved.
//

#import "AppContext.h"

@implementation AppContext

static AppContext *shareAppContext = nil;
+ (AppContext *)sharedAppContext
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareAppContext = [[AppContext alloc] init];
    });
    return shareAppContext;
}



@end
