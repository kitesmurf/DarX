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


#import "Player.h"

int player=0;
@implementation Player

- (id) init
{
	[super init];

	playerName = [[NSString alloc]init];
    arrayThrow = [[NSMutableArray alloc]init];
			
	return self;
	
}






-(void)changePlayerDisp:(int)playerIn
{
    if (!player1)
    {
        player1 = [[NSMutableString alloc]initWithString:@"Player 1"];
    }
    if (!player2)
    {
        player2 = [[NSMutableString alloc]initWithString:@"Player 2"];
    }
    
    if (playerIn == 1)
    {
        [playerDisp setStringValue:[NSString stringWithFormat:@"%@'s turn",player1]];
    }
    else if (playerIn == 2)
    {
        [playerDisp setStringValue:[NSString stringWithFormat:@"%@'s turn",player2]];
    }
}

-(void)dealloc
{
    [playerName release];
    [arrayThrow release];
    
    [super dealloc];
}

@synthesize throws;
@synthesize score;
@synthesize playerDisp;
@synthesize playerScore;
@synthesize scored;
@synthesize playerName;
@synthesize arrayThrow;



@end
