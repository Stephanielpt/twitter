//
//  TweetCell.m
//  twitter
//
//  Created by Stephanie Lampotang on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>
#import "Tweet.h"
#import "APIManager.h"


@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//
//- (IBAction)didTapRetweet:(id)sender {
//    // TODO: Update the local tweet model
//    self.tweet.retweeted = !self.tweet.retweeted;
//    if(self.tweet.retweeted)
//    {
//        self.tweet.retweetCount += 1;
//    }
//    else {
//        self.tweet.retweetCount -= 1;
//    }
//    // TODO: Update cell UI
//    self.retweetButton.selected = self.tweet.retweeted;
//    [self.delegate didRetweet:self.tweet];
//    // TODO: Send a POST request to the POST retweeted/create endpoint
//}

- (IBAction)didTapFavorite:(id)sender {
    // TODO: Update the local tweet model
    self.tweet.favorited = !self.tweet.favorited;
    if(self.tweet.favorited)
    {
        self.tweet.favoriteCount += 1;
    }
    else {
        self.tweet.favoriteCount -= 1;
    }
    // TODO: Update cell UI
    self.favoriteButton.selected = self.tweet.favorited;
    // refreshCell()
    [self.delegate didLike:self.tweet];
    // TODO: Send a POST request to the POST favorites/create endpoint
//    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
//        if(error){
//            NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
//        }
//        else{
//            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
//        }
//    }];
}



-(void) setTweet:(Tweet *)tweet
{
    _tweet = tweet;
    self.user = tweet.user;
    self.idStr = tweet.idStr;
    self.tweetText.text = tweet.text;
    NSString *theAt = @"@";
    self.screenName.text = [theAt stringByAppendingString: tweet.user.screenName];
    self.name.text = tweet.user.name;
    self.favoriteLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    [self.profilePic setImageWithURL: self.tweet.user.profilePic];
    self.profilePic.layer.cornerRadius = 25;

    self.retweetLabel.text =[NSString stringWithFormat:@"%d", tweet.retweetCount];
    //self.commentImage.image = [UIImage imageNamed:@"commentImage"];
    NSString *middot = @"· ";
    self.createdAtString.text = [middot stringByAppendingString: tweet.createdAtString];
    NSLog(@"%@", tweet.createdAtString);
}
@end
