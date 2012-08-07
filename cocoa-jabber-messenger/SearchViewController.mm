//
//  SearchViewController.m
//  cocoa-jabber-messenger
//
//  Created by 硕实 陈 on 12-5-1.
//  Copyright (c) 2012年 NHN Corporation. All rights reserved.
//

#import "SearchViewController.h"
#import "BuddyCell.h"
#import "XMPP.h"
#import "ContactItem.h"
#import "ContactDataContext.h"

@implementation SearchViewController

- (void) awakeFromNib
{
    contacts = [[NSMutableArray alloc] init];
    [contactList setIntercellSpacing:NSMakeSize(0,0)];
    [contactList setTarget:self];
    [contactList setDoubleAction:@selector(onDoubleClick:)];
    [contactList setDataSource:self];
}

- (void) dealloc
{
    [contacts release];
}

- (void) search:(NSString*) cond
{
    [contacts removeAllObjects];
    [contacts addObjectsFromArray:[contactDataContext findContactsByPinyin:cond]];
    [contactList reloadData];
}

- (void) onDoubleClick:(id) sender
{
    [xmpp startChat:[[contacts objectAtIndex:[contactList selectedRow]] jid]];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView*) aTableView
{
    return [contacts count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    if ([[tableColumn identifier] isEqualToString:@"photo"]) {
        NSData* imageData = [[contacts objectAtIndex:row] valueForKey:@"photo"];
        if (imageData) {
            NSImage* image = [[[NSImage alloc] initWithData:imageData] autorelease];
            return image;
        }
        return [NSImage imageNamed:@"NSUser"];
    }
    if ([[tableColumn identifier] isEqualToString:@"name"]) {
        [(BuddyCell*)[tableColumn dataCell] setTitle:[[contacts objectAtIndex:row] valueForKey:@"name"]];
        [(BuddyCell*)[tableColumn dataCell] setSubTitle:[[contacts objectAtIndex:row] valueForKey:@"jid"]];
        return [[contacts objectAtIndex:row] valueForKey:@"name"];
    }
    if ([[tableColumn identifier] isEqualToString:@"status"]) {
        return [ContactItem statusImage:[[[contacts objectAtIndex:row] valueForKey:@"presence"] integerValue]];
    }
    return nil;
}

@end
