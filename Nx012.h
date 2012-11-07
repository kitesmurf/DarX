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
#import "NetWinPane.h"
#import "Stats.h"
#import "ManagingViewController.h"
#import "WinGame.h"
#import "Network.h"
#import "Connect.h"
#import "SetGame.h"
#import "ServerDisconnect.h"
#import "ServerClientDecide.h"
#import "Busy.h"
#import "Server.h"

@interface Nx012 : ManagingViewController {
	
	IBOutlet NSTextField *fieldScored;
	IBOutlet NSTableView *tabP1;
	IBOutlet NSTableView *tabP2;
	IBOutlet NSTextField *fieldStats;
    IBOutlet NSTextField *fieldSets;
	IBOutlet CheckOut *cOut;
	IBOutlet XPlayer *p1;
	IBOutlet XPlayer *p2;
	IBOutlet NSButton *closeButton;
    IBOutlet NSButton *connectButton;
	IBOutlet NSButton *submitButton;
    IBOutlet NSScrollView *viewChatIn;
    IBOutlet NSTextField *fieldChatOut;
    
    IBOutlet NSTextView *fieldChatIn;

    
	int won;
	int won1;
	int won2;
    int set1;
    int set2;
    int player;
	int startPlayer;
    int setStartPlayer;
	
	NetWinPane *winPane;
    WinGame *winGame;
    Connect *winConn;
    Network *netStack;
    SetGame *winSetGame;
    ServerDisconnect *winDisco;
    ServerClientDecide *winServer;
    Busy *winBusy;
    Server *server;
}

-(int)showWinPane;
-(IBAction)submit:(id)sender;
-(void)calcScore:(int)scored;
-(void)restartG:(int)pref;
-(IBAction)closeGame:(id)sender;
-(IBAction)connect:(id)sender;
-(IBAction)chat:(id)sender;
-(void)openConn;
-(void)restartGame;
-(void)handleThrowChange:(NSNotification *) note;
-(void)handleViewChange;
-(void)insertInChat:(NSString *)stringToInsert;
-(IBAction)startServer:(id)sender;
-(void)handleServerStart;


@end
