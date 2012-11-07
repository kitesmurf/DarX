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

#import "ServerDisconnect.h"


@implementation ServerDisconnect

- (id)init
{
    self = [super initWithWindowNibName:@"ServerDisconnect"];
    if (self) {
        // Initialization code here.
    }
    
    return self;
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
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
