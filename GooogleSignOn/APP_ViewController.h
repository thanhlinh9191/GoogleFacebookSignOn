//
//  APP_ViewController.h
//  GooogleSignOn
//
//  Created by Hackintosh 01 on 3/17/14.
//  Copyright (c) 2014 Hackintosh 01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  <GooglePlus/GooglePlus.h>

@interface APP_ViewController : UIViewController<GPPSignInDelegate>
@property (retain, nonatomic) IBOutlet UIButton *btnGoogle;
@property (weak, nonatomic) IBOutlet UITextView *twGoogleStatus;

- (IBAction)clickLoginGoogle:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnFaceBook;
- (IBAction)clickLoginFaceBook:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *twFaceBookStatus;

@end
