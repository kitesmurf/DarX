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


#import "Stats.h"


@implementation StatsArrayController



-(void)add:(id)sender 
{
	id newStats  = [super newObject];
	NSDate *d = [NSDate date];
	
	NSNumber *throws = [[NSNumber alloc]initWithInt:[[arrayStatsHighScore objectAtIndex:4]intValue]];
	NSNumber *hs60 =  [[NSNumber alloc]initWithInt:[[arrayStatsHighScore objectAtIndex:0]intValue]];
	NSNumber *hs100 =  [[NSNumber alloc]initWithInt:[[arrayStatsHighScore objectAtIndex:1]intValue]];
	NSNumber *hs140 =  [[NSNumber alloc]initWithInt:[[arrayStatsHighScore objectAtIndex:2]intValue]];
	NSNumber *hs180 =  [[NSNumber alloc]initWithInt:[[arrayStatsHighScore objectAtIndex:3]intValue]];
	float score = [[arrayStatsHighScore objectAtIndex:5]floatValue];
	NSNumber *aveScore =  [[NSNumber alloc]initWithFloat:score];
	NSNumber *aveScore3 = [[NSNumber alloc]initWithFloat:(score *3)];
	NSNumber *gameType = [[NSNumber alloc]initWithInt:startScore];
    NSString *playerName = [[NSString alloc]initWithString:player1];
    
    NSLog(@"stats: %@",throws);
	
	[newStats setValue:d forKey:@"date"];
	[newStats setValue:aveScore forKey:@"aveScore"];
	[newStats setValue:aveScore3 forKey:@"aveScore3"];
	[newStats setValue:hs60 forKey:@"hs60"];
	[newStats setValue:hs100 forKey:@"hs100"];
	[newStats setValue:hs140 forKey:@"hs140"];
	[newStats setValue:hs180 forKey:@"hs180"];
	[newStats setValue:throws forKey:@"numThrows"];
	[newStats setValue:gameType forKey:@"gameType"];
    [newStats setValue:playerName forKey:@"playerName"];
	
	[discardButton setHidden:TRUE];
	[saveButton setHidden:TRUE];
	[restartButton setHidden:FALSE];
	[submitButton setHidden:FALSE];
    
    [newStats release];
    [aveScore release];
    [aveScore3 release];
    [throws release];
    [gameType release];
    [hs60 release];
    [hs140 release];
    [hs100 release];
    [hs180 release];
    [playerName release];
}


@end
