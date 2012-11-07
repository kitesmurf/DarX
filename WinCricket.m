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


#import "WinCricket.h"


@implementation WinCricket

-(id)init
{
	if (![super initWithWindowNibName:@"WinCricket"])
	{
		return nil;
	}
	return self;
}


-(IBAction)submit:(id)sender
{
  
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    if (numPlayers == 1) {
        [nc postNotificationName:cricketWon1 object:self];
    }
    else if	( numPlayers == 2 ) {
        [nc postNotificationName:cricketWon2 object:self];
    }
    [self close];
}

-(void)open:(int)throws score:(int)score
{
    [self showWindow:self];
    [fieldThrowsCricket setStringValue:[NSString stringWithFormat:@"%d",throws]];
    [fieldScoreCricket setStringValue:[NSString stringWithFormat:@"%d",score]];
}

-(IBAction)showWindow:(id)sender
{
    [super showWindow:sender];
    [[self window] center];
}

- (void)dealloc
{
    [super dealloc];
}

@end
