//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "ComposeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "DetailTweetView.h"
#import "TweetProfileView.h"

@interface TimelineViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (assign, nonatomic) BOOL isMoreDataLoading;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tweets;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logoutButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *composeTweetButton;
- (void) makeCallToAPI:(UIRefreshControl *)refreshControl;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // Initialize a UIRefreshControl
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(makeCallToAPI:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
    
    // Get timeline
    [self makeCallToAPI:refreshControl];
    [self.tableView reloadData];
}

// Makes a network request to get updated data
// Updates the tableView with the new data
// Hides the RefreshControl
- (void)makeCallToAPI:(UIRefreshControl *)refreshControl {
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSMutableArray *tweets, NSError *error) {
        if (tweets) {
            self.tweets = tweets;
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            for (Tweet *tweet in tweets) {
                NSString *text = tweet.text;
                NSLog(@"%@", text);
            }
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [self.tableView reloadData];
//        self.tableView.rowHeight = 200;
    }];
    // Tell the refreshControl to stop spinning
    [refreshControl endRefreshing];
}

- (void)didTweet:(Tweet *)tweet {
    [self.tweets insertObject:tweet atIndex:0];
    //[self.tweets addObject:tweet];
    NSLog(@"%@", _tweets);
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)changedInDetailView:(Tweet *)tweet {
//    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
//    [self makeCallToAPI:refreshControl];
    for(Tweet *atweet in self.tweets)
    {
        if(atweet.idStr == tweet.idStr)
        {
            atweet.retweeted = tweet.retweeted;
            atweet.favorited = tweet.favorited;
            atweet.retweetCount = tweet.retweetCount;
            atweet.favoriteCount = tweet.favoriteCount;
        }
    }
    [self.tableView reloadData];
    NSLog(@"reloaded the tableview");
}

//- (void)didRetweet:(Tweet *)tweet {
//    [self.tableView reloadData];
//}
//
//
//- (void)didLike:(Tweet *)tweet {
//    //update tweets so that the right tweet in tweets
//    //has an updated fvoited count and bool
////    for(Tweet *aTweet in self.tweets)
////    {
////        if(aTweet.idStr == tweet.idStr)
////        {
////            aTweet.favorited = tweet.favorited;
////            aTweet.favoriteCount = tweet.favoriteCount;
////        }
////    }
//    [self.tableView reloadData];
//}

- (IBAction)onTapLogout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(!self.isMoreDataLoading){
        // Calculate the position of one screen length before the bottom of the results
        int scrollViewContentHeight = self.tableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;
        
        // When the user has scrolled past the threshold, start requesting
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
            self.isMoreDataLoading = true;
            
            // ... Code to load more results ...
            UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
            [refreshControl addTarget:self action:@selector(makeCallToAPI:) forControlEvents:UIControlEventValueChanged];
            [self.tableView insertSubview:refreshControl atIndex:0];
            
            [self makeNewCallToAPI:refreshControl];
        }
    }
}

- (void)makeNewCallToAPI:(UIRefreshControl *)refreshControl {
    [[APIManager shared] getMoreTweets:(self.tweets[19]) completion:^(NSMutableArray *tweets, NSError *error) {
        if (tweets) {
            self.tweets = tweets;
            NSLog(@"😎😎😎 Successfully loaded more tweets");
            for (Tweet *tweet in tweets) {
                NSString *text = tweet.text;
                NSLog(@"%@", text);
            }
        } else {
            NSLog(@"😫😫😫 Error getting more tweets: %@", error.localizedDescription);
        }
        [self.tableView reloadData];
    }];
    // Tell the refreshControl to stop spinning
    [refreshControl endRefreshing];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:(@"composeTweet")])
    {
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
    }
    if([segue.identifier isEqualToString:(@"detailTweet")])
    {
        DetailTweetView *detailTweetView = [segue destinationViewController];

        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Tweet *tweet = self.tweets[indexPath.row];
        detailTweetView.tweet = tweet;
        detailTweetView.tweet.user = tweet.user;
        detailTweetView.tweet.text = tweet.text;
        detailTweetView.tweet.createdAtString = tweet.createdAtString;
        detailTweetView.delegate = self;
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
//    if([segue.identifier isEqualToString:(@"TweetProfile")])
//    {
//        TweetProfileView *tweetProfileView = [segue destinationViewController];
//        
//        TweetCell *tappedCell = sender;
//        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
//        Tweet *tweet = self.tweets[indexPath.row];
//        tweetProfileView.user = tweet.user;
//    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"bruh");
    return self.tweets.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    //cell.delegate = self;
    //cell = movies[indexpath.row];
    Tweet * tweet = self.tweets[indexPath.row];
    [cell setTweet:tweet];
    
//    cell.frame.size.height = CGRectMake(cell.frame.origin.x, cell.frame.origin.x, cell.frame.size.width, 50);
    
    return cell;
}

@end
