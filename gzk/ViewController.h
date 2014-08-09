//
//  ViewController.h
//  Greedy
//
//  Created by Luke Sadler on 31/07/2014.
//  Copyright (c) 2014 mylogon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameCenterManager.h"
#import <RevMobAds/RevMobAds.h>
#import <FacebookSDK/FacebookSDK.h>
#import <Twitter/Twitter.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController<GameCenterManagerDelegate, RevMobAdsDelegate>{
    
    IBOutlet UIView *gameOverView;
    
    NSTimer *gameTimer;
    NSTimer *secondTimer;
    NSTimer *flashTimer;

    BOOL adLoaded;
    
    IBOutlet UILabel *pushLabel;
    IBOutlet UILabel *scoreLabel;
    IBOutlet UILabel *timerLabel;
    IBOutlet UILabel *wrongLabel;
    IBOutlet UILabel *questionLabel;
    IBOutlet UILabel *levelLabel;
    
    IBOutlet UIButton *answer1Button;
    IBOutlet UIButton *answer2Button;
    IBOutlet UIButton *answer3Button;
    IBOutlet UIButton *menuButton;
    
    UILabel *a1Label;
    UILabel *a2Label;
    UILabel *a3Label;
    
     UIButton *panda1;
     UIButton *monkey2;
     UIButton *penguin3;
    
    IBOutlet UIButton *pauseButton;
    
    IBOutlet UIImageView *bamboo;
    IBOutlet UIImageView *banana;
    IBOutlet UIImageView *fish;
    
    int w1n1;
    int w1n2;
    int w2n1;
    int w2n2;
    int n1;
    int n2;
    
    int pushPoints;
    int score;
    int level;
    int scoreCD;
    int ans1;
    int ans2;
    int ans3;
    int randomer;
    int time;
    
    float fallSpeed1;
    float fallSpeed2;
    float fallSpeed3;
    float fallSpeed;
    float tempFallFloat;
   
    BOOL a1Correct;
    BOOL a2Correct;
    BOOL a3Correct;
    
    BOOL b1Pressed;
    BOOL b2Pressed;
    BOOL b3Pressed;
    BOOL paused;
    BOOL gameOver;
    
    NSString *answer1;
    NSString *answer2;
    NSString *answer3;
    
    
    CGPoint b1Point;
    CGPoint b2Point;
    CGPoint b3Point;
    CGPoint b1Origin;
    CGPoint b2Origin;
    CGPoint b3Origin;
        
    int startScore;
    
    int freeGos;
    
    RevMobFullscreen *ad;

    
}

-(void)free;

-(IBAction)animal1;
-(IBAction)animal2;
-(IBAction)animal3;

-(IBAction)pause;

-(IBAction)answer1;
-(IBAction)answer2;
-(IBAction)answer3;
-(IBAction)gameCentre;

@end
