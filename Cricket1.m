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


#import "Cricket1.h"


@implementation Cricket1

- (id)init
{
    [super initWithNibName:@"cricket1" bundle:nil];
	[self setTitle:@"1 Player Cricket"];
    if (self)
    {
        NSNotificationCenter *ncThrowChange = [NSNotificationCenter defaultCenter];
        [ncThrowChange addObserver:self
                          selector:@selector(handleWonCricket:)
                              name:cricketWon1
                            object:nil];
    }
    
    return self;
}


-(IBAction)dartThrown:(id)sender
{
    buttonPressed = [sender tag];
    switch (buttonPressed) {
        case 0:
            [p1 calcThrow:nil value:0 multi:0];
            break;
        case 1:
            [p1 calcThrow:p1.l20 value: 20 multi: 1];
            break;
        case 2:
            [p1 calcThrow:p1.l20 value: 20 multi: 2];
            break;
        case 3:
            [p1 calcThrow:p1.l20 value: 20 multi: 3];
            break;
        case 4:
            [p1 calcThrow:p1.l19 value: 19 multi: 1];
            break;
        case 5:
            [p1 calcThrow:p1.l19 value: 19 multi: 2];
            break;
        case 6:
            [p1 calcThrow:p1.l19 value: 19 multi: 3];
            break;
        case 7:
            [p1 calcThrow:p1.l18 value: 18 multi: 1];
            break;
        case 8:
            [p1 calcThrow:p1.l18 value: 18 multi: 2];
            break;
        case 9:
            [p1 calcThrow:p1.l18 value: 18 multi: 3];
            break;
        case 10:
            [p1 calcThrow:p1.l17 value: 17 multi: 1];
            break;
        case 11:
            [p1 calcThrow:p1.l17 value: 17 multi: 2];
            break;
        case 12:
            [p1 calcThrow:p1.l17 value: 17 multi: 3];
            break;
        case 13:
            [p1 calcThrow:p1.l16 value: 16 multi: 1];
            break;
        case 14:
            [p1 calcThrow:p1.l16 value: 16 multi: 2];
            break;
        case 15:
            [p1 calcThrow:p1.l16 value: 16 multi: 3];
            break;
        case 16:
            [p1 calcThrow:p1.l15 value: 15 multi: 1];
            break;
        case 17:
            [p1 calcThrow:p1.l15 value: 15 multi: 2];
            break;
        case 18:
            [p1 calcThrow:p1.l15 value: 15 multi: 3];
            break;
        case 19:
            [p1 calcThrow:p1.lB value: 25 multi: 1];
            break;
        case 20:
            [p1 calcThrow:p1.lB value: 25 multi: 2];
            break;
        case 21:
            [p1 endThrowCricket:throws];
            throws = 2;
            break;
        default:
            break;
    }
    [p1.playerScore setStringValue:[NSString stringWithFormat:@"%d",p1.score]];
    throws++;
    [p1.fieldThrows setStringValue:[NSString stringWithFormat:@"%@",p1.scored]];
    if (throws == 3)
    {
        throws = 0;
        [p1.fieldThrows setStringValue:@"-"];
        [p1.arrayThrow addObject:[NSString stringWithFormat:@"%@",p1.scored]];
        p1.scored = @"";
        [tabP1 reloadData];
        [tabP1 scrollRowToVisible:[tabP1 numberOfRows]-1];
    }
     
    count = [p1 countLevelInd];
    if ( count == 21 )
    {
        [self showWinCricket];
    }
}

-(IBAction)restartGame:(id)sender
{
    [self restartG];
}

-(void)restartG
{
    p1.scored = @"";
    p1.score = 0;
    throws = 0;
    [p1.arrayThrow removeAllObjects];
    [tabP1 reloadData];
    [p1.playerScore setStringValue:@"0"];
    [p1.fieldThrows setStringValue:@"-"];
    [p1 changePlayerDisp:player];
    [p1 resetLevelInd];
}



-(void)showWinCricket
{
	if (!winCricket)
	{
		winCricket = [[WinCricket alloc]init];
	}
	[winCricket open:[p1.arrayThrow count] score:p1.score];
}

-(void)handleWonCricket:(NSNotification *) note
{
	[self restartG];
}

-(void)awakeFromNib
{
    numPlayers = 1;
    [self restartG];
}

- (int)numberOfRowsInTableView:(NSTableView *)tv
{
	return [p1.arrayThrow count];
}

- (id)tableView:(NSTableView *)tv
objectValueForTableColumn:(NSTableColumn *)tColumn
			row:(int)row
{
	
	if ([[tColumn identifier] isEqualToString:@"score"]) {
		NSString *v = [p1.arrayThrow objectAtIndex:row];
		return v;
	}
	else //if ([[tColumn identifier] isEqualToString:@"throws"])
	{
		return [NSString stringWithFormat:@"%d",row+1];
	}
	return nil;
}


-(IBAction)revert:(id)sender
{
    
    if ( [p1.arrLastThrow count] > 0)
    {
        int countLoop;
        switch (throws) {
            case 0:
                [p1.arrayThrow removeLastObject];
                countLoop = 3;
                break;
            case 1:
                p1.scored = @"";
                countLoop = 1;
                break;
            case 2:
                p1.scored = @"";
                countLoop = 2;
                break;
            default:
                countLoop = 0;
                break;
        }
        
        for ( int i = 0;i<countLoop;i++)
        {
            [p1 revertCricket];
            throws = 0;
            [p1.playerScore setStringValue:[NSString stringWithFormat:@"%d",p1.score]];
            [p1.fieldThrows setStringValue:[NSString stringWithFormat:@"%d",throws]];
            [tabP1 reloadData];
        }   
    }
}



- (void)dealloc
{
    [winCricket release];
    [super dealloc];
}

@end
