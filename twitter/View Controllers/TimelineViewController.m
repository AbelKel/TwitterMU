//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"
#import "User.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *arrayOfTweets;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

- (IBAction)didTapLogout:(id)sender;

@end

@implementation TimelineViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    
    [self getTimeline];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getTimeline) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [self.tableView reloadData];

}
    // Get timeline
- (void)getTimeline{
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            for (Tweet *tweet in tweets) {
                NSString *text = tweet.text;
                NSLog(@"%@", text);
                self.arrayOfTweets = (NSMutableArray *)tweets;
                
                [self.tableView reloadData];
            }
        } else {
            NSLog(@"Error getting home timeline: %@", error.localizedDescription);
        }
    }];
    [self.refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didTweet:(Tweet *)tweet {
    [self.arrayOfTweets addObject:tweet]; // makes the tweet apper 
    [self.tableView reloadData];
}


- (IBAction)didTapLogout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    // Clear out the access token
    [[APIManager shared] logout];
}
// 1) Method for UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfTweets.count;
}

- (nonnull UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    Tweet *tweet = self.arrayOfTweets[indexPath.row];
    
    cell.tweet = tweet;
    cell.name.text = tweet.user.name;
    cell.tweetContent.text = tweet.text;
    cell.userName.text = tweet.user.screenName;
    cell.postDate.text = tweet.createdAtString;
    cell.noLikes.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    cell.retweetNumber.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    cell.noReply.text = [NSString stringWithFormat:@"%d", tweet.replyCount];
   
    
    NSString *URLString = tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    [cell.profilePicture setImageWithURL: url];

    
    return cell;
    
}



//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *URLString = tweetContent.user.profilePicture;
//    NSURL *url = [NSURL URLWithString:URLString];
//    NSData *urlData = [NSData dataWithContentsOfURL:url];
//}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    UINavigationController *navigationController = [segue destinationViewController];
//    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
//    ComposeViewController.delegate = self;
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   UINavigationController *navigationController = [segue destinationViewController];
   ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
   composeController.delegate = self;
}



@end
