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


#import "Connect.h"


@implementation Connect

- (id)init
{
    self = [super initWithWindowNibName:@"Connect"];
    if (self) {
        
        hostString = [[NSString alloc]init];
    }
    
    return self;
}

-(IBAction)next:(id)sender
{
    hostString = [fieldHost stringValue];
    
    NSArray *arrHostString = [hostString componentsSeparatedByString:@"."];
    
    if ([arrHostString count] == 4 && [[arrHostString objectAtIndex:0] intValue] >= 0 && [[arrHostString objectAtIndex:0] intValue] <= 255 &&
        [[arrHostString objectAtIndex:1] intValue] >= 0 && [[arrHostString objectAtIndex:1] intValue] <= 255 &&
        [[arrHostString objectAtIndex:2] intValue] >= 0 && [[arrHostString objectAtIndex:2] intValue] <= 255 &&
        [[arrHostString objectAtIndex:3] intValue] >= 0 && [[arrHostString objectAtIndex:3] intValue] <= 255)
    {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
		[nc postNotificationName:connHost object:self];
        [self close];
        isConWinOpen = FALSE;
    }
	
}

-(IBAction)closeWin:(id)sender
{
    isConWinOpen = FALSE;
    [self close];
}

-(IBAction)showWindow:(id)sender
{
    [super showWindow:sender];
    [[self window] center];
    [fieldHost setStringValue:@"10.211.55.3"];
}

- (void)dealloc
{
    [hostString release];
    [super dealloc];
}


@synthesize hostString;

@end
