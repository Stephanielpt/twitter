//
//  User.m
//  twitter
//
//  Created by Stephanie Lampotang on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profilePic = [NSURL URLWithString:dictionary[@"profile_image_url_https"]];
        self.bannerPic = [NSURL URLWithString:dictionary[@"profile_banner_url"]];
        // Initialize any other properties
        self.bio = dictionary[@"description"];
        self.followerCount = dictionary[@"followers_count"];
        self.tweetCount = dictionary[@"statuses_count"];
        self.followingCount = dictionary[@"friends_count"];
    }
    return self;
}

@end
