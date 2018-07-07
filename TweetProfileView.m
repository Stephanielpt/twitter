//
//  TweetProfileView.m
//  twitter
//
//  Created by Stephanie Lampotang on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetProfileView.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>

@interface TweetProfileView ()

@property (weak, nonatomic) IBOutlet UIImageView *bannerPic;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screennameLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetCount;
@property (weak, nonatomic) IBOutlet UILabel *followerCount;
@end

@implementation TweetProfileView

- (void)viewDidLoad {
    [super viewDidLoad];
//    @property (weak, nonatomic) IBOutlet UIImageView *bannerPic;
//    @property (weak, nonatomic) IBOutlet UIImageView *profilePic;
//    @property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *screennameLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *followingCount;
//    @property (weak, nonatomic) IBOutlet UILabel *bioLabel;
//    @property (weak, nonatomic) IBOutlet UILabel *tweetCount;
//    @property (weak, nonatomic) IBOutlet UILabel *followerCount;
    [self.profilePic setImageWithURL:self.user.profilePic];
    [self.bannerPic setImageWithURL:self.user.bannerPic];
    self.nameLabel.text = self.user.name;
    self.screennameLabel.text = self.user.screenName;
    self.bioLabel.text = self.user.bio;
    self.followerCount.text = [NSString stringWithFormat:@"%@", self.user.followerCount];
    self.followingCount.text = [NSString stringWithFormat:@"%@", self.user.followingCount];
    self.tweetCount.text = [NSString stringWithFormat:@"%@", self.user.tweetCount];
    
    
    // Do any additional setup after loading the view.
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
