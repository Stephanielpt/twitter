//
//  APIManager.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "APIManager.h"
#import "Tweet.h"
#import "User.h"

static NSString * const baseURLString = @"https://api.twitter.com";
static NSString * const consumerKey = @"U809QqUfHK8skbvy9vz6ECJ60"; // Enter your consumer key here
static NSString * const consumerSecret = @"axTkGtAuyDjoVnE4DxLVgyKdMnPuvauqt7daJqu6YYU7hjPJLh"; // Enter your consumer secret here

@interface APIManager()

@end

@implementation APIManager

+ (instancetype)shared {
    static APIManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype)init {
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSString *key = consumerKey;
    NSString *secret = consumerSecret;
    // Check for launch arguments override
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-key"]) {
        key = [[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-key"];
    }
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-secret"]) {
        secret = [[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-secret"];
    }
    
    self = [super initWithBaseURL:baseURL consumerKey:key consumerSecret:secret];
    if (self) {
        
    }
    return self;
}

//+ (void)logout {
//    // 1. Clear current user
//    User.current = nil;
//    
//    // TODO: 2. Deauthorize OAuth tokens
//    
//    // 3. Post logout notification
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"didLogout" object:nil];
//}

- (void)getHomeTimelineWithCompletion:(void(^)(NSMutableArray *tweets, NSError *error))completion {
    
    [self GET:@"1.1/statuses/home_timeline.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSMutableArray *  _Nullable tweetDictionaries) {
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tweetDictionaries];
        [[NSUserDefaults standardUserDefaults] setValue:data forKey:@"hometimeline_tweets"];
        
        //success
        NSMutableArray * tweets = [Tweet tweetsWithArray:tweetDictionaries];
        completion(tweets, nil);
   }
      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          //failure
          NSMutableArray *tweetDictionaries = nil;
          completion(nil, error);
          NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:@"hometimeline_tweets"];
          if(data != nil)
          {
              tweetDictionaries = [NSKeyedUnarchiver unarchiveObjectWithData:data];
          }
          completion(nil, error);
      }];
}
     
- (void)postStatusWithText:(NSString *)text completion:(void (^)(Tweet *, NSError *))completion{
    NSString *urlString = @"1.1/statuses/update.json";
    NSDictionary *parameters = @{@"status": text};
    
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void)getUserInfo:(void(^)(User *user, NSError *error))completion {
    
    [self GET:@"1.1/account/verify_credentials.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable theuser) {
        
        //NSDictionary *userInfo = theuser;
//        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:theuser];
        //[[NSUserDefaults standardUserDefaults] setValue:data forKey:@"hometimeline_tweets"];
        
        //function to turn a dictionary into a user...
            // in user.m
        
//        User *myUser;
//        myUser.bio = theuser[@"description"];
//        myUser.followerCount = theuser[@"followers_count"];
//        myUser.tweetCount = theuser[@"statuses_count"];
//        myUser.name = theuser[@"name"];
//        myUser.screenName = theuser[@"screen_name"];
//        myUser.profilePic = theuser[@"profile_image_url_https"];
//        myUser.bannerPic = theuser[@"profile_background_image_url_https"];
//        myUser.followingCount = theuser[@"friends_count"];
        
        //success
        User *myUser = [[User alloc] initWithDictionary:theuser];
        completion(myUser, nil);

    }
      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          //failure
          NSMutableArray *tweetDictionaries = nil;
          completion(nil, error);
      }];
}

- (void)retweet:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion{
    //https://api.twitter.com/1.1/statuses/retweet/:id.json
    NSString *urlString = @"1.1/statuses/retweet/";
    NSString *urlStringNew = [urlString stringByAppendingString:(NSString *)tweet.idStr];
    NSString *urlStringFinal = [urlStringNew stringByAppendingString:@".json"];
//    NSDictionary *parameters = @{@"id": tweet.idStr};
    NSDictionary *parameters = @{};
    [self POST:urlStringFinal parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void)favorite:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion{
    
    NSString *urlString = @"1.1/favorites/create.json";
    NSDictionary *parameters = @{@"id": tweet.idStr};
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void)unretweet:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion{
    
    NSString *urlString = @"1.1/statuses/unretweet/";
    NSString *urlStringNew = [urlString stringByAppendingString:(NSString *)tweet.idStr];
    NSString *urlStringFinal = [urlStringNew stringByAppendingString:@".json"];
    NSDictionary *parameters = @{};
    [self POST:urlStringFinal parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

- (void)unfavorite:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion{
    
    NSString *urlString = @"1.1/favorites/destroy.json";
    NSDictionary *parameters = @{@"id": tweet.idStr};
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}
//       // Cache it
//       NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tweetDictionaries];
//       [[NSUserDefaults standardUserDefaults] setValue:data forKey:@"hometimeline_tweets"];
//
//       if (completion) { completion(tweetDictionaries, nil); }
//
//   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//       if (completion) { completion(nil, error); }
//   }];
//}

@end
