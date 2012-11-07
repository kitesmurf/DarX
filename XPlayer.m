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


#import "XPlayer.h"


@implementation XPlayer

- (id)init
{
    [super init];

    arrayHighScore = [[NSMutableArray alloc]init];
    arrayStatsHighScore = [[NSMutableArray alloc]init];
    for (int i=0;i<6;i++)
    {
        [arrayHighScore addObject:@"0"];
        [arrayStatsHighScore addObject:@"0"];
    }
    [arrayHighScore addObject:[NSString stringWithFormat:@"%d",startScore]];
    [arrayStatsHighScore addObject:[NSString stringWithFormat:@"%d",startScore]];
    
    [tableHighScore setRefusesFirstResponder:TRUE];
    return self;
}

-(void)resetStatsArray
{
    for (int i=0;i<6;i++)
    {
        [arrayStatsHighScore replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"0"]];
    }
    
    [arrayStatsHighScore replaceObjectAtIndex:6 withObject:[NSString stringWithFormat:@"%d",startScore]];
    
}

-(void)reset
{
	int count = 0;
	for (int i=0;i<4;i++)
	{
		[arrayHighScore replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",count]];
	}
}

- (int)numberOfRowsInTableView:(NSTableView *)tv
{
	return 1;
}

- (id)tableView:(NSTableView *)tv
objectValueForTableColumn:(NSTableColumn *)tColumn
			row:(int)row
{
	if ([[tColumn identifier] isEqualToString:@"hs60"]) {
		return [arrayHighScore objectAtIndex:0];
	}
	else if ([[tColumn identifier] isEqualToString:@"hs100"]) {
		return [arrayHighScore objectAtIndex:1];
	}
	else if ([[tColumn identifier] isEqualToString:@"hs140"]) {
		return [arrayHighScore objectAtIndex:2];
	}
	else if ([[tColumn identifier] isEqualToString:@"hs180"]) {
		return [arrayHighScore objectAtIndex:3];
	}
	return nil;
}

-(void)reloadTable
{
	[tableHighScore reloadData];
}

-(void)throws:(int)aveThrow  player:(int)player
{
	[arrayHighScore replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@"%d",aveThrow]];
	if ((numPlayers == 1 || numPlayers == 3) && player == 1)
	{
		[arrayStatsHighScore replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@"%d",aveThrow]];
	}
    
    NSLog(@"throws: %d",aveThrow);
}

-(void)aveScore:(float)aveScore
{
	[arrayHighScore replaceObjectAtIndex:5 withObject:[NSString stringWithFormat:@"%f",aveScore]];
	if (numPlayers == 1 || numPlayers == 3)
	{
		[arrayStatsHighScore replaceObjectAtIndex:5 withObject:[NSString stringWithFormat:@"%f",aveScore]];
        
	}
    NSLog(@"avescore: %f",aveScore);
}


-(void)countUp:(NSString *)throw player:(int)player
{
	int count;
	if ([throw isEqualToString:@"hs60"]) {
		count =  [[arrayHighScore objectAtIndex:0] intValue] ;
		count++;
		[arrayHighScore replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%d",count]];
        if (player == 1)
            [arrayStatsHighScore replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%d",[[arrayStatsHighScore objectAtIndex:0] intValue] +1]];
	}
	else if ([throw isEqualToString:@"hs100"]) {
		count =  [[arrayHighScore objectAtIndex:1] intValue] ;
		count++;
		[arrayHighScore replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%d",count]];
        if (player == 1)
            [arrayStatsHighScore replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%d",[[arrayStatsHighScore objectAtIndex:1] intValue]+1]];
	}
	else if ([throw isEqualToString:@"hs140"]) {
		count =  [[arrayHighScore objectAtIndex:2] intValue] ;
		count++;
		[arrayHighScore replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%d",count]];
        if (player == 1)
            [arrayStatsHighScore replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%d",[[arrayStatsHighScore objectAtIndex:2] intValue]+1]];
	}
	else if ([throw isEqualToString:@"hs180"]) {
		count =  [[arrayHighScore objectAtIndex:3] intValue] ;
		count++;
		[arrayHighScore replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%d",count]];
        if (player == 1)
            [arrayStatsHighScore replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%d",[[arrayStatsHighScore objectAtIndex:3] intValue]+1]];
	}
	
/*	if (numPlayers == 1 || numPlayers == 3) 
	{
		for (int i=0;i<4;i++)
		{
			[arrayStatsHighScore replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",[[arrayHighScore objectAtIndex:i]intValue]]];
		}
	}
*/	
	[tableHighScore reloadData];
}

-(void)countDown:(NSString *)throw player:(int)player
{
    int count;
	if ([throw isEqualToString:@"hs60"]) {
		count =  [[arrayHighScore objectAtIndex:0] intValue] ;
		count--;
		[arrayHighScore replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%d",count]];
        if (player == 1)
            [arrayStatsHighScore replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%d",[[arrayStatsHighScore objectAtIndex:0] intValue]-1]];
	}
	else if ([throw isEqualToString:@"hs100"]) {
		count =  [[arrayHighScore objectAtIndex:1] intValue] ;
		count--;
		[arrayHighScore replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%d",count]];
        if (player == 1)
            [arrayStatsHighScore replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%d",[[arrayStatsHighScore objectAtIndex:1] intValue]-1]];
	}
	else if ([throw isEqualToString:@"hs140"]) {
		count =  [[arrayHighScore objectAtIndex:2] intValue] ;
		count--;
		[arrayHighScore replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%d",count]];
        if (player == 1)
            [arrayStatsHighScore replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%d",[[arrayStatsHighScore objectAtIndex:2] intValue]-1]];
	}
	else if ([throw isEqualToString:@"hs180"]) {
		count =  [[arrayHighScore objectAtIndex:3] intValue] ;
		count--;
		[arrayHighScore replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%d",count]];
        if (player == 1)
            [arrayStatsHighScore replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%d",[[arrayStatsHighScore objectAtIndex:3] intValue]-1]];
	}
	
/*	if (numPlayers == 1 || numPlayers == 3) 
	{
		for (int i=0;i<4;i++)
		{
			[arrayStatsHighScore replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",[[arrayHighScore objectAtIndex:i]intValue]]];
		}
	}
*/	
	[tableHighScore reloadData];
}

-(void)refuseTableHighscore
{
    [tableHighScore setRefusesFirstResponder:TRUE];
}

-(void)dealloc
{
    [arrayHighScore release];
    [arrayStatsHighScore release];
    
    [super dealloc];
}

@synthesize arrayHighScore;
@synthesize fieldAveScore;
@synthesize fieldAveScore3;
@synthesize fieldLiveAve;

@end
