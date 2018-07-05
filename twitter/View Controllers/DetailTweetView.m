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
