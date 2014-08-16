//
//  MenuViewController.h
//  gzk
//
//  Created by Luke Sadler on 01/08/2014.
//  Copyright (c) 2014 mylogon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameCenterManager.h"
#import <RevMobAds/RevMobAds.h>
#import <QuartzCore/QuartzCore.h>

NSTimer * adTimer;
@interface MenuViewController : UIViewController<GameCenterManagerDelegate, RevMobAdsDelegate,UIAlertViewDelegate>
{
    
    IBOutlet UIButton *tutorialLabel;
    IBOutlet UIButton *tutButton;
    CGRect tutButtonSize;
    BOOL big;
    
    int sNumber;
    
    IBOutlet UIButton *b1;
    IBOutlet UIButton *b2;
    IBOutlet UIButton *b3;
    IBOutlet UIButton *b4;
    
}

-(IBAction)b1Down;
-(IBAction)b2Down;
-(IBAction)b3Down;
-(IBAction)b4Down;

-(IBAction)b1Up;
-(IBAction)b2Up;
-(IBAction)b3Up;
-(IBAction)b4Up;
@end
