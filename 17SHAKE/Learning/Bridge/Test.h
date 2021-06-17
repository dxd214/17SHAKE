//
//  Test.h
//  17SHAKE
//
//  Created by gyh on 2021/6/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Test : NSObject

+ (instancetype)sharedManager;

+ (instancetype)singleManager;

+ (instancetype)defaultManager;

@end

NS_ASSUME_NONNULL_END
