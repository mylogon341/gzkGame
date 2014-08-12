//
//  MenuViewController.m
//  gzk
//
//  Created by Luke Sadler on 01/08/2014.
//  Copyright (c) 2014 mylogon. All rights reserved.
//

#import "MenuViewController.h"
#import "CJMTwitterFollowButton.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tutButton.clipsToBounds = YES;
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenHeight = screenSize.height;
    tutButtonSize = tutButton.frame;
        
    [self tutGlow];
    
    [[GameCenterManager sharedManager] setDelegate:self];
    
    adTimer = [NSTimer  scheduledTimerWithTimeInterval:10 target:self selector:@selector(ads) userInfo:nil repeats:YES];
    
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if(![deviceType hasPrefix:@"iPad"])
    {
    CJMTwitterFollowButton *smallFollowButton = [[CJMTwitterFollowButton alloc] initWithOrigin:CGPointMake(20, screenHeight-30) twitterAccount:@"mylogon_"  andSize:CJMButtonSizeSmall];
        
    [self.view addSubview:smallFollowButton];
    }
}

-(void)viewDidLayoutSubviews{
   // [fakeTutButton setCenter:tutButton.center];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];

        if ([tutButton.layer.presentationLayer hitTest:touchLocation])
        {
            [self tut];
        
    }
}

-(void)tutGlow{
    
    CGAffineTransform transform;
    
    if (big) {
        transform = CGAffineTransformMakeScale(1.0, 1.0);
    }else{
        transform = CGAffineTransformMakeScale(1.1, 1.1);
    }
    
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2];

    [UIView animateWithDuration:2
                     animations:^(void){
                         
                         [tutButton setTransform:transform];
                         [UIView commitAnimations];
                         
                         if (big) {
                             big = NO;
                         }else{
                             big = YES;
                         }

                         
                     }
                     completion:^(BOOL finished){
                         [self tutGlow];
                         
                     }];
    

    
    
}

-(void)tutReGlow{
    
    
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

-(IBAction)follow{

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Follow" message:@"This will open your twitter client and close GZK. Is this ok?" delegate:self cancelButtonTitle:@"Later" otherButtonTitles:@"Yes", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    

    if (buttonIndex == 1) {
    CJMTwitterFollowButton *button = [[CJMTwitterFollowButton alloc]init];
    [button buttonTapped];
    }
    
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
