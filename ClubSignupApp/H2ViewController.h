//
//  H2ViewController.h
//  ClubSignupApp
//
//  Created by Hersh Bhargava on 9/14/14.
//  Copyright (c) 2014 H2 Micro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface H2ViewController : UIViewController <MFMailComposeViewControllerDelegate> {
    NSUserDefaults *defaults;
}

@property (strong, nonatomic) NSMutableArray *peopleArray;

@property (weak, nonatomic) IBOutlet UITextField *textField;
- (IBAction)go:(id)sender;
- (IBAction)chicken:(id)sender;


@end
