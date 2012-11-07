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


#import "Cricket2.h"


@implementation Cricket2

- (id)init
{
    [super initWithNibName:@"cricket2" bundle:nil];
	[self setTitle:@"2 Player Cricket"];
    if (self)
    {
        NSNotificationCenter *ncThrowChange = [NSNotificationCenter defaultCenter];
        [ncThrowChange addObserver:self
                          selector:@selector(handleWonCricket:)
                              name:cricketWon2
                            object:nil];
        
        won1 = 0;
        won2 = 0;
        startPlayer = 2;
    }
    
    return self;
}


-(IBAction)dartThrown:(id)sender
{
    if (player == 1)
    {
        pl = p1;
        pO = p2;
        tabPl = tabP1;
    }
    else if (player == 2)
    {
        pl = p2;
        pO = p1;
        tabPl = tabP2;
    }
    buttonPressed = [sender tag];
    switch (buttonPressed) {
        case 0:
            [pl calcThrow:nil value:0 multi:0];
            break;
        case 1:
            [pl calcThrow:pl.l20 value: 20 multi: 1];
            [self disableButtons:0];
            break;
        case 2:
            [pl calcThrow:pl.l20 value: 20 multi: 2];
            [self disableButtons:0];
            break;
        case 3:
            [pl calcThrow:pl.l20 value: 20 multi: 3];
            [self disableButtons:0];
            break;
        case 4:
            [pl calcThrow:pl.l19 value: 19 multi: 1];
            [self disableButtons:1];
            break;
        case 5:
            [pl calcThrow:pl.l19 value: 19 multi: 2];
            [self disableButtons:1];
            break;
        case 6:
            [pl calcThrow:pl.l19 value: 19 multi: 3];
            [self disableButtons:1];
            break;
        case 7:
            [pl calcThrow:pl.l18 value: 18 multi: 1];
            [self disableButtons:2];
            break;
        case 8:
            [pl calcThrow:pl.l18 value: 18 multi: 2];
            [self disableButtons:2];
            break;
        case 9:
            [pl calcThrow:pl.l18 value: 18 multi: 3];
            [self disableButtons:2];
            break;
        case 10:
            [pl calcThrow:pl.l17 value: 17 multi: 1];
            [self disableButtons:3];
            break;
        case 11:
            [pl calcThrow:pl.l17 value: 17 multi: 2];
            [self disableButtons:3];
            break;
        case 12:
            [pl calcThrow:pl.l17 value: 17 multi: 3];
            [self disableButtons:3];
            break;
        case 13:
            [pl calcThrow:pl.l16 value: 16 multi: 1];
            [self disableButtons:4];
            break;
        case 14:
            [pl calcThrow:pl.l16 value: 16 multi: 2];
            [self disableButtons:4];
            break;
        case 15:
            [pl calcThrow:pl.l16 value: 16 multi: 3];
            [self disableButtons:4];
            break;
        case 16:
            [pl calcThrow:pl.l15 value: 15 multi: 1];
            [self disableButtons:5];
            break;
        case 17:
            [pl calcThrow:pl.l15 value: 15 multi: 2];
            [self disableButtons:5];
            break;
        case 18:
            [pl calcThrow:pl.l15 value: 15 multi: 3];
            [self disableButtons:5];
            break;
        case 19:
            [pl calcThrow:pl.lB value: 25 multi: 1];
            [self disableButtons:6];
            break;
        case 20:
            [pl calcThrow:pl.lB value: 25 multi: 2];
            [self disableButtons:6];
            break;
        case 21:
            [pl endThrowCricket:throws];
            throws = 2;
            break;
        default:
            break;
    }
    [pl.playerScore setStringValue:[NSString stringWithFormat:@"%d",pl.score]];
    throws++;
    [pl.fieldThrows setStringValue:[NSString stringWithFormat:@"%@",pl.scored]];

    
    count = [pl countLevelInd];
    if ( count == 21 && pl.score >= pO.score)
    {
        if ( player == 1)
            won1++;
        else if (player == 2)
            won2++;
        
        [fieldWon setStringValue:[NSString stringWithFormat:@"%d:%d",won1,won2]];
        [self showWinCricket];
    }
    if (throws == 3)
    {
        throws = 0;
        [pl.fieldThrows setStringValue:@"-"];
        [pl.arrayThrow addObject:[NSString stringWithFormat:@"%@",pl.scored]];
        pl.scored = @"";
        [tabPl reloadData];
        [tabPl scrollRowToVisible:[tabPl numberOfRows]-1];
        if (player == 1)
        {
            player = 2;
        }
        else if (player == 2)
        {
            player =1;
        }
        
        [p1 changePlayerDisp:player];
    }
}

-(IBAction)restartGame:(id)sender
{
    won1 = 0;
    won2 = 0;
    startPlayer = 0;
    [self restartG:0];
}

-(void)restartG:(int)pref
{
    if (pref == 0) {
		switch (startPlayer) {
			case 1:
				startPlayer = 2;
				player = 2;
				break;
			case 2:
				startPlayer = 1;
				player = 1;
				break;
				
			default:
				startPlayer = 1;
				player = 1;
				break;
		}
	}
	else {
		player = 1;
	}
    
    if (!arrPlayer)
    {
        arrPlayer = [[NSArray alloc]initWithObjects:p1,p2, nil];
    }
    
    for (CPlayer *obj in arrPlayer)
    {
        [obj.arrayThrow removeAllObjects];
        [obj.arrLastThrow removeAllObjects];
        [obj.arrLastScore removeAllObjects];
        [obj.arrLastButton removeAllObjects];
        [obj.playerScore setStringValue:@"0"];
        [obj.fieldThrows setStringValue:@"-"];
        [obj resetLevelInd];
        obj.scored = @"";
        obj.score = 0;
    }
    for (NSButton *but in butArr)
    {
        [but setEnabled:TRUE];
    }
    
    throws = 0;
    [tabP1 reloadData];
    [tabP2 reloadData];
    [p1 changePlayerDisp:player];
    [fieldWon setStringValue:[NSString stringWithFormat:@"%d:%d",won1,won2]];
    
}



-(void)showWinCricket
{
	if (!winCricket)
	{
		winCricket = [[WinCricket alloc]init];
	}
	[winCricket open:[pl.arrayThrow count] score:pl.score];
}

-(void)handleWonCricket:(NSNotification *) note
{
    if (won1+won2 == bestOf)
    {
        if (!winGame)
        {
            winGame = [[WinGame alloc]init];
        }
        [winGame open:won1 scorep2:won2];
        won1 = 0;
        won2 = 0;
    }
    [self restartG:0];
}

-(void)awakeFromNib
{
    [tabP1 setRefusesFirstResponder:TRUE];
    [tabP2 setRefusesFirstResponder:TRUE];
    numPlayers = 2;
    butArr = [[NSArray alloc] initWithObjects:s20, d20, t20, s19, d19, t19, s18, d18, t18, s17, d17, t17, s16, d16, t16, s15, d15, t15, sB, dB, dB, nil];
    [fieldWon setStringValue:[NSString stringWithFormat:@"%d:%d",won1,won2]];
    [self restartG:0];
}

- (int)numberOfRowsInTableView:(NSTableView *)tv
{
    if (player == 1)
    {
        return [p1.arrayThrow count];
    }
    else if (player == 2)
    {
        return [p2.arrayThrow count];
    }
    return 0;
}

- (id)tableView:(NSTableView *)tv
objectValueForTableColumn:(NSTableColumn *)tColumn
			row:(int)row
{
    if ([[tColumn identifier] isEqualToString:@"score"]) {
        NSString *v = [pl.arrayThrow objectAtIndex:row];
        return v;
    }
    else //if ([[tColumn identifier] isEqualToString:@"throws"])
    {
        return [NSString stringWithFormat:@"%d",row+1];
    }
	return nil;
}

-(void)disableButtons:(int)butNum;
{
    
    if ( [pl checkLevelFull:butNum] && [pO checkLevelFull:butNum] )
    {
        for (int i = butNum*3;i<butNum*3 + 3;i++)
        {
            NSButton *but = [butArr objectAtIndex:i];
            [but setEnabled:FALSE];
        }
    }
    
}

-(IBAction)revert:(id)sender
{
    if ( [p1.arrLastThrow count] > 0 || [p2.arrLastThrow count] > 0)
    {
        if (throws == 0)
        {
            if (player == 1) {
                player = 2;
            }
            else if (player == 2)
            {
                player = 1;
            }
        }
        if (player == 1)
        {
            pl = p1;
            pO = p2;
            tabPl = tabP1;
        }
        else if (player == 2)
        {
            pl = p2;
            pO = p1;
            tabPl = tabP2;
        }
        
        if ( [pl.arrLastThrow count] > 0)
        {
            int countLoop;
            switch (throws) {
                case 0:
                    [pl.arrayThrow removeLastObject];
                    countLoop = 3;
                    break;
                case 1:
                    pl.scored = @"";
                    countLoop = 1;
                    break;
                case 2:
                    pl.scored = @"";
                    countLoop = 2;
                    break;
                default:
                    countLoop = 0;
                    break;
            }
            
            for ( int i = 0;i<countLoop;i++)
            {
                [pl revertCricket];
                throws = 0;
                [pl.playerScore setStringValue:[NSString stringWithFormat:@"%d",pl.score]];
                [pl.fieldThrows setStringValue:[NSString stringWithFormat:@"%d",throws]];
                [tabPl reloadData];
                [p1 changePlayerDisp:player];
            }   
        }
    }
}


- (void)dealloc
{
    [butArr release];
    [winCricket release];
    [super dealloc];
}

@end
