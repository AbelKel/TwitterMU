//
//  Tweet.m
//  twitter
//
//  Created by Abel Kelbessa on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "Tweet.h"
#import "User.h"

@implementation Tweet

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];

    if (self) {
        // Is this a re-tweet?
        NSDictionary *originalTweet = dictionary[@"retweeted_status"];
        if (originalTweet != nil) {
            NSDictionary *userDictionary = dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];

            // Change tweet to original tweet
            dictionary = originalTweet;
        }
        self.idStr = dictionary[@"id_str"];
        if([dictionary valueForKey:@"full_text"] != nil) {
              self.text = dictionary[@"full_text"]; // uses full text if Twitter API provided it
          } else {
              self.text = dictionary[@"text"]; // fallback to regular text that Twitter API provided
          }
        //self.text = dictionary[@"text"];
        self.tag = dictionary[@"screen_name"];
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];
        //self.replyCount = [dictionary[@"reply_count"] intValue];
        

        NSDictionary *user = dictionary[@"user"];
        self.user = [[User alloc] initWithDictionary:user];

//        NSString *createdAtOriginalString = dictionary[@"created_at"];
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
//        NSDate *date = [formatter dateFromString:createdAtOriginalString];
//        formatter.dateStyle = NSDateFormatterShortStyle;
//        formatter.timeStyle = NSDateFormatterNoStyle;
//        self.createdAtString = [formatter stringFromDate:date];
        //string that hold the api data
                NSString *createdAtOriginalString = dictionary[@"created_at"];
                //date formatter object to help format the date object we will make
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                // Configure the input format to parse the date string (this is the format codepath uses originally)
                formatter.dateFormat = @"E MMM d HH:mm:ss Z y";

                //Creating a time interval object with the difference between the current time and time the tweet was posted
                //Form two dates to subtract the time between them pretty much
                NSDate *tweetDate = [formatter dateFromString:createdAtOriginalString];
                NSDate *curDate = [NSDate date];
                NSTimeInterval diff = [curDate timeIntervalSinceDate:tweetDate];
                
                //format the created string based on if it was tweeted an hour or more ago or a minute or more ago
                NSInteger interval = diff; // Apparently you can just convert timeintervals to integers
                long seconds = interval % 60; //the integer will be in the format 238132 or smth like that so if we % 60 we get the remaining seconds since each 60 in the interval is a second
                long minutes = (interval / 60) % 60; //dividing by 60 then doing modulo gets the minutes because thats the remaining minutes when dividing by hours
                long hours = (interval / 3600); //this is just the whole number of hours spent
                //then you format the string based on if there were any hours spent if not then minutes if not then seconds like how twitter does
                if(hours > 1) {
                    self.createdAtString = [NSString stringWithFormat:@"%ldh", hours];
                } else if(minutes > 1) {
                    self.createdAtString = [NSString stringWithFormat:@"%ldm", minutes];
                } else {
                    self.createdAtString = [NSString stringWithFormat:@"%lds", seconds];
                }


        
    }
    
    return self;
}

+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries {
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
    }
    return tweets;
}

@end
