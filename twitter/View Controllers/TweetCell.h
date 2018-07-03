//
//  TweetCell.h
//  twitter
//
//  Created by Stephanie Lampotang on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetCell : UITableViewCell

@property (strong, nonatomic) User *user; // Contains name, screenname, etc. of tweet author

//user
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
//other info
@property (weak, nonatomic) IBOutlet UIImageView *commentImage;
@property (weak, nonatomic) IBOutlet UIImageView *retweetImage;
@property (weak, nonatomic) IBOutlet UIImageView *favoriteImage;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoriteLabel;
@property (nonatomic) BOOL retweeted;
@property (nonatomic) BOOL favorited;
@property (strong, nonatomic) NSString *idStr;
@property (weak, nonatomic) IBOutlet UILabel *createdAtString;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (strong, nonatomic) Tweet *tweet;

-(void) setTweet:(Tweet *)tweet;

@end
