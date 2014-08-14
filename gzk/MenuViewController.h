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
    
}
@end
