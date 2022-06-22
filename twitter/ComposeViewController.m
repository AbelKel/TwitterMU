//
//  ComposeViewController.m
//  twitter
//
//  Created by Abel Kelbessa on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
//#import "API/APIManager.m"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeDraft;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetTweet;
@property (weak, nonatomic) IBOutlet UITextView *tweetDraft;


@end

@implementation ComposeViewController



-(void)closeButtonAction:(id)sender {
    if (self.closeDraft) {
        [self dismissViewControllerAnimated:true completion:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[[APIManager shared] postStatusWithText:self.tweetDraft.text completion:nil];
    
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
