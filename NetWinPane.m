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


#import "NetWinPane.h"


@implementation NetWinPane


@synthesize throws;
-(id)init
{
	if (![super initWithWindowNibName:@"WinPane"])
	{
		return nil;
	}
	return self;
}



-(IBAction)submit:(id)sender
{
	throws = [[numThrows stringValue] intValue];
	
	if (throws <= 3 && throws >0 ) {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
		[nc postNotificationName:netThrowChanged object:self];
		
		[self close];
	}
}

-(IBAction)showWindow:(id)sender
{
    [super showWindow:sender];
    [[self window] center];
}

-(void)dealloc
{
    [super dealloc];
}
@end
