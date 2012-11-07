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


#import "PreferenceController.h"


@implementation PreferenceController


-(id)init
{
    if (![super initWithWindowNibName:@"Preferences"])
        return nil;
	if (!player1)
    {
        player1 = [[NSMutableString alloc]initWithString:@"Player 1"];
    }
    if (!player2)
    {
        player2 = [[NSMutableString alloc]initWithString:@"Player 2"];
    }
    return self;
}


- (void)windowDidLoad
{
    
    [fieldBestOf setStringValue:[NSString stringWithFormat:@"%d",[self sBOf]]];
    [fieldSets setStringValue:[NSString stringWithFormat:@"%d",[self sSets]]];

    startScore = [self sStartScore];
	switch (startScore) {
		case 301:
			[gameType selectCellWithTag:1];
			break;
		case 501:
			[gameType selectCellWithTag:2];
			break;
		case 701:
			[gameType selectCellWithTag:3];
			break;
		case 1001:
			[gameType selectCellWithTag:4];
			break;
		default:
			[gameType selectCellWithTag:2];
			break;
	}
	[p1Name setStringValue:[self sP1Name]];
	[p2Name setStringValue:[self sP2Name]];
}


- (IBAction)closePrefPane:(id)sender
{	
	[self close];
}

-(IBAction)changeGame:(id)sender
{
	
	NSButtonCell *state = [gameType selectedCell];
	[gameType getRow:&row  column:&column ofCell:state];
	switch (row) {
		case 0:
			startScore = 301;
			break;
		case 1:
			startScore = 501;
			break;
		case 2:
			startScore = 701;
			break;
		case 3:
			startScore = 1001;
			break;
		default:
			startScore = 501;
			break;
	}
    
    bestOf  = [fieldBestOf intValue];
    sets = [fieldSets intValue];
   
	
	[player1 setString:[p1Name stringValue]];
	[player2 setString:[p2Name stringValue]];
    
  	
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	
	if ( numPlayers == 1 ){
		[nc postNotificationName:gameTypeChanged1 object:self];
	}
	else if ( numPlayers == 2 ) {
		[nc postNotificationName:gameTypeChanged2 object:self];
	}
	else if ( numPlayers == 3 ) {
		[nc postNotificationName:gameTypeChanged3 object:self];
	}
	
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[p1Name stringValue] forKey:DP1Name];
    [defaults setObject:player2 forKey:DP2Name];
    [defaults setObject:[NSString stringWithFormat:@"%d",bestOf] forKey:DBOf];
    [defaults setObject:[NSString stringWithFormat:@"%d",startScore] forKey:DStartScore];
    [defaults setObject:[NSString stringWithFormat:@"%d",sets] forKey:DSets];
    
	[self close];
}

-(NSString *)sP1Name
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:DP1Name];
}
-(NSString *)sP2Name
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:DP2Name];
}

-(int)sSets
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [[defaults objectForKey:DSets] intValue];
}
-(int)sBOf
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [[defaults objectForKey:DBOf] intValue];
}
-(int)sStartScore
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [[defaults objectForKey:DStartScore] intValue];
}

-(void)dealloc
{    
    
    [super dealloc];
    
}

@end
