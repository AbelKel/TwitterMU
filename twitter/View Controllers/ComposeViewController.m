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
@property (weak, nonatomic) IBOutlet UILabel *counter;


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

- (void)textViewDidChange:(UITextView *)textView {
    NSString *substring = [NSString stringWithString:_tweetDraft.text];
    if (substring.length > 0) {
        _counter.hidden =NO;
        _counter.text = [NSString stringWithFormat:@"%d characters used", substring.length];
    }
    if (substring.length == 0) {
        _counter.hidden = YES;
    }
    if (substring.length == 140) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"You have used too many characters in your tweet!" message:@"Character limit is 140 tweet." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        _counter.textColor = [UIColor redColor];
    }
    if (substring.length < 15) {
        _counter.textColor = [UIColor greenColor];
    }
}


@end
