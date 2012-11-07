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
//


#import "ServerClientDecide.h"


@implementation ServerClientDecide

- (id)init
{
    self = [super initWithWindowNibName:@"ServerClientDecide"];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(IBAction)next:(id)sender
{
    NSButtonCell *state = [server selectedCell];
	[server getRow:&row  column:&column ofCell:state];
    
    if (row == 0) //Server
        boolServer = TRUE;
    else if (row == 1) //Client
        boolServer = FALSE;
        
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:serverClient object:self];
    [self close];
    
	
}

-(IBAction)closeWin:(id)sender
{
    isConWinOpen = FALSE;
    [self close];
}



- (void)dealloc
{
    [super dealloc];
}

-(IBAction)showWindow:(id)sender
{
    [super showWindow:sender];
    [[self window] center];
    [[self window] orderFrontRegardless];
    isConWinOpen = TRUE;
}


@end
