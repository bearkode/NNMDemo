/*
 *  BCConnectManager.m
 *  NNMDemo
 *
 *  Created by bearkode on 2014. 1. 2..
 *  Copyright (c) 2014 bearkode. All rights reserved.
 *
 */

#import "BCConnectManager.h"
#import "BCObjCUtil.h"


@implementation BCConnectManager
{
    MCPeerID                  *mMyPeerID;
    MCNearbyServiceAdvertiser *mAdvertiser;
    MCNearbyServiceBrowser    *mBrowser;
    
    MCSession                 *mSession;
    NSMutableDictionary       *mSessionDict;
}


SYNTHESIZE_SHARED_INSTANCE(BCConnectManager, sharedManager)


- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        mMyPeerID    = [[MCPeerID alloc] initWithDisplayName:[[UIDevice currentDevice] name]];
        mAdvertiser  = [[MCNearbyServiceAdvertiser alloc] initWithPeer:mMyPeerID discoveryInfo:nil serviceType:@"test"];
        mBrowser     = [[MCNearbyServiceBrowser alloc] initWithPeer:mMyPeerID serviceType:@"test"];
        
        mSession     = [[MCSession alloc] initWithPeer:mMyPeerID];
        mSessionDict = [[NSMutableDictionary alloc] init];
        
        [mSession setDelegate:self];
    }
    
    return self;
}


- (void)dealloc
{
    [mMyPeerID release];
    [mAdvertiser release];
    [mBrowser release];
    
    [mSession release];
    [mSessionDict release];
    
    [super dealloc];
}


#pragma mark -


- (void)startAdvertising
{
    [mAdvertiser setDelegate:self];
    [mAdvertiser startAdvertisingPeer];
}


- (void)stopAdvertising
{
    [mAdvertiser stopAdvertisingPeer];
    [mAdvertiser setDelegate:nil];
}


- (void)startBrowsing
{
    [mBrowser setDelegate:self];
    [mBrowser startBrowsingForPeers];
}


- (void)stopBrowsing
{
    [mBrowser stopBrowsingForPeers];
    [mBrowser setDelegate:nil];
}


#pragma mark -
#pragma mark AdvertiserDelegate


- (void)advertiser:(MCNearbyServiceAdvertiser *)aAdvertiser didReceiveInvitationFromPeer:(MCPeerID *)aPeerID withContext:(NSData *)aContext invitationHandler:(void (^)(BOOL aAccept, MCSession *aSession))aInvitationHandler
{
    NSLog(@" ");
    NSLog(@"advertiser:didReceiveInvitationFromPeer:withContext:invitationHandler:");
    NSLog(@"advertiser       = %@", aAdvertiser);
    NSLog(@"peerID           = %@", aPeerID);
    NSLog(@"context          = %@", aContext);
    NSLog(@"invitationHander = %p", aInvitationHandler);

#if (0)
    MCSession *sSession = [[[MCSession alloc] initWithPeer:aPeerID] autorelease];
    [sSession setDelegate:self];
        
    if (aInvitationHandler)
    {
        aInvitationHandler(YES, sSession);
    }
    
    [mSessionDict setObject:sSession forKey:[aPeerID displayName]];
    NSLog(@"mSessionDict = %@", mSessionDict);
#else
    aInvitationHandler(YES, mSession);
#endif
}


#pragma mark -
#pragma mark BrowserDelegate


- (void)browser:(MCNearbyServiceBrowser *)aBrowser foundPeer:(MCPeerID *)aPeerID withDiscoveryInfo:(NSDictionary *)aInfo
{
    NSLog(@" ");
    NSLog(@"browser:foundPeer:withDiscoveryInfo:");
    NSLog(@"browser = %@", aBrowser);
    NSLog(@"peerID  = %@", aPeerID);
    NSLog(@"aInfo   = %@", aInfo);
    
#if (0)
    MCSession *sSession = [[[MCSession alloc] initWithPeer:mMyPeerID] autorelease];
    [sSession setDelegate:self];
    
    [mBrowser invitePeer:aPeerID toSession:sSession withContext:nil timeout:5];
    
    [mSessionDict setObject:sSession forKey:[aPeerID displayName]];
    NSLog(@"mSessionDict = %@", mSessionDict);
#else
    [mBrowser invitePeer:aPeerID toSession:mSession withContext:nil timeout:5];
#endif
}


- (void)browser:(MCNearbyServiceBrowser *)aBrowser lostPeer:(MCPeerID *)aPeerID
{
    NSLog(@" ");
    NSLog(@"browser:lostPeer:");
    NSLog(@"browser = %@", aBrowser);
    NSLog(@"peerID  = %@", aPeerID);
}


#pragma mark -
#pragma mark SessionDelegate


- (void)session:(MCSession *)aSession peer:(MCPeerID *)aPeerID didChangeState:(MCSessionState)aState
{
    NSLog(@" ");
    NSLog(@"session:peer:didChangeState:");
    NSLog(@"aSession = %@", aSession);
    NSLog(@"peer     = %@", aPeerID);

    if (aState == MCSessionStateNotConnected)
    {
        NSLog(@"state = not connected");
    }
    else if (aState == MCSessionStateConnecting)
    {
        NSLog(@"state = connecting");
    }
    else if (aState == MCSessionStateConnected)
    {
        NSLog(@"state = connected");
    }
    
    NSString *sMessage = @"Hello?";
    [aSession sendData:[sMessage dataUsingEncoding:NSUTF8StringEncoding] toPeers:@[aPeerID] withMode:MCSessionSendDataReliable error:nil];
}


- (void)session:(MCSession *)aSession didReceiveData:(NSData *)aData fromPeer:(MCPeerID *)aPeerID
{
    NSLog(@" ");
    NSLog(@"session:didReceiveData:fromPeer:");

    NSString *sMessage = [[[NSString alloc] initWithData:aData encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"sMessage = %@", sMessage);
}


- (void)session:(MCSession *)aSession didReceiveStream:(NSInputStream *)aStream withName:(NSString *)aStreamName fromPeer:(MCPeerID *)aPeerID
{
    NSLog(@"session:didReceiveStream:withName:fromPeer:");
}


- (void)session:(MCSession *)aSession didStartReceivingResourceWithName:(NSString *)aResourceName fromPeer:(MCPeerID *)aPeerID withProgress:(NSProgress *)aProgress
{
    NSLog(@"session:didStartReceivingResourceWithName:fromPeer:withProgress:");
}


- (void)session:(MCSession *)aSession didFinishReceivingResourceWithName:(NSString *)aResourceName fromPeer:(MCPeerID *)aPeerID atURL:(NSURL *)aLocalURL withError:(NSError *)aError
{
    NSLog(@"session:didFinishReceivingResourceWithNAme:fromPeer:atURL:withError:");
}


@end
