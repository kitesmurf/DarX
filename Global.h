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


extern int numPlayers;
extern int startScore;
extern int bestOf;
extern int sets;
extern BOOL boolServer;
extern BOOL isConWinOpen;
extern NSString * const gameTypeChanged1;
extern NSString * const gameTypeChanged2;
extern NSString * const gameTypeChanged3;
extern NSString * const throwChanged1;
extern NSString * const throwChanged2;
extern NSString * const throwChanged3;
extern NSString * const netThrowChanged;
extern NSString * const cricketWon1;
extern NSString * const cricketWon2;
extern NSString * const shootOutSaved;
extern NSString * const DP1Name;
extern NSString * const DP2Name;
extern NSString * const DBOf;
extern NSString * const DStartScore;
extern NSString * const DSets;
extern NSString * const connHost;
extern NSString * const hostSent;
extern NSString * const setGameCancel;
extern NSString * const setGameOK;
extern NSString * const serverClient;
extern NSString * const netErr;
extern NSString * const viewChanged;
extern NSString * const serverStart;
extern NSMutableString *player1;
extern NSMutableString *player2;
@interface Global : NSObject {

}

@end
