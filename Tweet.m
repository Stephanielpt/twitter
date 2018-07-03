//
//  Tweet.m
//  twitter
//
//  Created by Stephanie Lampotang on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "Tweet.h"
#import "User.h"

@implementation Tweet

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        // FROM HERE
//        // Is this a re-tweet?
////        NSDictionary *originalTweet = dictionary[@"retweeted_status"];
//        NSDictionary *originalTweet = dictionary;
//        NSLog(@"%@", originalTweet);
//        if(originalTweet != nil) {
//
////           NSDictionary *userDictionary = dictionary[@"user"];
////            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];
//
//            // Change tweet to original tweet
//            dictionary = originalTweet;
//        }
        // TO HERE WORKED FOR 20
        
        /* THIS IS FROM THE SOURCE */
        // Is this a re-tweet?
        NSDictionary *originalTweet = dictionary[@"retweeted_status"];
        if(originalTweet != nil){
            NSDictionary *userDictionary = dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];
            
            // Change tweet to original tweet
            dictionary = originalTweet;
        }
        /*
        // Is this a re-tweet?
        // yes
        if (![[dictionary allKeys] containsObject:@"retweeted_status"]) {
            // contains key so change tweet to original tweet
            NSDictionary *originalTweet = dictionary[@"retweeted_status"];
        }
        else {
            NSDictionary *originalTweet = dictionary;
            NSDictionary *userDictionary = dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];
            
            // no so stays the same
            dictionary = originalTweet;
        }
        */
        self.idStr = dictionary[@"id_str"];
        self.text = dictionary[@"text"];
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];
        
        // TODO: initialize user
        NSDictionary *user = dictionary[@"user"];
        self.user = [[User alloc] initWithDictionary:user];
        
        // TODO: Format and set createdAtString
        // Format createdAt date string
        NSString *createdAtOriginalString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // Configure the input format to parse the date string
        formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
        // Convert String to Date
        NSDate *date = [formatter dateFromString:createdAtOriginalString];
        // Configure output format
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        // Convert Date to String
        self.createdAtString = [formatter stringFromDate:date];
    }
    return self;
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries{
    NSMutableArray *tweets = [[NSMutableArray alloc] init];
    int x = 0;
    for (NSDictionary *dictionary in dictionaries)
    {
        //if(dictionary[@"retweeted_status"] != nil) {
//        if(dictionary != nil){
            {
                Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
                [tweets addObject:tweet];
//                NSLog(@"%@", tweet);
//                NSLog(@"%lu", (unsigned long)tweets.count);
//                NSLog(@"%d", x);
                x++;
            }
        //}
    }
    return tweets;
}
    


@end
