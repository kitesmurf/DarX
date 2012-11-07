
/*
Copyright (2012) Maik Stubbe

This file is part of DarX.

DarX is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Foobar is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
*/

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
