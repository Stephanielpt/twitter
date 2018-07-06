//
//  DetailTweetView.m
//  twitter
//
//  Created by Stephanie Lampotang on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "DetailTweetView.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>
#import "APIManager.h"

@interface DetailTweetView ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

@end

@implementation DetailTweetView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.profilePic.layer.cornerRadius = 36;
    [self.profilePic setImageWithURL:self.tweet.user.profilePic];
    self.nameLabel.text = self.tweet.user.name;
    self.usernameLabel.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    self.tweetText.text = self.tweet.text;
    self.dateLabel.text = self.tweet.createdAtString;
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    if(self.tweet.retweetCount == 1)
    {
        self.retweetLabel.text = @"Retweet";
    }
    else {
        self.retweetLabel.text = @"Retweets";
    }
    self.likeCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    if(self.tweet.favoriteCount == 1)
    {
        self.likeLabel.text = @"Like";
    }
    else {
        self.likeLabel.text = @"Likes";
    }
    self.retweetButton.selected = self.tweet.retweeted;
    self.favoriteButton.selected = self.tweet.favorited;
}

- (IBAction)onTapRetweet:(id)sender {
    // TODO: Update the local tweet model
    self.tweet.retweeted = !self.tweet.retweeted;
    if(self.tweet.retweeted)
    {
        self.tweet.retweetCount += 1;
    }
    else {
        self.tweet.retweetCount -= 1;
    }
    self.retweetCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    // TODO: Update cell UI
    self.retweetButton.selected = self.tweet.retweeted;
    //[self.delegate didRetweet:self.tweet];
    // TODO: Send a POST request to the POST retweeted/create endpoint
    if(self.tweet.retweeted)
    {
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
    else {
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
    [self.delegate changedInDetailView:self.tweet];
}

- (IBAction)onTapFavorite:(id)sender {
    // TODO: Update the local tweet model
    self.tweet.favorited = !self.tweet.favorited;
    if(self.tweet.favorited)
    {
        self.tweet.favoriteCount += 1;
    }
    else {
        self.tweet.favoriteCount -= 1;
    }
    self.likeCountLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    // TODO: Update cell UI
    self.favoriteButton.selected = self.tweet.favorited;
    // refreshCell()
    //[self.delegate didLike:self.tweet];
    // TODO: Send a POST request to the POST favorites/create endpoint
    if(self.tweet.favorited)
    {
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    else {
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    [self.delegate changedInDetailView:self.tweet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
