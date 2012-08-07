//
//  LaunchedViewController.h
//  cocoa-jabber-messenger
//
//  Created by 硕实 陈 on 12-1-30.
//  Copyright (c) 2012年 NHN Corporation. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "XMPPConnectionDelegate.h"
@class XMPP;
@interface LaunchedViewController : NSViewController <XMPPConnectionDelegate> {
@private
    IBOutlet XMPP* xmpp;
    IBOutlet NSImageView* profileImageView;    
    IBOutlet NSTextField* myNameField;
    IBOutlet NSTextField* myJidField;
    IBOutlet NSSegmentedControl* containerSelector;
    IBOutlet NSTabView* contactAndRoomContainer;
    IBOutlet NSTabView* contactAndSearchContainer;
    IBOutlet NSViewController* searchViewController;
    IBOutlet NSViewController* historyContactViewController;
    
	NSImage* myImage;
    NSString* myName;
    NSString* myJid;
}

@property (nonatomic, retain) NSImage* myImage;
@property (nonatomic, assign) NSString* myName;
@property (nonatomic, assign) NSString* myJid;

- (IBAction) switchView:(id) sender;
- (IBAction) search:(id) sender;

@end