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


#import "SetGame.h"


@implementation SetGame

- (id)init
{
    self = [super initWithWindowNibName:@"SetGame"];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(IBAction)cancel:(id)sender
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:setGameCancel object:self];
    [self close];
}

-(IBAction)ok:(id)sender
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:setGameOK object:self];
    [self close];
}

-(void)showSetGame:(int) legs sets:(int)sets startPlayer:(NSString *)startPlayer
{
    [self showWindow:self];
    [fieldLegs setStringValue:[NSString stringWithFormat:@"%d",legs]];
    [fieldSets setStringValue:[NSString stringWithFormat:@"%d",sets]];
    [fieldStartPlayer setStringValue:startPlayer];
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


