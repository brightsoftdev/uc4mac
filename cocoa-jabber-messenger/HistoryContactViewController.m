//
//  HistoryContactViewController.m
//  SinaUC
//
//  Created by 硕实 陈 on 12-8-6.
//  Copyright (c) 2012年 NHN Corporation. All rights reserved.
//

#import "HistoryContactViewController.h"
#import "BuddyCell.h"
#import "XMPP.h"
#import "ContactItem.h"
#import "MessageItem.h"
#import "ContactDataContext.h"

@implementation HistoryContactViewController

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

- (void) showContacts
{
    [contacts removeAllObjects];
    NSArray* chatHistory = [[NSArray alloc] initWithArray:[MessageItem findByCriteria:[NSString stringWithFormat:@"WHERE type='from' AND name<>jid GROUP BY jid ORDER BY pk DESC LIMIT 20"]]];
    for (MessageItem* msg in chatHistory) {
        NSManagedObject* item = [contactDataContext findContactByJid:[msg jid]];
        if (!item) {
            ContactItem* tmpItem = [[ContactItem alloc] init];
            [tmpItem setName:[msg name]];
            [tmpItem setJid:[msg jid]];
            [contacts addObject:tmpItem];
            [tmpItem release];
        } else {
            [contacts addObject:item];
        }
    }
    [chatHistory release];
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
