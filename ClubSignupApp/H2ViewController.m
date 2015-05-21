//
//  H2ViewController.m
//  ClubSignupApp
//
//  Created by Hersh Bhargava on 9/14/14.
//  Copyright (c) 2014 H2 Micro. All rights reserved.
//

#import "H2ViewController.h"
#import "MBProgressHUD.h"
#import <MessageUI/MessageUI.h>

@implementation H2ViewController
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    defaults = [NSUserDefaults standardUserDefaults];
    self.peopleArray = [NSMutableArray array];
}

- (IBAction)go:(id)sender {
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Configure for text only and offset down
	hud.mode = MBProgressHUDModeText;
	hud.margin = 10.f;
	hud.removeFromSuperViewOnHide = YES;
	
	[hud hide:YES afterDelay:3];
    if (![self.textField.text isEqualToString:@""]) {
        NSString *addString = [NSString stringWithFormat:@"%@@exeter.edu", self.textField.text];
        [self.peopleArray addObject:addString];
        self.textField.text = @"";
        hud.labelText = [NSString stringWithFormat:@"%@ added. Congratulations!", addString];
        [hud hide:YES afterDelay:2];

    } else {
        hud.labelText = @"Failed. Please input username.";
        [hud hide:YES afterDelay:2];

    }
    [defaults setObject:[self.peopleArray componentsJoinedByString:@","] forKey:@"primaryData"];
    [defaults synchronize];
}
// Then implement the delegate method
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    if (result == MFMailComposeResultSent) {
        self.peopleArray = [NSMutableArray array];
        [defaults setObject:self.peopleArray forKey:@"primaryData"];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)chicken:(id)sender {
    NSLog(@"%@", [defaults objectForKey:@"primaryData"]);
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
        mailCont.mailComposeDelegate = self;
        
        [mailCont setSubject:@"PEAMUN Signups so far"];
        [mailCont setToRecipients:@[@"hershkbhargava@gmail.com", @"lfriedberg@exeter.edu", @"astucke@exeter.edu"]];
        [mailCont setMessageBody:[defaults objectForKey:@"primaryData"] isHTML:NO];
        
        [self presentViewController:mailCont animated:YES completion:nil];
    }
    
    
}
@end
