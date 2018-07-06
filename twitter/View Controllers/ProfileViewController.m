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

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *followerCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetCountLabel;
@property (strong, nonatomic) User *user;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
        self.nameLabel.text = self.user.name;
        self.usernameLabel.text = [@"@" stringByAppendingString: self.user.screenName ];
        self.bioLabel.text = self.user.bio;
        self.followerCountLabel.text = [NSString stringWithFormat:@"%@", self.user.followerCount];
        self.followingCountLabel.text = [NSString stringWithFormat:@"%@", self.user.followingCount];
        self.tweetCountLabel.text = [NSString stringWithFormat:@"%@", self.user.tweetCount];
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

@end
