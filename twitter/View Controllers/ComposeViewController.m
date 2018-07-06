//
//  ComposeViewController.m
//  AFNetworking
//
//  Created by Stephanie Lampotang on 7/3/18.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController () <ComposeViewControllerDelegate, UITextViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tweetTextView.delegate = self;
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
