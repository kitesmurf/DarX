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


@interface XPlayer : Player {
    
	NSMutableArray *arrayHighScore;
	IBOutlet NSTableView *tableHighScore;
	IBOutlet NSTextField *fieldAveScore;
	IBOutlet NSTextField *fieldAveScore3;
	IBOutlet NSTextField *fieldLiveAve;
    
}


@property (retain) NSTextField *fieldAveScore;
@property (retain) NSTextField *fieldAveScore3;
@property (retain) NSTextField *fieldLiveAve;
@property (retain) NSMutableArray *arrayHighScore;

-(void)countUp:(NSString *)throw player:(int)player;
-(void)countDown:(NSString *)throw player:(int)player;
-(void)aveScore:(float)aveScore;
-(void)reloadTable;
-(void)reset;
-(void)throws:(int)aveThrow player:(int)player;
-(void)refuseTableHighscore;
-(void)resetStatsArray;

@end
