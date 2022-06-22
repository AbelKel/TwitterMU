//
//  Tweet.h
//  twitter
//
//  Created by Abel Kelbessa on 6/20/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tweet : NSObject

@property (nonatomic, strong) NSString *idStr;
@property (nonatomic, strong) NSString *text;
@property (nonatomic) int favoriteCount;
@property (nonatomic) BOOL favorited;
@property (nonatomic) int retweetCount;
@property (nonatomic) BOOL retweeted;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) NSString *createdAtString; 
@property (nonatomic, strong) User *retweetedByUser;
@property (nonatomic, strong) User *tag;
@property (nonatomic) int replyCount;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries;


@end

NS_ASSUME_NONNULL_END
