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
#import "Global.h"

NSMutableArray *arrayStatsHighScore;

@interface Player : NSObject {
    IBOutlet NSTextField *playerScore;
    IBOutlet NSTextField *playerDisp;
	int score;	
	int throws;
    NSString *mChar;
    NSString *scored;
	NSString *playerName;
	NSMutableArray *arrayThrow;
}

@property int score;
@property int throws;
@property (retain) NSTextField *playerScore;
@property (retain) NSTextField *playerDisp;
@property (retain) NSString *scored;
@property (retain) NSString *playerName;
@property (retain) NSMutableArray *arrayThrow; 

-(void)changePlayerDisp:(int)playerIn;


@end
