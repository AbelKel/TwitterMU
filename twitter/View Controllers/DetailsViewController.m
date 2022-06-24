//
//  DetailsViewController.m
//  twitter
//
//  Created by Abel Kelbessa on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "APIManager.h"
#import "TimelineViewController.h"
#import "User.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *detailsImage;
@property (weak, nonatomic) IBOutlet UILabel *detailsName;
@property (weak, nonatomic) IBOutlet UILabel *detailsUserName;
@property (weak, nonatomic) IBOutlet UILabel *tweetDetailsDetails;
@property (weak, nonatomic) IBOutlet UILabel *detailsLikes;
@property (weak, nonatomic) IBOutlet UILabel *detailsRetweets;
@property (weak, nonatomic) IBOutlet UILabel *detailsDate;


@end

@implementation DetailsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailsName.text = self.tweet.user.name;
    self.detailsUserName.text = self.tweet.user.screenName;
    self.tweetDetailsDetails.text = self.tweet.text;
    self.detailsRetweets.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.detailsLikes.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.detailsDate.text = self.tweet.createdAtString;

    NSString *URLString = self.tweet.user.profilePicture;
    NSString *stringWithoutNormal = [URLString stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    NSURL *urlNew = [NSURL URLWithString:stringWithoutNormal];
    [self.detailsImage setImageWithURL: urlNew];
    
    self.detailsImage.layer.cornerRadius = self.detailsImage.frame.size.height/2;
    self.detailsImage.layer.masksToBounds = YES;
    self.detailsImage.layer.borderWidth = 0;

}

- (IBAction)didTapLike:(id)sender {
    if (self.tweet.favorited == YES) {
        self.tweet.favorited = NO;
        [[APIManager shared] unFavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error UNretweeting tweet: %@", error.localizedDescription); // error statemenet needed
            }
            else{
                NSLog(@"Successfully Unretweeted the following Tweet: %@", tweet.text);
                self.tweet = tweet;
                [self refreshLike];
            }
        }];
    } else {
    self.tweet.favorited = YES;
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
             NSLog(@"Error favoriting tweet: %@", error.localizedDescription); // error statemenet needed
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            self.tweet = tweet;
            [self refreshLike];
        }
    }];
    }
}

- (IBAction)didTapRetweet:(id)sender {
    if (self.tweet.retweeted == YES) {
        self.tweet.retweeted = NO;
        [[APIManager shared] unRetweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error UNretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully Unretweeted the following Tweet: %@", tweet.text);
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

-(void)refreshLike {
    if (self.tweet.favorited == YES){
        self.detailsLikes.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
        [self.likeDetails setImage:[UIImage imageNamed:@"favor-icon-red.png"]forState:UIControlStateNormal];
    }
    if (self.tweet.favorited == NO){
        self.detailsLikes.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
        [self.likeDetails setImage:[UIImage imageNamed:@"favor-icon.png"]forState:UIControlStateNormal];
    }

}

- (void) refreshRetweet {
    if (self.tweet.retweeted == YES) {
        self.detailsRetweets.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
        [self.retweetDetails setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState:UIControlStateNormal];
    }
    if (self.tweet.retweeted == NO){
        self.detailsRetweets.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
        [self.retweetDetails setImage:[UIImage imageNamed:@"retweet-icon.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)didExit:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


@end
