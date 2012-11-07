//
//  WinGame.m
//  DarX
//
//  Created by lupus on 12.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WinGame.h"


@implementation WinGame


-(id)init
{
	if (![super initWithWindowNibName:@"WinGame"])
	{
		return nil;
	}
	return self;
}



-(void)open:(int)won1 scorep2:(int)won2
{
    if (!player1)
    {
        player1 = [[NSMutableString alloc]initWithString:@"Player 1"];
    }
    if (!player2)
    {
        player2 = [[NSMutableString alloc]initWithString:@"Player 2"];
    }
    [self showWindow:self];
    if ( won1 > won2)
        [fieldWin setStringValue:[NSString stringWithFormat:@"%@ won with %d to %d sets",player1,won1,won2]];
    else
        [fieldWin setStringValue:[NSString stringWithFormat:@"%@ won with %d to %d sets",player2,won2,won1]];
        
}

-(IBAction)close:(id)sender
{
    [self close];
}
-(IBAction)showWindow:(id)sender
{
    [super showWindow:sender];
    [[self window] center];
}


- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

-(void)dealloc
{
    [super dealloc];
}

@end
