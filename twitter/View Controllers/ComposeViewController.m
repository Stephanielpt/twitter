//
//  ComposeViewController.m
//  AFNetworking
//
//  Created by Stephanie Lampotang on 7/3/18.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>

@interface ComposeViewController () <ComposeViewControllerDelegate, UITextViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (weak, nonatomic) IBOutlet UILabel *characterLabel;
@property (strong, nonatomic) User *user;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tweetTextView.delegate = self;
    self.tweetTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tweetTextView.layer.borderWidth = 1.0;
    [[APIManager shared] getUserInfo:^(User *user, NSError *error) {
        if (user) {
            self.user = user;
            NSLog(@"😎😎😎 Successfully grabbed user data");
        } else {
            NSLog(@"😫😫😫 Error grabbing user data: %@", error.localizedDescription);
        }
        //        [self.tableView reloadData];
        [self.profilePic setImageWithURL:self.user.profilePic];
        self.profilePic.layer.cornerRadius = 20;
    }];
    self.tweetTextView.layer.cornerRadius = 20;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    // TODO: Check the proposed new text character count
    // Allow or disallow the new text
    // Set the max character limit
    int characterLimit = 140;
    
    // Construct what the new text would be if we allowed the user's latest edit
    NSString *newText = [self.tweetTextView.text stringByReplacingCharactersInRange:range withString:text];
    
    // TODO: Update Character Count Label
    if(newText.length < characterLimit)
    {
        //update countdown;
        self.characterLabel.text = [NSString stringWithFormat:@"%lu", characterLimit - newText.length];
    }
    else {
        //update @"reached maximum characters"
        self.characterLabel.text = @"reached maximum characters";
    }
    // The new text should be allowed? True/False
    return newText.length < characterLimit;
    
}

- (IBAction)onTapClose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)onTapTweet:(id)sender {
    [[APIManager shared] postStatusWithText:(self.tweetTextView.text) completion:^(Tweet *tweet, NSError *error)  {
        if (tweet) {
            [self.delegate didTweet:tweet];
            NSLog(@"hit");
            NSLog(@"Compose Tweet Success!");
            //[self dismissViewControllerAnimated:true completion:nil];
        } else {
            NSLog(@"😫😫😫 Error posting tweet: %@", error.localizedDescription);
        }
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
