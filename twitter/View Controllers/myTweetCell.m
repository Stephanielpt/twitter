//
//  myTweetCell.m
//  twitter
//
//  Created by Stephanie Lampotang on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "myTweetCell.h"
#import "Tweet.h"

@implementation myTweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//-(void) setTweet:(Tweet *)tweet
//{
//    _tweet = tweet;
//    self.user = tweet.user;
//    self.idStr = tweet.idStr;
//    self.tweetText.text = tweet.text;
//    NSString *theAt = @"@";
//    self.screenName.text = [theAt stringByAppendingString: tweet.user.screenName];
//    self.name.text = tweet.user.name;
//    self.favoriteLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
//    [self.profilePic setImageWithURL: self.tweet.user.profilePic];
//    //[self.profilePic setImageWithURL: self.tweet.user.bannerPic];
//    [self.bannerPic setImageWithURL: self.tweet.user.bannerPic];
//    self.profilePic.layer.cornerRadius = 34;
//    self.favoriteButton.selected = self.tweet.favorited;
//    self.retweetButton.selected = self.tweet.retweeted;
//    self.retweetLabel.text =[NSString stringWithFormat:@"%d", tweet.retweetCount];
//    //self.commentImage.image = [UIImage imageNamed:@"commentImage"];
//    NSString *middot = @"· ";
//    self.createdAtString.text = [middot stringByAppendingString: tweet.createdAtString];
//    NSLog(@"%@", tweet.createdAtString);
//}
@end
