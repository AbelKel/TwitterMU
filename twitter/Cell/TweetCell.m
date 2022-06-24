//
//  TweetCell.m
//  twitter
//
//  Created by Abel Kelbessa on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "Tweet.h"
#import "APIManager.h"
#import "User.h"
#import "TimelineViewController.h"
#import "DateTools.h"


@implementation TweetCell


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)didTapRetweet:(id)sender {
    if (self.tweet.retweeted == YES) {
        self.tweet.retweeted = NO;
        [[APIManager shared] unRetweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unRetweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unRetweeted the following Tweet: %@", tweet.text);
                self.tweet = tweet;
                [self refreshRetweet];
            }
        }];
    } else {
        self.tweet.retweeted = YES;
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
                self.tweet = tweet;
                [self refreshRetweet];
            }
        }];
    }

}

- (IBAction)didTapLike:(id)sender {
    if (self.tweet.favorited == YES) {
        self.tweet.favorited = NO;
        [[APIManager shared] unFavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unFavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unFavorited the following Tweet: %@", tweet.text);
                self.tweet = tweet;
                [self refreshLike];
            }
        }];
    } else {
    self.tweet.favorited = YES;
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
             NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            self.tweet = tweet;
            [self refreshLike];
        }
    }];
    }
}


-(void)refreshLike {
    if (self.tweet.favorited == YES){
        self.noLikes.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
        [self.like setImage:[UIImage imageNamed:@"favor-icon-red.png"]forState:UIControlStateNormal];
    }
    if (self.tweet.favorited == NO){
        self.noLikes.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
        [self.like setImage:[UIImage imageNamed:@"favor-icon.png"]forState:UIControlStateNormal];
    }

}

- (void) refreshRetweet {
    if (self.tweet.retweeted == YES) {
        self.retweetNumber.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
        [self.retweet setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState:UIControlStateNormal];
    }
    if (self.tweet.retweeted == NO){
        self.retweetNumber.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
        [self.retweet setImage:[UIImage imageNamed:@"retweet-icon.png"] forState:UIControlStateNormal];
    }
}



@end
