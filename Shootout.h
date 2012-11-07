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


#import <Foundation/Foundation.h>

#import "ManagingViewController.h"
#import "Global.h"
#import "XPlayer.h"

@interface Shootout : ManagingViewController {
    
    IBOutlet NSTextField *fieldScored;
	IBOutlet NSTableView *tabScored;
	IBOutlet XPlayer *p1;
    IBOutlet NSTableView *tabStats;
    IBOutlet NSTableView *tabHS;
    
}

-(IBAction)submit:(id)sender;
-(IBAction)restart:(id)sender;
-(void)restartG;
-(void)restartGNote:(NSNotification *)note;
-(IBAction)revert:(id)sender;

@end