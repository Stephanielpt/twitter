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


@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTapFavorite:(id)sender {
    // TODO: Update the local tweet model
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
    // TODO: Update cell UI
    // TODO: Send a POST request to the POST favorites/create endpoint
}



-(void) setTweet:(Tweet *)tweet
{
    _tweet = tweet;
    self.user = tweet.user;
    self.idStr = tweet.idStr;
    self.tweetText.text = tweet.text;
    self.screenName.text = tweet.user.screenName;
    self.name.text = tweet.user.name;
    self.favoriteLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    [self.profilePic setImageWithURL: self.tweet.user.profilePic];
    self.profilePic.layer.cornerRadius = 25;
//    if(self.retweeted)
//    {
//        self.retweetImage.image = [UIImage imageNamed:@"retweeted"];
//    }
//    else {
//        self.retweetImage.image = [UIImage imageNamed:@"notRetweeted"];
//    }
//    if(self.favorited)
//    {
//        self.favoriteImage.image = [UIImage imageNamed:@"favorited"];
//        //self.
//    }
//    else {
//        self.favoriteImage.image = [UIImage imageNamed:@"notFavorited"];
//    }
    self.retweetLabel.text =[NSString stringWithFormat:@"%d", tweet.retweetCount];
    self.commentImage.image = [UIImage imageNamed:@"commentImage"];
    self.createdAtString.text = tweet.createdAtString;
    NSLog(@"%@", tweet.createdAtString);
}
@end
