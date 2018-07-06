//
//  ProfileViewController.m
//  twitter
//
//  Created by Stephanie Lampotang on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>
#import "User.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "myTweetCell.h"

@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UIImageView *bannerPic;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followerCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetCountLabel;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSMutableArray *myTweets;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
    self.profilePic.layer.cornerRadius = 65;
    self.profilePic.layer.borderWidth = 3.0;
    self.profilePic.layer.borderColor = [UIColor whiteColor].CGColor;
    
    // filling in specific data
    [[APIManager shared] getUserInfo:^(User *user, NSError *error) {
        if (user) {
            self.user = user;
            NSLog(@"😎😎😎 Successfully grabbed user data");
        } else {
            NSLog(@"😫😫😫 Error grabbing user data: %@", error.localizedDescription);
        }
        //        [self.tableView reloadData];
        [self.profilePic setImageWithURL:self.user.profilePic];
        [self.bannerPic setImageWithURL:self.user.bannerPic];
        self.nameLabel.text = self.user.name;
        self.usernameLabel.text = [@"@" stringByAppendingString: self.user.screenName ];
        self.bioLabel.text = self.user.bio;
        self.followerCountLabel.text = [NSString stringWithFormat:@"%@", self.user.followerCount];
        self.followingCountLabel.text = [NSString stringWithFormat:@"%@", self.user.followingCount];
        self.tweetCountLabel.text = [NSString stringWithFormat:@"%@", self.user.tweetCount];
    }];
    
    [[APIManager shared] getUserTweets:^(NSMutableArray *tweets, NSError *error) {
        if (tweets) {
            self.myTweets = tweets;
            NSLog(@"😎😎😎 Successfully grabbed users tweets");
        } else {
            NSLog(@"😫😫😫 Error grabbing users tweets: %@", error.localizedDescription);
        }
        [self.tableView reloadData];
    }];
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

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myTweetCell"];
    //cell.delegate = self;
    //cell = movies[indexpath.row];
    Tweet * tweet = self.myTweets[indexPath.row];
    [cell setTweet:tweet];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myTweets.count;
}

@end
