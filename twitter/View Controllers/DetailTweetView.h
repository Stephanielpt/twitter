//
//  DetailTweetView.h
//  twitter
//
//  Created by Stephanie Lampotang on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "User.h"

@protocol DetailTweetViewDelegate

- (void)changedInDetailView:(Tweet *)tweet;

@end

@interface DetailTweetView : UIViewController
@property (strong, nonatomic) Tweet *tweet;
@property (nonatomic, weak) id <DetailTweetViewDelegate> delegate;
//@property (strong, nonatomic) NSString *tweetText;
//@property (strong, nonatomic) User *user;
//@property (strong, nonatomic) NSString *dateString;

@end
