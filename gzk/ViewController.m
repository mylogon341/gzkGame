//
//  ViewController.m
//  Greedy
//
//  Created by Luke Sadler on 31/07/2014.
//  Copyright (c) 2014 mylogon. All rights reserved.
//

#import "ViewController.h"
#import "MylogonAudio.h"
#import <RevMobAds/RevMobAds.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    gameOver = NO;
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    [[GameCenterManager sharedManager]setDelegate:self];
    
    gameTimer = [NSTimer scheduledTimerWithTimeInterval:0.007 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
    
    secondTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(seconds) userInfo:nil repeats:YES];
    
    fallSpeed = 0.15;
    
    panda1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [panda1 addTarget:self
               action:@selector(animal1)
     forControlEvents:UIControlEventTouchUpInside];
    [panda1 setTitle:@"" forState:UIControlStateNormal];
    panda1.frame = CGRectMake(79,20,104,89);
    [self.view insertSubview:panda1 belowSubview:gameOverView];
    [panda1 setBackgroundImage:[UIImage imageNamed:@"panda"] forState:UIControlStateNormal];
    
    monkey2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [monkey2 addTarget:self
               action:@selector(animal2)
     forControlEvents:UIControlEventTouchUpInside];
    [monkey2 setTitle:@"" forState:UIControlStateNormal];
    monkey2.frame = CGRectMake(302,20,104,89);
    [self.view insertSubview:monkey2 belowSubview:gameOverView];
    [monkey2 setBackgroundImage:[UIImage imageNamed:@"monkey"] forState:UIControlStateNormal];
    
    penguin3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [penguin3 addTarget:self
               action:@selector(animal3)
     forControlEvents:UIControlEventTouchUpInside];
    [penguin3 setTitle:@"" forState:UIControlStateNormal];
    penguin3.frame = CGRectMake(517,28,112,81);
    [self.view insertSubview:penguin3 belowSubview:gameOverView];
    [penguin3 setBackgroundImage:[UIImage imageNamed:@"penguin"] forState:UIControlStateNormal];
    
    menuButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [menuButton addTarget:self action:@selector(menuButton) forControlEvents:UIControlEventTouchUpInside];
    [menuButton setTitle:@"Menu" forState:UIControlStateNormal];
    [menuButton setFrame:CGRectMake(-60, 30, 52, 30)];
    [menuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [menuButton setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.2]];
    [self.view addSubview:menuButton];
    

    
    b1Origin.y = panda1.center.y;
    b2Origin.y = monkey2.center.y;
    b3Origin.y = penguin3.center.y;

    pauseButton.layer.cornerRadius = 6;
    pauseButton.layer.masksToBounds = YES;
    
    menuButton.layer.cornerRadius = 6;
    menuButton.layer.masksToBounds = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    freeGos = [defaults integerForKey:@"FG"];
    
    
    if (freeGos > 0) {
        
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    pushPoints = [defaults integerForKey:@"PP"];
    
    freeGos --;
        
        [defaults setInteger:freeGos forKey:@"FG"];
        [pushLabel setText:[NSString stringWithFormat:@"Push Tokens: %d", pushPoints]];

    }
    
    a1Label = [[UILabel alloc]initWithFrame:CGRectMake(answer1Button.frame.origin.x, answer1Button.frame.origin.y-13, answer1Button.frame.size.width, answer1Button.frame.size.height)];
    
    a2Label = [[UILabel alloc]initWithFrame:CGRectMake(answer2Button.frame.origin.x, answer2Button.frame.origin.y-13, answer1Button.frame.size.width, answer1Button.frame.size.height)];
    
    a3Label = [[UILabel alloc]initWithFrame:CGRectMake(answer3Button.frame.origin.x, answer3Button.frame.origin.y-13, answer1Button.frame.size.width, answer1Button.frame.size.height)];
    
    [a1Label setTextAlignment:NSTextAlignmentCenter];
    [a1Label setFont:[UIFont fontWithName:@"Komika Axis" size:50]];
    [a1Label setTextColor:[UIColor whiteColor]];
    [a1Label setShadowColor:[UIColor blackColor]];
    [a1Label setShadowOffset:CGSizeMake(2, 2)];
    
    
    [a2Label setTextAlignment:NSTextAlignmentCenter];
    [a2Label setFont:[UIFont fontWithName:@"Komika Axis" size:50]];
    [a2Label setTextColor:[UIColor whiteColor]];
    [a2Label setShadowColor:[UIColor blackColor]];
    [a2Label setShadowOffset:CGSizeMake(2, 2)];
    
    
    [a3Label setTextAlignment:NSTextAlignmentCenter];
    [a3Label setFont:[UIFont fontWithName:@"Komika Axis" size:50]];
    [a3Label setTextColor:[UIColor whiteColor]];
    [a3Label setShadowColor:[UIColor blackColor]];
    [a3Label setShadowOffset:CGSizeMake(2, 2)];
    
    
    [self.view addSubview:a1Label];
    [self.view addSubview:a2Label];
    [self.view addSubview:a3Label];
    
    
    ad = [[RevMobAds session] fullscreen]; // you must retain this object
    
    [ad loadWithSuccessHandler:^(RevMobFullscreen *fs) {
      //  [fs showAd];
        NSLog(@"Fullscreen Ad loaded");
    } andLoadFailHandler:^(RevMobFullscreen *fs, NSError *error) {
        NSLog(@"Ad error: %@",error);
    } onClickHandler:^{
        NSLog(@"Ad clicked");
    } onCloseHandler:^{
        NSLog(@"Ad closed");
    }];
    
    adLoaded = NO;
    [answer1Button setNeedsUpdateConstraints];
    time = 30;
    
    level = 1;
    [levelLabel setText:[NSString stringWithFormat:@"Level %d",level]];
    
    [pauseButton.titleLabel setTextColor:[UIColor purpleColor]];

    [self questions];
}

-(void)revmobAdDidFailWithError:(NSError *)error{
    
    NSLog(@"Error: %@",error);
}

-(void)adBannerStuff{
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat screenWidth = screenSize.width;
    CGFloat screenHeight = screenSize.height;

    RevMobBannerView *ban = [[RevMobAds session] bannerView]; // you must retain this object
    [ban loadWithSuccessHandler:^(RevMobBannerView *banner) {
        banner.frame = CGRectMake(screenWidth/2-180, screenHeight-50, 320, 50);
        [self.view addSubview:banner];
        adLoaded = YES;
        NSLog(@"Ad loaded");
    } andLoadFailHandler:^(RevMobBannerView *banner, NSError *error) {
        NSLog(@"Ad error: %@",error);
    } onClickHandler:^(RevMobBannerView *banner) {
        NSLog(@"Ad clicked");
    }];
}



-(IBAction)freePoints{
    [self free];
}
-(void)free{
    
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Share me!" message:@"Share me through Social Media and start with 10 Push Points on your next 3 turns!" delegate:self cancelButtonTitle:@"Sure!" otherButtonTitles:@"Not this time", nil];
        
        alert.tag = 101;
        
        
        [alert show];
        

}

-(void)socialShit{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Share with a friend" message:@"How would you like to share?" delegate:self cancelButtonTitle:@"Facebook!" otherButtonTitles:@"Twitter!",@"I've Changed my mind...", nil];
    
    alert.tag = 202;
    
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 404 && buttonIndex == 1) {
        [self performSegueWithIdentifier:@"menu" sender:nil];
    }
    
    
    if (alertView.tag == 303) {
        
        [self performSegueWithIdentifier:@"restart" sender:nil];
        
    }
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"%li",(long)buttonIndex);
    
    if (alertView.tag == 101) {
        
        //Sure = 0
        //Not this time = 1
        //Never = 2
        
        if (buttonIndex == 1) {
            [defaults setValue:@"1" forKey:@"alert"];
            [defaults synchronize];
        }
        
        if (buttonIndex == 0) {
            
            [self socialShit];
            
        }
    }
    
    if (alertView.tag == 202) {
        
        //facebook
        if (buttonIndex == 0) {
            
            
            // Check if the Facebook app is installed and we can present the share dialog
            FBLinkShareParams *params = [[FBLinkShareParams alloc] init];
            params.link = [NSURL URLWithString:@"https://developers.facebook.com/docs/ios/share/"];
            
            // If the Facebook app is installed and we can present the share dialog
            if ([FBDialogs canPresentShareDialogWithParams:params]) {
                
                // Present share dialog
                [FBDialogs presentShareDialogWithLink:params.link
                                              handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                                  if(error) {
                                                      // An error occurred, we need to handle the error
                                                      // See: https://developers.facebook.com/docs/ios/errors
                                                      NSLog(@"Error publishing story: %@", error.description);
                                                  } else {
                                                      // Success
                                                      NSLog(@"result %@", results);
                                                  }
                                              }];
                
                // If the Facebook app is NOT installed and we can't present the share dialog
            } else {
                // FALLBACK: publish just a link using the Feed dialog
                
                // Put together the dialog parameters
                NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                               @"Greedy Zookeeper", @"name",
                                               @"Greedy Zookeeper - The Game", @"caption",
                                               @"Get Greedy Zookeeper today for free on iPad and compete against friends. Who will get the global High Score?!", @"description",
                                               @"https://itunes.apple.com/us/app/zgk/id905388668?ls=1&mt=8", @"link",
                                               @"http://sdaapp.net/gzk1024.png", @"picture",
                                               nil];
                
                
                [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                                       parameters:params
                                                          handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                              if (error) {
                                                                  // An error occurred, we need to handle the error
                                                                  // See: https://developers.facebook.com/docs/ios/errors
                                                                  NSLog(@"Error publishing story: %@", error.description);
                                                              } else {
                                                                  if (result == FBWebDialogResultDialogNotCompleted) {
                                                                      // User canceled.
                                                                      NSLog(@"User cancelled.");
                                                                  } else {
                                                                      // Handle the publish feed callback
                                                                      NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                                      
                                                                      if (![urlParams valueForKey:@"post_id"]) {
                                                                          // User canceled.
                                                                          NSLog(@"User cancelled.");
                                                                          
                                                                      } else {
                                                                          // User clicked the Share button
                                                                          startScore = 10;
                                                                          freeGos = 3;

                                                                          [defaults setInteger:freeGos forKey:@"FG"];
                                                                          [defaults setInteger:startScore forKey:@"PP"];
                                                                          [defaults synchronize];
                                                                          
                                                                          
                                                                          NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                                          NSLog(@"result %@", result);
                                                                          
                                                                          UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sucess" message:@"Great. You will start with 10 push points for the next 3 turns. You can do this as many times as you like!!" delegate:self cancelButtonTitle:@"Cool!" otherButtonTitles: nil];
                                                                          
                                                                          alert.tag =303;
                                                                          
                                                                          [alert show];
                                                                          
                                                                          
                                                                      }
                                                                  }
                                                              }
                                                          }];
            }
        }
        
        
        
        //twitter
        if (buttonIndex == 1) {
            {
                //  Create an instance of the Tweet Sheet
                SLComposeViewController *tweetSheet = [SLComposeViewController
                                                       composeViewControllerForServiceType:
                                                       SLServiceTypeTwitter];
                
                // Sets the completion handler.  Note that we don't know which thread the
                // block will be called on, so we need to ensure that any required UI
                // updates occur on the main queue
                tweetSheet.completionHandler = ^(SLComposeViewControllerResult result) {
                    switch(result) {
                            //  This means the user cancelled without sending the Tweet
                        case SLComposeViewControllerResultDone:
                        {
                            startScore = 10;
                            
                            [defaults setInteger:startScore forKey:@"PP"];
                            [defaults synchronize];
                            
                            freeGos = 3;
                            
                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sucess" message:@"Great. You will start with 10 push points for the next 3 turns. You can do this as many times as you like!!" delegate:self cancelButtonTitle:@"Cool!" otherButtonTitles: nil];
                            
                            alert.tag =303;
                            
                            [alert show];
                            
                            break;}
                            //  This means the user hit 'Send'
                        case SLComposeViewControllerResultCancelled:{
                            
                        }   break;
                    }
                };
                
                //  Set the initial body of the Tweet
                [tweetSheet setInitialText:@"Check out #GreedyZookeeper on iOS for FREE!"];
                
                //  Adds an image to the Tweet.  For demo purposes, assume we have an
                //  image named 'larry.png' that we wish to attach
                if (![tweetSheet addImage:[UIImage imageNamed:@"panda"]]) {
                    NSLog(@"Unable to add the image!");
                }
                
                //  Add an URL to the Tweet.  You can add multiple URLs.
                if (![tweetSheet addURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/zgk/id905388668?ls=1&mt=8"]]){
                    NSLog(@"Unable to add the URL!");
                }
                
                //  Presents the Tweet Sheet to the user
                [self presentViewController:tweetSheet animated:NO completion:^{
                    NSLog(@"Tweet sheet has been presented.");
                }];
            }
        }
        
    }
    
    
    
    
}

- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}

-(IBAction)menuButton{
    
    NSString *text = nil;
                      
    if (gameOver) {
        text = @"Do you want to return to the main menu?";
    }else{
        text = @"Do you want to return to the main menu? Your current game will be lost. \n😩";
    }
    
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Menu" message:text delegate:self cancelButtonTitle:@"Not yet!" otherButtonTitles:@"Yep!", nil];
    alert.tag = 404;
    [alert show];
}


-(void)seconds{
    
    if (!adLoaded) {
        [self adBannerStuff];
    }
    
    time--;
    scoreCD --;
    
    if (scoreCD <= 1) {
        scoreCD = 1;
    }
    
    [timerLabel setText:[NSString stringWithFormat:@"Time Until Level %d: %d",level+1,time]];

    
    if (time ==0) {
        
        time = 30;
        level ++;
        fallSpeed = fallSpeed + 0.05;
        [levelLabel setText:[NSString stringWithFormat:@"Level %d",level]];
        pushPoints = pushPoints +3;
        [pushLabel setText:[NSString stringWithFormat:@"Push Tokens: %d", pushPoints]];
    }
    
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)gameLoop {
    
    
    if (CGRectIntersectsRect(panda1.frame, bamboo.frame) || CGRectIntersectsRect(monkey2.frame, banana.frame) || CGRectIntersectsRect(penguin3.frame, fish.frame)) {
        
        fallSpeed = 0;
        [self gameOver];
        [gameTimer invalidate];
        gameTimer = nil;
        [secondTimer invalidate];
        secondTimer = nil;
        
        }
    
    if (pushPoints < 0) {
        pushPoints = 0;
    }
    
    if (!b1Pressed) {
        fallSpeed1 = fallSpeed;
    }
    
    if (b1Pressed) {
        if (panda1.center.y <= b1Point.y-100) {
            panda1.userInteractionEnabled = YES;
            b1Pressed = NO;
        }
        if (panda1.center.y <= b1Origin.y) {
            b1Pressed = NO;
            panda1.userInteractionEnabled = YES;
        }
    }
    
    if (!b2Pressed) {
        fallSpeed2 = fallSpeed;
    }
    
    if (b2Pressed) {
        if (monkey2.center.y <= b2Point.y-100) {
            monkey2.userInteractionEnabled = YES;
            b2Pressed = NO;
        }
        if (monkey2.center.y <= b2Origin.y) {
            b2Pressed = NO;
            monkey2.userInteractionEnabled = YES;
        }
    }
    
    if (!b3Pressed) {
        fallSpeed3 = fallSpeed;
    }
    
    if (b3Pressed) {
        if (penguin3.center.y <= b3Point.y-100) {
            penguin3.userInteractionEnabled = YES;
            b3Pressed = NO;
        }
        if (penguin3.center.y <= b3Origin.y) {
            b3Pressed = NO;
            penguin3.userInteractionEnabled = YES;
        }
        
    }
    
    
    [panda1 setCenter:CGPointMake(panda1.center.x, panda1.center.y + fallSpeed1)];
    [monkey2 setCenter:CGPointMake(monkey2.center.x, monkey2.center.y + fallSpeed2)];
    [penguin3 setCenter:CGPointMake(penguin3.center.x, penguin3.center.y + fallSpeed3)];
    
    
}


-(IBAction)pause{
    
    if (!paused) {
        tempFallFloat = fallSpeed;
        fallSpeed = 0;
        [questionLabel setAlpha:0];
        
        [a1Label setText:@"PAUSED"];
        [a2Label setText:@"PAUSED"];
        [a3Label setText:@"PAUSED"];
        
        [secondTimer invalidate];
        panda1.userInteractionEnabled = NO;
        monkey2.userInteractionEnabled = NO;
        penguin3.userInteractionEnabled = NO;
        paused = YES;

    }else{
        
        fallSpeed = tempFallFloat;
        [questionLabel setAlpha:1];
        secondTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(seconds) userInfo:nil repeats:YES];
        paused = NO;
        [self randomBit];
        panda1.userInteractionEnabled = YES;
        monkey2.userInteractionEnabled = YES;
        penguin3.userInteractionEnabled = YES;
        [bg setAlpha:1];
        [w1 setAlpha:1];
        [w2 setAlpha:1];
        [w3 setAlpha:1];
        [panda1 setAlpha:1];
        [monkey2 setAlpha:1];
        [penguin3 setAlpha:1];
        [a1Label setAlpha:1];
        [a2Label setAlpha:1];
        [a3Label setAlpha:1];
    }
    
    [UIView animateWithDuration: 1.0f
                     animations:^{
                         if (paused) {
                                 menuButton.frame = CGRectMake(10, 60, 52, 30);
                             [bg setAlpha:0.5];
                             [w1 setAlpha:0.8];
                             [w2 setAlpha:0.8];
                             [w3 setAlpha:0.8];
                             [panda1 setAlpha:0.6];
                             [monkey2 setAlpha:0.6];
                             [penguin3 setAlpha:0.6];
                             [a1Label setAlpha:0.8];
                             [a2Label setAlpha:0.8];
                             [a3Label setAlpha:0.8];
                             [pauseButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

                         }else{
                             menuButton.frame = CGRectMake(-80, 5, 52, 30);
                            [pauseButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];

                         }
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

-(void)goMenu{
    
    [UIView animateWithDuration: 1.0f
                     animations:^{
                         menuButton.frame = CGRectMake(8, 5, 52, 30);
                         gameOverView.frame = CGRectMake(53, 286, 600, 200);
                         pauseButton.center = CGPointMake(-50, 10);
                         
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

-(void)gameOver{
    
    [self performSelector:@selector(goMenu) withObject:nil afterDelay:0.5];
    
    gameOver = YES;
    
    answer1Button.enabled = NO;
    answer2Button.enabled = NO;
    answer3Button.enabled = NO;
    
    [a1Label setAlpha:0.7];
    [a2Label setAlpha:0.7];
    [a3Label setAlpha:0.7];
    
    panda1.enabled = NO;
    monkey2.enabled = NO;
    penguin3.enabled = NO;
    
    [secondTimer invalidate];
    secondTimer = nil;
    
    [self submitToLeaderboard:score];
    
    [scoreLabel setAlpha:0];
    
    [self performSelector:@selector(scoreON) withObject:nil afterDelay:1];
    
    flashTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scoreOFF) userInfo:nil repeats:YES];
    
    int adRandom = arc4random()%1;

    switch (adRandom) {
        case 0:
            break;
            case 1:
            [self performSelector:@selector(fullscreen) withObject:nil afterDelay:1];
            break;
            
        default:
            break;
    }

    
}

-(void)fullscreen{
    
    
    [ad showAd];
    
    
    

}

-(void)scoreON{
    
    [scoreLabel setAlpha:1];
    
}

-(void)scoreOFF{
    
    [scoreLabel setAlpha:0];
    [self performSelector:@selector(scoreON) withObject:nil afterDelay:1];
    
}


-(void)questions{
    
    
    if (score < 0) {
        score = 0;
    }
    a1Correct = NO;
    a2Correct = NO;
    a3Correct = NO;
    
    scoreCD = 10;
    
    
    for (int i = 0; i < 6; ++i) {
        
        int test = arc4random()% 8+1;
        
        switch (i) {
            case 0:
                w1n1 = test;
                break;
            case 1:
                w1n2 = test;
                break;
            case 2:
                w2n1 = test;
                break;
            case 3:
                w2n2 = test;
                break;
            case 4:
                n1 = test;
                break;
            case 5:
                n2 = test;
                break;
                
            default:
                break;
        }
        
    }
    
    [questionLabel setText:[NSString stringWithFormat:@"%i x %i", n1, n2]];
    
    
    int cAnswer = n1 * n2;
    int wAnswer1 = w1n1 * w1n2;
    int wAnswer2 = w2n1 * w2n2;
    
    if (wAnswer1 == cAnswer) {
        wAnswer1 = (wAnswer1 *2)-1;
    }
    if (wAnswer2 == cAnswer) {
        wAnswer2 = (wAnswer2 *2)+5;
    }
    if (wAnswer1 == wAnswer2) {
        wAnswer1 = wAnswer1 *2;
        
        if (wAnswer1 == cAnswer) {
            wAnswer1 = (wAnswer2)-1;
        }
        
    }
    
    
    answer1 = [NSString stringWithFormat:@"%i",cAnswer];
    answer2 = [NSString stringWithFormat:@"%i",wAnswer1];
    answer3 = [NSString stringWithFormat:@"%i",wAnswer2];
    randomer = (arc4random() % 5);

    [self randomBit];
    
}

-(void)randomBit{
    
    switch (randomer) {
            
        case 0:
            [a1Label setText:answer1];
            [a2Label setText:answer3];
            [a3Label setText:answer2];
            
            a1Correct = YES;
            
            break;
        case 1:
            
            [a1Label setText:answer1];
            [a2Label setText:answer2];
            [a3Label setText:answer3];
            
            a1Correct = YES;
            
            break;
        case 2:
            
            [a1Label setText:answer2];
            [a2Label setText:answer1];
            [a3Label setText:answer3];
            
            a2Correct = YES;
            
            break;
        case 3:
            
            [a1Label setText:answer2];
            [a2Label setText:answer3];
            [a3Label setText:answer1];
            
            a3Correct = YES;
            
            break;
        case 4:
            [a1Label setText:answer3];
            [a2Label setText:answer2];
            [a3Label setText:answer1];
            
            a3Correct = YES;
            
            break;
        case 5:
            
            [a1Label setText:answer3];
            [a2Label setText:answer1];
            [a3Label setText:answer2];
            
            a2Correct = YES;
            
            break;
            
        default:
            break;
    }

}

-(void)getback{
    
    int random = arc4random()% 3;
    
    if (random == 1) {
        
        switch (random) {
            case 0:
                
                [[MylogonAudio sharedInstance]playSoundEffect:@"1.aiff"];
                
                break;
            case 1:
                
                [[MylogonAudio sharedInstance]playSoundEffect:@"2.aiff"];
                
                break;
            case 2:
                
                [[MylogonAudio sharedInstance]playSoundEffect:@"3.aiff"];
                
                break;
            case 3:
                
                [[MylogonAudio sharedInstance]playSoundEffect:@"4.aiff"];
                
                break;
            default:
                break;
        }
        
        
    }
    
    
    
    
}

-(IBAction)animal1{
    if (pushPoints > 0) {
        
        b1Point = panda1.center;
        
        fallSpeed1 = -0.5;
        
        panda1.userInteractionEnabled = NO;
        
        pushPoints --;
        
        b1Pressed = YES;
        
        [pushLabel setText:[NSString stringWithFormat:@"Push Tokens: %d", pushPoints]];
        
//        pushLabel.text = [NSString stringWithFormat:@"Push Tokens: %d",pushPoints];
        
    }
}

-(IBAction)animal2{
    if (pushPoints > 0) {
        
        b2Point = monkey2.center;
        
        fallSpeed2 = -0.5;
        
        monkey2.userInteractionEnabled = NO;
        
        pushPoints --;
        
        b2Pressed = YES;
        
        [pushLabel setText:[NSString stringWithFormat:@"Push Tokens: %d", pushPoints]];
        
    }
    
}

-(IBAction)animal3{
    
    if (pushPoints > 0) {
        
        b3Point = penguin3.center;
        
        fallSpeed3 = -0.5;
        
        penguin3.userInteractionEnabled = NO;
        
        pushPoints --;
        
        b3Pressed = YES;
        
        [pushLabel setText:[NSString stringWithFormat:@"Push Tokens: %d", pushPoints]];
        
    }
}

-(IBAction)answer1{
    if (a1Correct) {
        pushPoints ++;
        [wrongLabel setAlpha:0];
        score = score + (scoreCD * level);
        
    } else{
        pushPoints --;
        [wrongLabel setText:[NSString stringWithFormat:@"Wrong. %i x %i = %@",n1,n2,answer1]];
        [wrongLabel setAlpha:1];
        score = score -2;
    }
    
    [pushLabel setText:[NSString stringWithFormat:@"Push Tokens: %d", pushPoints]];
    [scoreLabel setText:[NSString stringWithFormat:@"Score: %d", score]];
    
    [self questions];
}

-(IBAction)answer2{
    
    if (a2Correct) {
        pushPoints ++;
        [wrongLabel setAlpha:0];
        score = score + (scoreCD * level);
        
    } else{
        pushPoints --;
        [wrongLabel setText:[NSString stringWithFormat:@"Wrong. %i x %i = %@",n1,n2,answer1]];
        [wrongLabel setAlpha:1];
        score = score -2;
    }
    
    [pushLabel setText:[NSString stringWithFormat:@"Push Tokens: %d", pushPoints]];
    [scoreLabel setText:[NSString stringWithFormat:@"Score: %d", score]];
    [self questions];
}

-(IBAction)answer3{
    if (a3Correct) {
        pushPoints ++;
        [wrongLabel setAlpha:0];
        score = score + (scoreCD * level);
        
    } else{
        pushPoints --;
        [wrongLabel setText:[NSString stringWithFormat:@"Wrong. %i x %i = %@",n1,n2,answer1]];
        [wrongLabel setAlpha:1];
        score = score -2;
    }
    
    [pushLabel setText:[NSString stringWithFormat:@"Push Tokens: %d", pushPoints]];
    [scoreLabel setText:[NSString stringWithFormat:@"Score: %d", score]];
    [self questions];
}


-(IBAction)gameCentre{
    
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
