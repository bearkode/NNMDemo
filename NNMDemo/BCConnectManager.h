/*
 *  BCConnectManager.h
 *  NNMDemo
 *
 *  Created by bearkode on 2014. 1. 2..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>


@interface BCConnectManager : NSObject <MCNearbyServiceAdvertiserDelegate, MCNearbyServiceBrowserDelegate, MCSessionDelegate>


+ (instancetype)sharedManager;


- (void)startAdvertising;
- (void)stopAdvertising;


- (void)startBrowsing;
- (void)stopBrowsing;


@end
