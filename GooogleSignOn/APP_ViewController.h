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
@property (retain, nonatomic) IBOutlet GPPSignInButton *signInButton;
@property (weak, nonatomic) IBOutlet UITextView *twStatus;

@end
