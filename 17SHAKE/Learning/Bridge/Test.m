//
//  Test.m
//  17SHAKE
//
//  Created by gyh on 2021/6/11.
//

#import "Test.h"

@implementation Test

static Test *instance = nil;

+ (instancetype)sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[Test alloc] init];
    });
    
    return instance;
}

@end
