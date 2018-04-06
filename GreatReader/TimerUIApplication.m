//
//  TimerUIApplication.m
//  GreatReader
//
//  Created by AV on 2018-04-06.
//  Copyright © 2018 MIYAMOTO Shohei. All rights reserved.
//
// ALL NEW CODE, from https://stackoverflow.com/questions/8085188/ios-perform-action-after-period-of-inactivity-no-user-interaction
//
//

#import "TimerUIApplication.h"

@implementation TimerUIApplication

//here we are listening for any touch. If the screen receives touch, the timer is reset
-(void)sendEvent:(UIEvent *)event
{
    [super sendEvent:event];
    
    if (!myidleTimer)
    {
        [self resetIdleTimer];
    }
    
    NSSet *allTouches = [event allTouches];
    if ([allTouches count] > 0)
    {
        UITouchPhase phase = ((UITouch *)[allTouches anyObject]).phase;
        if (phase == UITouchPhaseBegan)
        {
            [self resetIdleTimer];
        }
        
    }
}


//as labeled...reset the timer
-(void)resetIdleTimer
{
    if (myidleTimer)
    {
        [myidleTimer invalidate];
    }
    //convert the wait period into minutes rather than seconds
    int timeout = kApplicationTimeoutInMinutes * 60;
    myidleTimer = [NSTimer scheduledTimerWithTimeInterval:timeout target:self selector:@selector(idleTimerExceeded) userInfo:nil repeats:NO];
    
//    NSLog (@"timer reset!!");
    
}


//if the timer reaches the limit as defined in kApplicationTimeoutInMinutes, post this notification
-(void)idleTimerExceeded
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kApplicationDidTimeoutNotification object:nil];
}


@end

