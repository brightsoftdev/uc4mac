//
//  HistoryContactViewController.h
//  SinaUC
//
//  Created by 硕实 陈 on 12-8-6.
//  Copyright (c) 2012年 NHN Corporation. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class XMPP;
@class ContactDataContext;
@interface HistoryContactViewController : NSViewController <NSTableViewDataSource> {
@private
    NSMutableArray* contacts;
    IBOutlet NSTableView* contactList;
    IBOutlet ContactDataContext* contactDataContext;
    IBOutlet XMPP* xmpp;
}

- (void) showContacts;

@end
