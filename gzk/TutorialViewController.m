//
//  TutorialViewController.m
//  gzk
//
//  Created by Luke Sadler on 02/08/2014.
//  Copyright (c) 2014 mylogon. All rights reserved.
//

#import "TutorialViewController.h"

@interface TutorialViewController ()

@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    adTimer = nil;
    [adTimer invalidate];
    
    panda1 = [[UIButton alloc]init];
    monkey2 = [[UIButton alloc]init];
    penguin3 = [[UIButton alloc]init];
    
    [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [panda1 addTarget:self
               action:@selector(animal1)
     forControlEvents:UIControlEventTouchUpInside];
    [panda1 setTitle:@"" forState:UIControlStateNormal];
    panda1.frame = CGRectMake(79,20,104,89);
    [self.view insertSubview:panda1 belowSubview:tutView];
    [panda1 setBackgroundImage:[UIImage imageNamed:@"panda"] forState:UIControlStateNormal];
    
    [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [monkey2 addTarget:self
                action:@selector(animal2)
      forControlEvents:UIControlEventTouchUpInside];
    [monkey2 setTitle:@"" forState:UIControlStateNormal];
    monkey2.frame = CGRectMake(302,20,104,89);
    [monkey2 setBackgroundImage:[UIImage imageNamed:@"monkey"] forState:UIControlStateNormal];
    [self.view insertSubview:monkey2 belowSubview:tutView];
    
    [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [penguin3 addTarget:self
                 action:@selector(animal3)
       forControlEvents:UIControlEventTouchUpInside];
    [penguin3 setTitle:@"" forState:UIControlStateNormal];
    penguin3.frame = CGRectMake(517,28,112,81);
    [penguin3 setBackgroundImage:[UIImage imageNamed:@"penguin"] forState:UIControlStateNormal];
    [self.view insertSubview:penguin3 belowSubview:tutView];
    
    tutView.layer.cornerRadius = 8;
    tutView.layer.masksToBounds = YES;
    
    tutLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, 437, 97)];
    [tutLabel setTextAlignment:NSTextAlignmentCenter];
    tutLabel.numberOfLines = 0;
    [tutLabel setTextColor:[UIColor whiteColor]];
    [tutView addSubview:tutLabel];
    
    pushLabel = [[UILabel alloc]initWithFrame:CGRectMake(721, 610, 256, 33)];
    [pushLabel setText:@"PUSH TOKENS: 0"];
    [pushLabel setTextColor:[UIColor whiteColor]];
    [pushLabel setFont:[UIFont fontWithName:@"Komika Axis" size:25]];
    [self.view addSubview:pushLabel];
    
    fingerImage = [[UIImageView alloc]initWithFrame:CGRectMake(-120, 90, 120, 70)];
    [fingerImage setImage:[UIImage imageNamed:@"finger"]];
    [self.view insertSubview:fingerImage belowSubview:tutView];
    
    nextButton = [[UIButton alloc]initWithFrame:CGRectMake(385, 135, 74, 30)];
    [nextButton addTarget:self action:@selector(tutNextPressed) forControlEvents:UIControlEventTouchUpInside];
    [nextButton setBackgroundColor:[UIColor colorWithRed:45.0/255.0 green:98.0/255.0 blue:163.0/255.0 alpha:1]];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton setAdjustsImageWhenHighlighted:YES];
    [nextButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted | UIControlStateSelected];
    [tutView addSubview:nextButton];
    [nextButton setTitle:@"Next" forState:UIControlStateNormal];
    
    [tutLabel setText:@"Hey! Welcome to the 'Greedy Zookeeper' tutorial.."];
    
    nextButton.layer.cornerRadius = 4;
    nextButton.layer.masksToBounds = YES;
    
    [levelLabel setText:@"Level 1"];
    [questionLabel setText:@"2 x 5"];
    
    [answer1Button setTitle:@"12" forState:UIControlStateNormal];
    [answer2Button setTitle:@"10" forState:UIControlStateNormal];
    [answer3Button setTitle:@"20" forState:UIControlStateNormal];
    
    [answer3Button setNeedsLayout];
    
    answer1Button.userInteractionEnabled = NO;
    answer2Button.userInteractionEnabled = NO;
    answer3Button.userInteractionEnabled = NO;
    
    timerLabel = [[UILabel alloc]initWithFrame:CGRectMake(711, 702, 273, 33)];
    [timerLabel setText:@"Time Until Level 2: 30"];
    [timerLabel setTextColor:[UIColor whiteColor]];
    [timerLabel setFont:[UIFont fontWithName:@"Komika Axis" size:22]];
    [timerLabel sizeToFit];
    [self.view addSubview: timerLabel];
    
    b1Origin = panda1.center;
    b2Origin = monkey2.center;
    b3Origin = penguin3.center;
    
    panda1.userInteractionEnabled = NO;
    monkey2.userInteractionEnabled = NO;
    penguin3.userInteractionEnabled = NO;
    
    pushPoints = 0;
    [pushLabel setText:[NSString stringWithFormat:@"Push Tokens: %d",pushPoints]];
    
    tutScreen = 2;
    screenNumber = 1;
    progressLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 60, 20)];
    [progressLabel setText:@"1/ 21"];
    [progressLabel setTextColor:[UIColor lightTextColor]];
    [tutView addSubview:progressLabel];
    
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
   
    
    [self performSelector:@selector(swoop) withObject:nil afterDelay:0.5];
    
}

-(void)swoop{
    
    tutCentre = CGPointMake(350, 307.5);

  //  [tutView addSubview:progressLabel];
    
    [UIView animateWithDuration: 1.0f
                     animations:^{
                         tutView.center = tutCentre;

                     }
                     completion:^(BOOL finished){
                     
                     }];
}



-(void)unswoop{
    
    [tutLabel setAlpha:0];
    
    [UIView animateWithDuration: 1.0f
                     animations:^{
                         tutView.center = CGPointMake(tutCentre.x - 600, tutCentre.y);
                         [nextButton setAlpha:0];
                         [progressLabel setAlpha:0];
                     }
                     completion:^(BOOL finished){
                         
                     }];
}
-(void)reswoop{
    
    
    [UIView animateWithDuration: 1.0f
                     animations:^{
                         tutView.center = tutCentre;
                         [tutLabel setAlpha:1];
                         [nextButton setAlpha:1];
                         [progressLabel setAlpha:1];
                     }
                     completion:^(BOOL finished){
                         
                     }];
}


-(void)seconds{
    
    time--;
    
    
    [timerLabel setText:[NSString stringWithFormat:@"Time Until Level 2: %d",time]];
    
    
    if (time <=0) {
        
        time = 30;
        level ++;
        fallSpeed = fallSpeed + 0.05;
        [secondTimer invalidate];
    }
    
}

-(void)gameLoop{
    
    if (CGRectIntersectsRect(panda1.frame, bamboo.frame)) {
        panda1.center = b1Origin;
    }
    
    if (CGRectIntersectsRect(monkey2.frame, banana.frame)) {
        monkey2.center = b2Origin;
    }
    
    if (CGRectIntersectsRect(penguin3.frame, fish.frame)) {
        penguin3.center = b3Origin;
    }
    
    if (tutScreen > 12 && panda1.center.y <= b1Origin.y) {
        fallSpeed1 = 0;
    }
    if (tutScreen > 12 && monkey2.center.y <= b2Origin.y) {
        fallSpeed2 = 0;
    }
    if (tutScreen > 12 && penguin3.center.y <= b3Origin.y) {
        fallSpeed3 = 0;
    }
    
    if (!b1Pressed && tutScreen < 12) {
        fallSpeed1 = fallSpeed;
    }
    
    if (b1Pressed) {
        if (panda1.center.y <= b1Point.y-100) {
            b1Pressed = NO;
        }
        if (panda1.center.y <= b1Origin.y) {
            b1Pressed = NO;
        }
    }
    
    if (!b2Pressed && tutScreen < 12) {
        fallSpeed2 = fallSpeed;
    }
    
    if (b2Pressed) {
        if (monkey2.center.y <= b2Point.y-100) {
            b2Pressed = NO;
        }
        if (monkey2.center.y <= b2Origin.y) {
            b2Pressed = NO;
        }
    }
    
    if (!b3Pressed && tutScreen < 12) {
        fallSpeed3 = fallSpeed;
    }
    
    if (b3Pressed) {
        if (penguin3.center.y <= b3Point.y-100) {
            b3Pressed = NO;
        }
        if (penguin3.center.y <= b3Origin.y) {
            b3Pressed = NO;
        }
        
    }
    
    
    [panda1 setCenter:CGPointMake(panda1.center.x, panda1.center.y + fallSpeed1)];
    [monkey2 setCenter:CGPointMake(monkey2.center.x, monkey2.center.y + fallSpeed2)];
    [penguin3 setCenter:CGPointMake(penguin3.center.x, penguin3.center.y + fallSpeed3)];
    
    
}

-(void)animal1{
    
    b1Point = panda1.center;
    
    fallSpeed1 = -0.5;
    
    panda1.userInteractionEnabled = NO;
    
    pushPoints --;
    
    b1Pressed = YES;
    
    [pushLabel setText:[NSString stringWithFormat:@"Push Tokens: %d", pushPoints]];
    [self tutNextPressed];
}

-(void)animal2{
    
    b2Point = monkey2.center;
    
    fallSpeed2 = -0.5;
    
    monkey2.userInteractionEnabled = NO;
    
    pushPoints --;
    
    b2Pressed = YES;
    
    [pushLabel setText:[NSString stringWithFormat:@"Push Tokens: %d", pushPoints]];
    
    [self tutNextPressed];
}

-(void)animal3{
    b3Point = penguin3.center;
    
    fallSpeed3 = -0.5;
    
    penguin3.userInteractionEnabled = NO;
    
    pushPoints --;
    
    b3Pressed = YES;
    
    [pushLabel setText:[NSString stringWithFormat:@"Push Tokens: %d", pushPoints]];
    
    [self tutNextPressed];
    
}

-(IBAction)answer1{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:tutLabel.viewForBaselineLayout cache:YES];
    [tutLabel setText:@"No. That's not quite right. Try again."];
    [UIView commitAnimations];
    [answer1Button setEnabled:NO];
}
-(IBAction)answer2{
    
    [self tutNextPressed];
    [answer1Button setEnabled:YES];
    [answer3Button setEnabled:YES];
    
}
-(IBAction)answer3{
    
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:tutLabel.viewForBaselineLayout cache:YES];
    [tutLabel setText:@"No. That's not quite right. Try again."];
    [UIView commitAnimations];
    [answer3Button setEnabled:NO];
    
}

-(void)secondTimerOn{
    secondTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(seconds) userInfo:nil repeats:YES];
}

-(void)gameTimerOn{
    gameTimer = [NSTimer scheduledTimerWithTimeInterval:0.007 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
    nextButton.userInteractionEnabled = YES;
    nextButton.enabled = YES;
}

- (void)questionBounce {
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                     animations:^(void) {
                         fingerImage.center = CGPointMake(670, 135);
                     }
                     completion:^(BOOL finished) {
                        
                         [self questionBounce2];
                         
                     }
     ];
}

-(void)questionBounce2{
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                     animations:^(void) {
                         if (tutScreen <=5) {
                         fingerImage.center = CGPointMake(fingerImage.center.x - 30, fingerImage.center.y);
                     }
                     }
                     completion:^(BOOL finished) {
                         if (tutScreen <= 5) {
                             [self questionBounce];
                         }else{
                             [self answerBounce];
                         }
                         
                     }
     ];
    
    
}



- (void)answerBounce {
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                     animations:^(void) {
                         fingerImage.center = CGPointMake(670, 532);
                     }
                     completion:^(BOOL finished) {
                         [self answerBounce2];
                         
                     }
     ];
}

-(void)answerBounce2{
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                     animations:^(void) {
                         if (tutScreen<=7) {
                             fingerImage.center = CGPointMake(670, 270);
                         }
                     }
                     completion:^(BOOL finished) {
                         if (tutScreen <= 7) {
                             [self answerBounce];
                         }else{
                             [self answerBounceRemove];
                         }
                     }
     ];
    
    
}

- (void)pushBounce {
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                     animations:^(void) {
                         fingerImage.center = CGPointMake(655, 655);
                     }
                     completion:^(BOOL finished) {
                         [self pushBounce2];
                         
                     }
     ];
}

-(void)pushBounce2{
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                     animations:^(void) {
                         if (tutScreen<=9) {
                             fingerImage.center = CGPointMake(fingerImage.center.x -30, fingerImage.center.y);
                         }
                     }
                     completion:^(BOOL finished) {
                         if (tutScreen <= 9) {
                             [self pushBounce];
                         }else{
                             [self answerBounceRemove];
                         }
                     }
     ];
    
    
}

- (void)levelBounce {
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                     animations:^(void) {
                         fingerImage.center = CGPointMake(670, 65);
                     }
                     completion:^(BOOL finished) {
                         [self levelBounce2];
                         
                     }
     ];
}

-(void)levelBounce2{
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                     animations:^(void) {
                         if (tutScreen<=15) {
                             fingerImage.center = CGPointMake(fingerImage.center.x -30, fingerImage.center.y);
                         }
                     }
                     completion:^(BOOL finished) {
                         if (tutScreen <= 15) {
                             [self levelBounce];
                         }else{
                             [self timeBounce];
                         }
                     }
     ];
    
    
}

- (void)timeBounce {
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                     animations:^(void) {
                         fingerImage.center = CGPointMake(645, 730);
                     }
                     completion:^(BOOL finished) {
                         [self timeBounce2];
                         
                     }
     ];
}

-(void)timeBounce2{
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                     animations:^(void) {
                         if (tutScreen<=18) {
                             fingerImage.center = CGPointMake(fingerImage.center.x -30, fingerImage.center.y);
                         }
                     }
                     completion:^(BOOL finished) {
                         if (tutScreen <= 18) {
                             [self timeBounce];
                         }else{
                             [self answerBounceRemove];
                         }
                     }
     ];
    
    
}



-(void)answerBounceRemove{
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^(void) {
                         fingerImage.center = CGPointMake(-100, fingerImage.center.y);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

-(IBAction)quitButton{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Quit" message:@"Do you want to quit the tutorial" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yeah. I'm done.", nil];
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==1) {
    [self performSegueWithIdentifier:@"menu" sender:self];
    }
}


-(IBAction)tutNextPressed{
    
    
    switch (tutScreen) {
        case 2:
            tutText = @"Here I will show you how to play your new favourite game!";
            screenNumber ++;
            break;
        case 3:
            tutText = @"It's really simple - I promise!";
            screenNumber ++;
            break;
        case 4:
            tutText = @"Ok. At the top right you will see the question.\nHere it is 2 x 5.";
            [self questionBounce];
            screenNumber ++;
            break;
        case 5:
            tutText = @"Underneath you are given 3 answers to pick from";
            screenNumber ++;
            break;
        case 6:
            tutText = @"From these numbers, just pick the right answer";
            screenNumber ++;
            break;
        case 7:
            screenNumber ++;
            tutText = @"Here. See if you can get the right answer...";
            
            answer1Button.userInteractionEnabled = YES;
            answer2Button.userInteractionEnabled = YES;
            answer3Button.userInteractionEnabled = YES;
            
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3];
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:nextButton cache:YES];
            [nextButton setAlpha:0];
            nextButton.userInteractionEnabled = NO;
            [UIView commitAnimations];
            
            break;
        case 8:
            screenNumber ++;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.3];
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:nextButton cache:YES];
            [nextButton setAlpha:1];
            nextButton.userInteractionEnabled = YES;
            [UIView commitAnimations];
            
            answer1Button.userInteractionEnabled = NO;
            answer2Button.userInteractionEnabled = NO;
            answer3Button.userInteractionEnabled = NO;
            pushPoints++;
            [pushLabel setText:[NSString stringWithFormat:@"Push Tokens: %d",pushPoints]];
            
            tutText = @"Great! Now that you've picked the correct answer you are given a 'Push Token'\nIf you get an answer wrong you will lose a token";
            
            [fingerImage setCenter:CGPointMake(-80, pushLabel.center.y)];
            
            [self pushBounce];
            
            break;
        case 9:
            fallSpeed = 0.05;
            nextButton.userInteractionEnabled = NO;
            nextButton.enabled = NO;
            tutText = @"But what's this?!\nThe animals are hungry.\nThey're on the move!";
            [self performSelector:@selector(gameTimerOn) withObject:nil afterDelay:1.5];
            screenNumber ++;
            break;
        case 10:
            tutText = @"They're after their food.\nYou are the Greedy Zookeeper and must fend them off. Tap an animal to push it back...";
            [nextButton setTitle:@"OK" forState:UIControlStateNormal];
            screenNumber ++;
            break;
        case 11:
        {
            panda1.userInteractionEnabled = YES;
            monkey2.userInteractionEnabled = YES;
            penguin3.userInteractionEnabled = YES;
            [self unswoop];
            [nextButton setTitle:@"Next" forState:UIControlStateNormal];
        }
            break;
        case 12:
        {
            screenNumber ++;
            [self performSelector:@selector(reswoop) withObject:nil afterDelay:0.2];
            fallSpeed = -0.1;
            panda1.userInteractionEnabled = NO;
            monkey2.userInteractionEnabled = NO;
            penguin3.userInteractionEnabled = NO;
            
            tutText = @"Great Work!";
            [self performSelector:@selector(reversing) withObject:nil afterDelay:3];
        }
            break;
        case 13:
            screenNumber ++;
            tutText = @"Watch out though. When you click on an animal you use a Push Token.\nWhen you run out there won't be anything to stop those animals from getting their food!!";
            break;
        case 14:
            screenNumber ++;
            [fingerImage setCenter:CGPointMake(-100, 60)];
            tutText = @"Currently you're on level 1, see?";
            [self levelBounce];
            
            break;
        case 15:
            tutText = @"Every 30 seconds you level up";
            screenNumber ++;
            time = 30;
            secondTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(seconds) userInfo:nil repeats:YES];
            break;
        case 16:
            screenNumber ++;
            tutText = @"Every time you level up you get 3 bonus Push Tokens";
            break;
        case 17:
            screenNumber ++;
           tutText =@"Unfortunately the animals get more impatient and start moving towards their food even faster!";
            break;
        case 18:
            screenNumber ++;
            tutText = @"Oh no! D:";
            break;
        case 19:
            screenNumber ++;
            tutText = @"But it's ok. I know you can do it! ;D";
            break;
        case 20:
            screenNumber ++;
            tutText = @"That's all there is to it!\nI told you it would be easy, didn't I?\nIt's been great having you!\nCome back soon!";
            [gameTimer invalidate];
            
            [nextButton setTitle:@"Finish" forState:UIControlStateNormal];
            break;
        case 21:
        {
            [UIView animateWithDuration:1.0
                                  delay:0.0
                                options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                             animations:^(void) {
                                 tutView.center = CGPointMake(tutView.center.x + self.view.frame.size.width, tutView.center.y);
                                 [tutView setAlpha:0];
                                 panda1.center = CGPointMake(panda1.center.x, bamboo.center.y- bamboo.frame.size.height/2);
                                 monkey2.center = CGPointMake(monkey2.center.x, banana.center.y- banana.frame.size.height/2);
                                 penguin3.center = CGPointMake(penguin3.center.x, fish.center.y- fish.frame.size.height/2);
                             }
                             completion:^(BOOL finished) {
                                 [self munch];
                             }
             ];
            
        }
            break;
        case 22:
            [self performSegueWithIdentifier:@"menu" sender:nil];
            break;
        default:
            break;
    }
    
    
    [UIView animateWithDuration:0.1 animations:^(void){
    [progressLabel setText:[NSString stringWithFormat:@"%d/ 19",screenNumber]];
    }];

    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:tutLabel.viewForBaselineLayout cache:YES];
    [tutLabel setText:tutText];
    [UIView commitAnimations];

    
    
    
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationTransition:UIViewAnimationTransitionNone forView:tutView cache:YES];
//    [UIView commitAnimations];

    tutScreen ++;
    
    
}

-(void)munch{
    
    [UIView animateWithDuration:2.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                     animations:^(void) {
                         [self.view setAlpha:0];
                     }
                     completion:^(BOOL finished) {
                         [self tutNextPressed];
                     }
     ];
    [self munchUp];
    
}

-(void)munchUp{
    
    panda1.center = CGPointMake(panda1.center.x, panda1.center.y - 10);
    monkey2.center = CGPointMake(monkey2.center.x - 2, monkey2.center.y +5);
    penguin3.center = CGPointMake(penguin3.center.x, penguin3.center.y - 10);
    
    [self performSelector:@selector(munchDown) withObject:nil afterDelay:0.1];
}

-(void)munchDown{
    panda1.center = CGPointMake(panda1.center.x, panda1.center.y + 10);
    monkey2.center = CGPointMake(monkey2.center.x + 2, monkey2.center.y - 5);
    penguin3.center = CGPointMake(penguin3.center.x, penguin3.center.y + 10);
    [self performSelector:@selector(munchUp) withObject:nil afterDelay:0.1];

}

-(void)reversing{
    
    fallSpeed1 = -0.35;
    fallSpeed2 = -0.35;
    fallSpeed3 = -0.35;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
