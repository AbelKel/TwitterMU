//
//  ComposeViewController.m
//  twitter
//
//  Created by Abel Kelbessa on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeDraft;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetTweet;
@property (weak, nonatomic) IBOutlet UITextView *tweetDraft;


@end

@implementation ComposeViewController


- (IBAction)tweetSendButton:(id)sender {
    [[APIManager shared]postStatusWithText:self.tweetDraft.text completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"%@", self.tweetDraft.text);
            NSLog(@"Compose Tweet Success!");
            [[APIManager shared]postStatusWithText:self.tweetDraft.text completion:^(Tweet *tweet, NSError *error) {
                if(error){
                    NSLog(@"Error composing Tweet: %@", error.localizedDescription);
                }
                else{
                    [self.delegate didTweet:tweet];
                    //NSLog(@"Compose Tweet Success!");
                }
            }];
        }
    }];
    [self dismissViewControllerAnimated:true completion:nil];
}

        

- (IBAction)closeButton:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [[APIManager shared] postStatusWithText:self.tweetDraft.text completion:nil];
    
}

- (void)didTweet:(Tweet *)tweet {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
