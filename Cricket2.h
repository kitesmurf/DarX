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
#import "ManagingViewController.h"
#import "CPlayer.h"
#import "WinCricket.h"
#import "Global.h"
#import "WinGame.h"



@interface Cricket2 : ManagingViewController {
    
    IBOutlet NSButton *s20;
    IBOutlet NSButton *s19;
    IBOutlet NSButton *s18;
    IBOutlet NSButton *s17;
    IBOutlet NSButton *s16;
    IBOutlet NSButton *s15;
    IBOutlet NSButton *sB;
    IBOutlet NSButton *d20;
    IBOutlet NSButton *d19;
    IBOutlet NSButton *d18;
    IBOutlet NSButton *d17;
    IBOutlet NSButton *d16;
    IBOutlet NSButton *d15;
    IBOutlet NSButton *dB;
    IBOutlet NSButton *t20;
    IBOutlet NSButton *t19;
    IBOutlet NSButton *t18;
    IBOutlet NSButton *t17;
    IBOutlet NSButton *t16;
    IBOutlet NSButton *t15;
    
	IBOutlet NSTableView *tabP1;
    IBOutlet NSTableView *tabP2;
    IBOutlet CPlayer *p1;
    IBOutlet CPlayer *p2;
    IBOutlet NSTextField *fieldWon;
    
    CPlayer *pl;
    CPlayer *pO;
    NSTableView *tabPl;
    
    int player;
    int startPlayer;
    int buttonPressed;
	int throws;
    int count;
    int won1;
    int won2;
    NSArray *butArr;
    NSArray *arrPlayer;
    
    WinCricket *winCricket;
    WinGame *winGame;
    
}
-(IBAction)dartThrown:(id)sender;
-(IBAction)restartGame:(id)sender;
-(void)restartG:(int)pref;
-(void)showWinCricket;
-(void)disableButtons:(int)butNum;
-(IBAction)revert:(id)sender;
@end
