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


#import <Cocoa/Cocoa.h>
#import "XPlayer.h"
#import "CheckOut.h"
#import "WinPane.h"
#import "Stats.h"
#import "ManagingViewController.h"
#import "WinGame.h"

@interface x012 : ManagingViewController {
	
	IBOutlet NSTextField *fieldScored;
	IBOutlet NSTableView *tabP1;
	IBOutlet NSTableView *tabP2;
	IBOutlet NSTextField *fieldStats;
    IBOutlet NSTextField *fieldSets;
	IBOutlet CheckOut *cOut;
	IBOutlet XPlayer *p1;
	IBOutlet XPlayer *p2;
	IBOutlet NSButton *restartButton;
	IBOutlet NSButton *submitButton;
	int won;
	int won1;
	int won2;
    int set1;
    int set2;
    int player;
	int startPlayer;
	
	WinPane *winPane;
    WinGame *winGame;
}

-(int)showWinPane;
-(IBAction)submit:(id)sender;
-(IBAction)restartGame:(id)sender;
-(void)restartG:(int)pref;
-(IBAction)revertLast:(id)sender;


@end
