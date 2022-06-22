//
//  TweetCell.h
//  twitter
//
//  Created by Abel Kelbessa on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell

//property

@property (strong, nonatomic) Tweet *tweet;

// Outlets
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *tweetContent;
@property (weak, nonatomic) IBOutlet UILabel *postDate;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *reply;
@property (weak, nonatomic) IBOutlet UIImageView *like;
@property (weak, nonatomic) IBOutlet UIImageView *directMessage;
@property (weak, nonatomic) IBOutlet UILabel *noReply;
@property (weak, nonatomic) IBOutlet UILabel *retweetNumber;
@property (weak, nonatomic) IBOutlet UIImageView *retweet;
@property (weak, nonatomic) IBOutlet UILabel *noLikes;


@end

NS_ASSUME_NONNULL_END
