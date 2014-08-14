//
//  TutorialViewController.h
//  gzk
//
//  Created by Luke Sadler on 02/08/2014.
//  Copyright (c) 2014 mylogon. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "MenuViewController.h"

@interface TutorialViewController : UIViewController<UIAlertViewDelegate>{
    
    IBOutlet UIView *tutView;
    UILabel *tutLabel;
    UIButton *nextButton;
    UIImageView *fingerImage;
    
    IBOutlet UIButton *answer1Button;
    IBOutlet UIButton *answer2Button;
    IBOutlet UIButton *answer3Button;
    
    IBOutlet UILabel *questionLabel;
    UILabel *pushLabel;
    IBOutlet UILabel *scoreLabel;
    UILabel *timerLabel;
    IBOutlet UILabel *levelLabel;
    IBOutlet UILabel *wrongLabel;
    
    UILabel *progressLabel;
    
    IBOutlet UIImageView *bamboo;
    IBOutlet UIImageView *fish;
    IBOutlet UIImageView *banana;
    
    float fallSpeed1;
    float fallSpeed2;
    float fallSpeed3;
    
    float fallSpeed;
    int pushPoints;
    int score;
    int time;
    int level;
    int tutScreen;
    int screenNumber;
    int wrong;
    
    NSString *tutText;
    NSTimer *gameTimer;
    NSTimer *secondTimer;
    
    CGPoint b1Point;
    CGPoint b2Point;
    CGPoint b3Point;
    CGPoint b1Origin;
    CGPoint b2Origin;
    CGPoint b3Origin;
    
    CGPoint tutCentre;
    
    BOOL b1Pressed;
    BOOL b2Pressed;
    BOOL b3Pressed;
    
    UIButton *panda1;
    UIButton *monkey2;
    UIButton *penguin3;
    
    IBOutlet UIButton *quitButton;
    BOOL first;

}

@end
