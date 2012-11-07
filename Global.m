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


#import "Global.h"


int startScore = 501;
int bestOf = 3;
int sets  = 1;
BOOL boolServer = TRUE;
BOOL isConWinOpen = FALSE;
NSString * const gameTypeChanged1 = @"GameTypeChanged1";
NSString * const gameTypeChanged2 = @"GameTypeChanged2";
NSString * const gameTypeChanged3 = @"GameTypeChanged3";
NSString * const throwChanged1 = @"ThrowChanged1";
NSString * const throwChanged2 = @"ThrowChanged2";
NSString * const throwChanged3 = @"ThrowChanged3";
NSString * const netThrowChanged = @"netThrowChanged";
NSString * const cricketWon1 = @"CricketWon1";
NSString * const cricketWon2 = @"CricketWon2";
NSString * const shootOutSaved = @"shootOutSaved";
NSString * const DP1Name = @"DP1Name";
NSString * const DP2Name = @"DP2Name";
NSString * const DBOf = @"DBOf";
NSString * const DSets = @"DSets";
NSString * const DStartScore = @"DStartScore";
NSString * const connHost = @"ConnHost";
NSString * const hostSent = @"hostSent";
NSString * const setGameCancel = @"setGameCancel";
NSString * const setGameOK = @"setGameOK";
NSString * const serverClient = @"serverClient";
NSString * const netErr = @"netErr";
NSString * const viewChanged = @"viewChanged";
NSString * const serverStart = @"serverStart";
NSMutableString *player1;
NSMutableString *player2;


@implementation Global


@end
