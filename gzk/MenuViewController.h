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

@interface MenuViewController : UIViewController<GameCenterManagerDelegate, RevMobAdsDelegate>
{
    
    NSTimer * adTimer;
    
}
@end
