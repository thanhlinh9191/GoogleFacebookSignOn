//
//  APP_ViewController.m
//  GooogleSignOn
//
//  Created by Hackintosh 01 on 3/17/14.
//  Copyright (c) 2014 Hackintosh 01. All rights reserved.
//

#import "APP_ViewController.h"
#import <GoogleOpenSource/GoogleOpenSource.h>

@interface APP_ViewController ()

@end

@implementation APP_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
     static NSString * const kClientId = @"424751579052-5ad40lnmofu2miqiovl6i06ba73gt0p7.apps.googleusercontent.com";
    
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    //signIn.shouldFetchGoogleUserEmail = YES;  // Uncomment to get the user's email
    
    // You previously set kClientId in the "Initialize the Google+ client" step
    signIn.clientID = kClientId;
    
    // Uncomment one of these two statements for the scope you chose in the previous step
    signIn.scopes = @[ kGTLAuthScopePlusLogin ];  // "https://www.googleapis.com/auth/plus.login" scope
    //signIn.scopes = @[ @"profile" ];            // "profile" scope
    
    // Optional: declare signIn.actions, see "app activities"
    signIn.delegate = self;
    
    //tu dong login
   // [signIn trySilentAuthentication];
}


-(void)finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error{
    NSLog(@"Received error %@ and auth object %@",error, auth);
    if (error) {
        // Do some error handling here.
    } else {
        [self refreshInterfaceBasedOnSignIn];
        //view token status
        [self.twStatus setText:[NSString stringWithFormat:@"access token: %@",auth.accessToken]];
        //tien hanh signout
       // [self signOut];
    }
}


//thuc hien khi login thanh cong
-(void)refreshInterfaceBasedOnSignIn
{
    if ([[GPPSignIn sharedInstance] authentication]) {
        // The user is signed in.
        self.signInButton.hidden = YES;
        // Perform other actions here, such as showing a sign-out button
        
    } else {
        self.signInButton.hidden = NO;
        // Perform other actions here
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)signOut {
    [[GPPSignIn sharedInstance] signOut];
}
- (void)disconnect {
    [[GPPSignIn sharedInstance] disconnect];
}

- (void)didDisconnectWithError:(NSError *)error {
    if (error) {
        NSLog(@"Received error %@", error);
    } else {
        // The user is signed out and disconnected.
        // Clean up user data as specified by the Google+ terms.
    }
}

@end
