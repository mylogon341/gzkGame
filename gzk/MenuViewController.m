//
//  MenuViewController.m
//  gzk
//
//  Created by Luke Sadler on 01/08/2014.
//  Copyright (c) 2014 mylogon. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[GameCenterManager sharedManager] setDelegate:self];
    
    adTimer = [NSTimer  scheduledTimerWithTimeInterval:10 target:self selector:@selector(ads) userInfo:nil repeats:YES];

}

-(void)ads{
    
    RevMobFullscreen *ad = [[RevMobAds session] fullscreen];
    [ad loadWithSuccessHandler:^(RevMobFullscreen *fs) {
        [fs showAd];
        NSLog(@"Ad loaded");
        [adTimer invalidate];
    } andLoadFailHandler:^(RevMobFullscreen *fs, NSError *error) {
        NSLog(@"Ad error: %@",error);
    } onClickHandler:^{
        NSLog(@"Ad clicked");
    } onCloseHandler:^{
        NSLog(@"Ad closed");
        adTimer = [NSTimer  scheduledTimerWithTimeInterval:10 target:self selector:@selector(ads) userInfo:nil repeats:YES];
    }];}


-(void)revmobAdDidFailWithError:(NSError *)error{
    
}

-(void)revmobSessionIsStarted{
    
    [RevMobAds session].testingMode = RevMobAdsTestingModeWithAds;

    [[RevMobAds session]showBanner];
    [[RevMobAds session]showFullscreen];
    adTimer = [NSTimer  scheduledTimerWithTimeInterval:12 target:self selector:@selector(ads) userInfo:nil repeats:YES];

    
}
-(void)revmobAdDisplayed{
    [adTimer invalidate];
}

-(void)revmobUserClosedTheAd{
    
    [[RevMobAds session]showPopup];
}

-(IBAction)start{
    [adTimer invalidate];
    adTimer = nil;
    
    [self performSegueWithIdentifier:@"push" sender:nil];
    
    
}
-(IBAction)tut{
    [adTimer invalidate];
    adTimer = nil;
    
    [self performSegueWithIdentifier:@"tutorial" sender:nil];
    
    
}


-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(IBAction)GC{
    [adTimer invalidate];
    [self showLeaderboard];
}

- (void)gameCenterManager:(GameCenterManager *)manager authenticateUser:(UIViewController *)gameCenterLoginController{
    [self presentViewController:gameCenterLoginController animated:YES completion:^{
        //You can comment this line, it's simply so we know that we are currently authenticating the user and presenting the controller
        NSLog(@"Finished Presenting Authentication Controller");
        
    }];
}

-(void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController{
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void) showLeaderboard{
    BOOL isAvailable = [[GameCenterManager sharedManager] checkGameCenterAvailability];
    
    if(isAvailable){
        [[GameCenterManager sharedManager] presentLeaderboardsOnViewController:self];
        
    }else{
        //Showing an alert message that Game Center is unavailable
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Highscore" message: @"Game Center is currently unavailable. Make sure you are logged in." delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show];
    }
}

-(void)submitToLeaderboard: (int)scores{
    //Is Game Center available?
    BOOL isAvailable = [[GameCenterManager sharedManager] checkGameCenterAvailability];
    
    if(isAvailable){
        [[GameCenterManager sharedManager] saveAndReportScore:scores leaderboard:@"highscoreLeaderboard" sortOrder:GameCenterSortOrderHighToLow];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
