//
//  APP_ViewController.m
//  GooogleSignOn
//
//  Created by Hackintosh 01 on 3/17/14.
//  Copyright (c) 2014 Hackintosh 01. All rights reserved.
//

#import "APP_ViewController.h"
#import "APP_AppDelegate.h"
#import <GoogleOpenSource/GoogleOpenSource.h>

@interface APP_ViewController ()

@end

@implementation APP_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// client id tu google
     static NSString * const kClientId = @"424751579052-5ad40lnmofu2miqiovl6i06ba73gt0p7.apps.googleusercontent.com";
    
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    //signIn.shouldFetchGoogleUserEmail = YES;  // Uncomment to get the user's email
    
    // set client id tu google +
    signIn.clientID = kClientId;
    
    // chon scope : gooogle plus
    signIn.scopes = @[ kGTLAuthScopePlusLogin ];  // "https://www.googleapis.com/auth/plus.login" scope
    //signIn.scopes = @[ @"profile" ];            // "profile" scope
    
    // dung delegate
    signIn.delegate = self;
    
    //tu dong login neu can
    //[signIn trySilentAuthentication];
    //[self.btnGoogle setTitle:@"Logout Google" forState:UIControlStateNormal];
    
    //set text for twGoogleStatus
    [self.twGoogleStatus setText:@"Login to create a link to fetch account data"];
    
    
    [[GPPSignIn sharedInstance] authenticate];
    [[GPPSignIn sharedInstance] SET];
    
    //THIS PART FOR FACEBOOK APP
    [self updateView];
    
    APP_AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (!appDelegate.session.isOpen) {
        // tao doi tuong session moi
        appDelegate.session = [[FBSession alloc] init];
        
        if (appDelegate.session.state == FBSessionStateCreatedTokenLoaded)
        {
            // even though we had a cached token, we need to login to make the session usable
            [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                             FBSessionState status,
                                                             NSError *error) {
                // we recurse here, in order to update buttons and labels
                [self updateView];
            }];
        }
    }

}


-(void)finishedWithAuth:(GTMOAuth2Authentication *)auth error:(NSError *)error{
    NSLog(@"Received error %@ and auth object %@",error, auth);
    if (error) {
        // Do some error handling here.
    } else {
        //view token status
        [self.twGoogleStatus setText:[NSString stringWithFormat:@"Google access token: %@",auth.accessToken]];
        //tien hanh signout
       // [self signOut];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didDisconnectWithError:(NSError *)error {
    if (error) {
        NSLog(@"Received error %@", error);
    } else {
          NSLog(@"Disconnect Google Successful");
    }
}

//update view for facebook satus
-(void) updateView {
    
    // get the app delegate, so that we can reference the session property
    APP_AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (appDelegate.session.isOpen) {
        [self.btnFaceBook setTitle:@"Log out FaceBook" forState:UIControlStateNormal];
        [self.twFaceBookStatus setText:[NSString stringWithFormat:@"https://graph.facebook.com/me/friends?access_token=%@",
                                appDelegate.session.accessTokenData.accessToken]];
    } else {
        [self.btnFaceBook setTitle:@"Log in With FaceBook" forState:UIControlStateNormal];
        [self.twFaceBookStatus setText:@"Login to create a link to fetch account data"];
    }
    
    
}

- (IBAction)clickLoginGoogle:(id)sender {
    
    if([[GPPSignIn sharedInstance] authentication ]) {
           [[GPPSignIn sharedInstance] disconnect];
        [self.btnGoogle setTitle:@"Login With Google" forState:UIControlStateNormal];
       [self.twGoogleStatus setText:@"Login to create a link to fetch account data"];
        
    }
    else{
        
        [[GPPSignIn sharedInstance] authenticate];
          [self.btnGoogle setTitle:@"Logout Google" forState:UIControlStateNormal];
    }
}
- (IBAction)clickLoginFaceBook:(id)sender {
    // get delegate cua app de tiep can doi tuong session
    APP_AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    // button la flip-flop, open-close
    if (appDelegate.session.isOpen) {
        //xoa session
       [appDelegate.session closeAndClearTokenInformation];
              
    } else {
        if (appDelegate.session.state != FBSessionStateCreated) {
            // tao session moi
            appDelegate.session = [[FBSession alloc] init];
        }
        
        //  moi UI login
        [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                         FBSessionState status,
                                                         NSError *error) {
            // cap nhat lại view
            [self updateView];
        }];
    }

}
@end
