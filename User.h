//
//  User.h
//  twitter
//
//  Created by Stephanie Lampotang on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName;
@property (strong, nonatomic) NSURL *profilePic;
@property (strong, nonatomic) NSURL *bannerPic;
@property (strong, nonatomic) NSString *bio;
@property (strong, nonatomic) NSNumber *followerCount;
@property (strong, nonatomic) NSNumber *followingCount;
@property (strong, nonatomic) NSNumber *tweetCount;
// Create initializer
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
