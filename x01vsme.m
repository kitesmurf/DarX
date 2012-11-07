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


#import "x01vsme.h"


@implementation x01vsme

- (id) init
{
	[super initWithNibName:@"x01vsme" bundle:nil];
	[self setTitle:@"x01 vs me"];
	
	player = 1;
	won1 = 0;
	won2 = 0;
    set1 = 0;
    set2 = 0;
	[p1 setScore:startScore];
	[p2 setScore:startScore];
	
	NSNotificationCenter *ncThrowChange = [NSNotificationCenter defaultCenter];
    [ncThrowChange addObserver:self
                      selector:@selector(handleThrowChange:)
                          name:throwChanged3
                        object:nil];
	NSNotificationCenter *ncGameType = [NSNotificationCenter defaultCenter];
    [ncGameType addObserver:self
                   selector:@selector(handleGameTypeChange:)
                       name:gameTypeChanged3
                     object:nil];
    
    [self setRand];
    
	return self;
	
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
   	if ([[tColumn identifier] isEqualToString:@"scoreP2"]) {
			//NSString *v = @"foo";
			NSString *v = [p2.arrayThrow objectAtIndex:row];
			return v;
		}
        else if ([[tColumn identifier] isEqualToString:@"scoreP1"])
        {
            NSString *v = [p1.arrayThrow objectAtIndex:row];
            return v;
        }
		else //if ([[tColumn identifier] isEqualToString:@"throws"])
		{
			return [NSString stringWithFormat:@"%d",row+1];
		}
	
	
	return nil;
}


-(IBAction)submit:(id)sender
{
    if (!myScore)
        myScore = [self calcMyAve];

    NSInteger scored = 0;
	//NSLog(@"submit start player %d, startplayer %d",player, startPlayer);
	if (player == 1 )
	{
		
		scored = [[fieldScored stringValue] intValue];
		if (scored > p1.score || scored > 180)
		{
			[p1.arrayThrow addObject:[NSString stringWithFormat:@"0"]];
		}
		else
		{
			
			if (scored == p1.score)
			{
				won = 1;
				won1++;
				[self showWinPane];
			}
			p1.score -= scored;
            
			if (scored == 180) {
				[p1 countUp:@"hs180" player:1];
			}
			else if (scored >= 140) {
				[p1 countUp:@"hs140" player:1];
			}
			else if (scored >= 100) {
				[p1 countUp:@"hs100" player:1];
			}
			else if (scored >= 60) {
				[p1 countUp:@"hs60" player:1];
			}
            
            
			[p1.arrayThrow addObject:[NSString stringWithFormat:@"%d",scored]];
		}
		[p1.playerScore setStringValue:[NSString stringWithFormat:@"%d",p1.score]];
        
		float liveAve = (float) (startScore - p1.score)  / [p1.arrayThrow count];
		[p1.fieldLiveAve setStringValue:[NSString stringWithFormat:@"%f",liveAve]];
		[tabP1 reloadData];
		[cOut setArrayCheckOut:p2.score];
		player = 2;
        if (won == 0)
            [self submit:nil];
	}
	else if (player == 2 )
	{
		[cOut setArrayCheckOut:p2.score];
        scored = [self calcMyScore];
		if (scored > p2.score || scored > 180)
		{
			[p2.arrayThrow addObject:[NSString stringWithFormat:@"0"]];
		}
		else
		{
			p2.score -= scored;
			if (scored == 180) {
				[p2 countUp:@"hs180" player:2];
			}
			else if (scored >= 140) {
				[p2 countUp:@"hs140" player:2];
			}
			else if (scored >= 100) {
				[p2 countUp:@"hs100" player:2];
			}
			else if (scored >= 60) {
				[p2 countUp:@"hs60" player:2];
			}
			[p2.arrayThrow addObject:[NSString stringWithFormat:@"%d",scored]];
            
			if (0 == p2.score)
			{
				won = 2;
				won2++;
				[self showWinPane];
			}
			
		}
		[p2.playerScore setStringValue:[NSString stringWithFormat:@"%d",p2.score]];
		
		float liveAve = (float) (startScore - p2.score)  / [p2.arrayThrow count];
		[p2.fieldLiveAve setStringValue:[NSString stringWithFormat:@"%f",liveAve]];
		[tabP2 reloadData];
		[cOut setArrayCheckOut:p1.score];
		player = 1;
	}
    
	[fieldScored setStringValue:@""];
	[p1 changePlayerDisp:player];
    [tabP1 scrollRowToVisible:[p1.arrayThrow count]-1];
    [tabP2 scrollRowToVisible:[p2.arrayThrow count]-1];
}

-(int)showWinPane
{
    if (won == 2)
    {
        winPane.throws = 3;
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc postNotificationName:throwChanged3 object:self];
        return 3;
    }
    else
    {
        if (!winPane)
        {
            winPane = [[WinPane alloc]init];
        }
        [winPane showWindow:self];
        return winPane.throws;
    }
}

-(void)handleThrowChange:(NSNotification *) note
{
	float aveScore1;
	float aveScore31;
	float aveScore2;
	float aveScore32;
	int throws1;
    int throws2;
    throws1 = [p1.arrayThrow count];
    throws2 = [p2.arrayThrow count];
	if (won == 1)
	{
		aveScore1 = (float)startScore / (((throws1 - 1)*3) + (winPane.throws));
		aveScore31 = (float)startScore / (((throws1 - 1)) + (winPane.throws)/3);
        
		aveScore2 = (float)(startScore-p2.score) / throws2/3;
		aveScore32 = (float)(startScore-p2.score) / throws2;
		
	}
	else
	{
		aveScore2 = (float)startScore / (((throws2 - 1)*3) + (winPane.throws));
		aveScore32 = (float)startScore / (((throws2 - 1)) + (winPane.throws)/3);
		
		aveScore1 = (float)(startScore-p1.score) / throws1/3;
		aveScore31 = (float)(startScore-p1.score) / throws1;
	}
    
//    int throws = (([p1.arrayThrow count] -1)*3 )+ winPane.throws;
    
	[p1 throws:throws1+winPane.throws  player:1];
	[p1 aveScore:aveScore1];
    
    
    [stats add:nil];
    
    [p1 resetStatsArray];
    
	
	[p1.fieldAveScore setStringValue:[NSString stringWithFormat:@"%f",aveScore1]];
	[p1.fieldAveScore3 setStringValue:[NSString stringWithFormat:@"%f",aveScore31]];
	[p2.fieldAveScore setStringValue:[NSString stringWithFormat:@"%f",aveScore2]];
	[p2.fieldAveScore3 setStringValue:[NSString stringWithFormat:@"%f",aveScore32]];
	[p1 reloadTable];
	[p2 reloadTable];
    if (won1*2 >  bestOf || won2*2 > bestOf)
    {
        if (won == 1)
            set1++;
        else
            set2++;
        
        won1=0;
        won2=0;
        
        if (set1+set2 == sets)
        {
            if (!winGame)
            {
                winGame = [[WinGame alloc]init];
            }
            [winGame open:set1 scorep2:set2];
            set1 = 0;
            set2 = 0;
            [self restartG:1];
        }
    }
    else
        [self restartG:0];
}

-(void)handleGameTypeChange:(NSNotification *) note
{
	[self restartG:1];
}



-(IBAction)restartGame:(id)sender
{
	won1=0;
	won2=0;
    set1=0;
    set2=0;
	player=1;
	startPlayer = 1;
	[self restartG:1];
}

-(void)restartG:(int)pref
{
	if (pref == 0) 
    {
        NSLog(@"pref0");
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
				//player = 1;
				break;
		}
	}
	else if (pref == 1) 
    {
        NSLog(@"pref1");
        [p1 resetStatsArray];
        [p1 reset];
        [p2 reset];
        [p1 reloadTable];
        [p2 reloadTable];
		//player = 1;
        startPlayer = 1;
        myScore = [self calcMyAve];
        [self setRand];

	}
    
	numPlayers = 3;
    won = 0;
	[p1 changePlayerDisp:player];
	[p1.arrayThrow removeAllObjects];
	[p2.arrayThrow removeAllObjects];
	[tabP1 reloadData];
	[tabP2 reloadData];
	[p1 setScore:startScore];
	[p2 setScore:startScore];
	[p1.playerScore setStringValue:[NSString stringWithFormat:@"%d",p1.score]];
	[p2.playerScore setStringValue:[NSString stringWithFormat:@"%d",p2.score]];
	[p1.fieldLiveAve setStringValue:@"-"];
	[p2.fieldLiveAve setStringValue:@"-"];
	
    
	[fieldScored setStringValue:@""];
	winPane.throws = 0;
	[fieldStats setStringValue:[NSString stringWithFormat:@"%d:%d",won1,won2]];
    [fieldSets setStringValue:[NSString stringWithFormat:@"%d:%d",set1,set2]];
    if (startPlayer == 2)
        [self submit:nil];
//	NSLog(@"aus x01 restartG player %d, startplayer %d",player, startPlayer);	
}

-(IBAction)revertLast:(id)sender
{
    int oldScore = [[p1.arrayThrow lastObject] intValue];
    p1.score = p1.score + oldScore;
    [p1.arrayThrow removeLastObject];
    [tabP1 reloadData];
    [p1.playerScore setStringValue:[NSString stringWithFormat:@"%d",p1.score]];
    
    if (oldScore == 180) {
        [p1 countDown:@"hs180" player:1];
    }
    else if (oldScore >= 140) {
        [p1 countDown:@"hs140" player:1];
    }
    else if (oldScore >= 100) {
        [p1 countDown:@"hs100" player:1];
    }
    else if (oldScore >= 60) {
        [p1 countDown:@"hs60" player:1];
    }
    [cOut setArrayCheckOut:p1.score];

    oldScore = [[p2.arrayThrow lastObject] intValue];
    p2.score = p2.score + oldScore;
    [p2.arrayThrow removeLastObject];
    [tabP2 reloadData];
    [p2.playerScore setStringValue:[NSString stringWithFormat:@"%d",p2.score]];
    
    if (oldScore == 180) {
        [p2 countDown:@"hs180" player:2];
    }
    else if (oldScore >= 140) {
        [p2 countDown:@"hs140" player:2];
    }
    else if (oldScore >= 100) {
        [p2 countDown:@"hs100" player:2];
    }
    else if (oldScore >= 60) {
        [p2 countDown:@"hs60" player:2];
    }
    [cOut setArrayCheckOut:p2.score];
    
}

- (void)awakeFromNib 
{
    [tabP1 setRefusesFirstResponder:TRUE];
    [tabP2 setRefusesFirstResponder:TRUE];
    [cOut refuseTabCheckout];
    [p1 refuseTableHighscore];
    [p2 refuseTableHighscore];
    // [tabStats setRefusesFirstResponder:TRUE];
	[p1.playerScore setStringValue:[NSString stringWithFormat:@"%d",p1.score]];
	[p1 changePlayerDisp:player];
	[p1.fieldAveScore setStringValue:@"-"];
	[p1.fieldAveScore3 setStringValue:@"-"];
	[p2.playerScore setStringValue:[NSString stringWithFormat:@"%d",p2.score]];
	[p2.fieldAveScore setStringValue:@"-"];
	[p2.fieldAveScore3 setStringValue:@"-"];
    [self restartG:0];
}

-(void)dealloc
{
    [winPane release];
    [winGame release];
    
    [super dealloc];
}


-(int)calcMyAve
{
    int ret = 0;
    
    NSManagedObjectContext *context = [stats managedObjectContext] ;
    NSPersistentStoreCoordinator *psc = [context persistentStoreCoordinator];
    NSManagedObjectModel *model = [psc managedObjectModel];
    NSEntityDescription *entity = [[model entitiesByName] objectForKey:@"Stats"];
    NSFetchRequest * fetch = [[NSFetchRequest alloc] init];
    
    [fetch setEntity:entity];
    
    NSArray * result = [context executeFetchRequest:fetch error:nil];
    
    int countArr = [result count];
    
//    NSLog(@"%@",result);
    
    if (countArr > 0)
    {
        for (id ave in result)
        {
            NSString *foo = [NSString stringWithFormat:@"%@",ave];
            NSRange startRange = [foo rangeOfString:@"aveScore3 ="];
            NSRange searchRange = NSMakeRange(startRange.location+12, 5);
            NSString *bar = [[foo substringWithRange:searchRange] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            ret += [bar intValue];
        }
        
        ret =  ret/countArr;
    }
    else
        ret = 50;
    
    [fetch release];
    
    return ret;
    
}

-(NSInteger)calcMyScore
{
    int delta = 20;
    int score = 0;
    BOOL canBreak = TRUE;
        
    if (myScore > p2.score)
    {
        if (rand()%2 == 1)
            score = p2.score;
    }
    else
    {
        while (canBreak)
        {
            score = arc4random()%myScore+delta;
            
            if (rand()%rand180 == 27)
                score = 180;
            else if (rand()%rand140 == 27)
                score = 140;
            else if (rand()%rand100 == 13)
                score = 100;
            
            if (score < p2.score)
                canBreak = FALSE;
            if (score-p2.score != 1)
                canBreak = FALSE;
            if (score < 170 || score != 169 || score != 168 || score != 165 || score != 166||score != 163 || score != 162 || score != 161 || score != 159)
                canBreak = FALSE;
            
            
        }
    }
//    canBreak = TRUE;
//    NSLog(@"score: %d",score);
    
    return score;
    
}

-(void)setRand
{
    rand180 = 100;
    rand140 = 50;
    rand100 = 30;
    
    if (myScore > 80)
    {
        rand180 = 30;
    }
    else if (myScore > 70)
    {
        rand140 = 30;
        rand180 = 60;
    }
    else if (myScore > 60)
    {
        rand180 = 70;
        rand140 = 40;
        rand100 = 20;
    }
}

@end
