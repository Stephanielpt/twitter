//
//  ComposeViewController.h
//  AFNetworking
//
//  Created by Stephanie Lampotang on 7/3/18.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@protocol ComposeViewControllerDelegate

- (void)didTweet:(Tweet *)tweet;

@end

@interface ComposeViewController : UIViewController
@property (nonatomic, weak) id <ComposeViewControllerDelegate> delegate;

@end
