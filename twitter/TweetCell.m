//
//  TweetCell.m
//  twitter
//
//  Created by Abel Kelbessa on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"
#import "User.h"
#import "TimelineViewController.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//- (IBAction)didTapFavorite:(id)sender {
//    // TODO: Update the local tweet model
//    // TODO: Update cell UI
//    self.tweet.favorited = YES;
//    self.tweet.favoriteCount += 1;
//    // TODO: Send a POST request to the POST favorites/create endpoint
//}

- (IBAction)didTapRetweet:(id)sender {
    self.tweet.retweeted = YES;
    self.tweet.retweetCount += 1;
    [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
             NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            self.tweet = tweet;
            [self refreshViews];
        }
    }];

}
- (IBAction)didTapLike:(id)sender {
//    if(self.tweet.favorited) {
//
//    } else {
//
//    }
    
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
             NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            self.tweet = tweet;
            [self refreshViews];
        }
    }];
    
}
    

-(void)refreshViews {
    if (self.tweet.retweeted == YES) {
        [self.retweet setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState:UIControlStateNormal];
    } else {
        [self.retweet setImage:[UIImage imageNamed:@"retweet-icon.png"] forState:UIControlStateNormal];
    }
    if (self.tweet.favorited == YES){
        [self.like setImage:[UIImage imageNamed:@"favor-icon-red.png"]forState:UIControlStateNormal];
    } else {
        [self.like setImage:[UIImage imageNamed:@"favor-icon.png"]forState:UIControlStateNormal];
    }

}



@end
