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
#import "Player.h"
#import "Global.h"


@interface CPlayer : Player {
    
	IBOutlet NSLevelIndicator *l20;
    IBOutlet NSLevelIndicator *l19;
    IBOutlet NSLevelIndicator *l18;
    IBOutlet NSLevelIndicator *l17;
    IBOutlet NSLevelIndicator *l16;
    IBOutlet NSLevelIndicator *l15;
    IBOutlet NSLevelIndicator *lB;
    IBOutlet NSTextField *fieldThrows;
    NSMutableArray *arrLastThrow;
    NSMutableArray *arrLastScore;
    NSMutableArray *arrLastButton;
    int liValue;
	NSArray *lInd;
	int lCount;
    
}


@property (retain) NSLevelIndicator *l20;
@property (retain) NSLevelIndicator *l19;
@property (retain) NSLevelIndicator *l18;
@property (retain) NSLevelIndicator *l17;
@property (retain) NSLevelIndicator *l16;
@property (retain) NSLevelIndicator *l15;
@property (retain) NSTextField *fieldThrows;
@property (retain) NSLevelIndicator *lB;
@property (retain) NSMutableArray *arrLastThrow;
@property (retain) NSMutableArray *arrLastScore;
@property (retain) NSMutableArray *arrLastButton;

-(void)revertCricket;
-(void)calcThrow:(id)levelIndicator value: (int)value multi: (int)multi;
-(void)resetLevelInd;
-(int)countLevelInd;
-(BOOL)checkLevelFull:(int)ind;
-(void)endThrowCricket:(int)aThrows;

@end
