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


#import "x011.h"


@implementation x011

- (id) init
{
	[super initWithNibName:@"x011" bundle:nil];
	[self setTitle:@"1 Player x01"];
    
	
	player = 1;
	[p1 setScore:startScore];
	NSNotificationCenter *ncThrowChange = [NSNotificationCenter defaultCenter];
    [ncThrowChange addObserver:self
           selector:@selector(handleThrowChange:)
               name:throwChanged1
             object:nil];
	NSNotificationCenter *ncGameType = [NSNotificationCenter defaultCenter];
    [ncGameType addObserver:self
           selector:@selector(handleGameTypeChange:)
               name:gameTypeChanged1
             object:nil];
    numPlayers = 1;
    
	return self;
	
}

-(void)dealloc
{
    [winPane release];
    [super dealloc];
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


-(IBAction)submit:(id)sender
{
	NSInteger scored = [[fieldScored stringValue] intValue];
	if (scored > p1.score || scored > 180)
	{
		[p1.arrayThrow addObject:[NSString stringWithFormat:@"0"]];
	}
	else
	{
		if (scored == p1.score)
		{
			[discardButton setHidden:FALSE];
			[saveButton setHidden:FALSE];
			[restartButton setHidden:TRUE];
			[submitButton setHidden:TRUE];
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
		
		[cOut setArrayCheckOut:p1.score];
		
		[p1.arrayThrow addObject:[NSString stringWithFormat:@"%d",scored]];
	}
	[p1.playerScore setStringValue:[NSString stringWithFormat:@"%d",p1.score]];
	
	float liveAve = (float) (startScore - p1.score)  / [p1.arrayThrow count];
	[p1.fieldLiveAve setStringValue:[NSString stringWithFormat:@"%f",liveAve]];
	[tabP1 reloadData];
    [tabP1 scrollRowToVisible:[tabP1 numberOfRows]-1];
	[fieldScored setStringValue:@""];
	
}

-(int)showWinPane
{
	if (!winPane)
	{
		winPane = [[WinPane alloc]init];
	}
	[winPane showWindow:self];
	return winPane.throws;
}

-(void)handleThrowChange:(NSNotification *) note
{
	int throws = (([p1.arrayThrow count] -1)*3 )+ winPane.throws;
	float aveScore = (float)startScore / ((([p1.arrayThrow count] - 1)*3) + (winPane.throws));
	[p1.fieldAveScore setStringValue:[NSString stringWithFormat:@"%f",aveScore]];
	[p1 throws:throws player:1];
	[p1 aveScore:aveScore];
	aveScore = aveScore*3;
	[p1.fieldAveScore3 setStringValue:[NSString stringWithFormat:@"%f",aveScore]];
	[p1.arrayHighScore addObject:[NSString stringWithFormat:@"%d",startScore]];
	[p1 reloadTable];
	[self restartG];
}

-(void)handleGameTypeChange:(NSNotification *) note
{
	[self restartG];
}



-(IBAction)restartGame:(id)sender
{
	[self restartG];
}

-(void)restartG
{

	[p1.arrayThrow removeAllObjects];
	[tabP1 reloadData];
	[p1 setScore:startScore];
	[p1.playerScore setStringValue:[NSString stringWithFormat:@"%d",p1.score]];
	winPane.throws = 0;
	[fieldScored setStringValue:@""];
	[p1.fieldLiveAve setStringValue:@"-"];
	[p1 changePlayerDisp:1];
	numPlayers = 1;
    [p1 reset];
    [p1 reloadTable];
	
}

- (void)awakeFromNib 
{
	[tabP1 setRefusesFirstResponder:TRUE];
    [cOut refuseTabCheckout];
    [p1 refuseTableHighscore];
    [tabStats setRefusesFirstResponder:TRUE];
    
	[p1.playerScore setStringValue:[NSString stringWithFormat:@"%d",p1.score]];
	[p1 changePlayerDisp:1];
	[p1.fieldAveScore setStringValue:@"-"];
	[p1.fieldAveScore3 setStringValue:@"-"];
	
	[fieldScored becomeFirstResponder];
	[[fieldScored window] setInitialFirstResponder:fieldScored];
    [self restartG];
}


-(IBAction)revertLast:(id)sender
{
    if ([p1.arrayThrow count] > 0)
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
    }
    
}


-(IBAction)discard:(id)sender
{	
	for (int i =0; i<4; i++) {
		[p1.arrayHighScore replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"0"]];
	}
	[discardButton setHidden:TRUE];
	[saveButton setHidden:TRUE];
	[restartButton setHidden:FALSE];
	[submitButton setHidden:FALSE];
}


-(int)calcAve
{
    int ret = 0;
    
    NSManagedObjectContext *context = [stats managedObjectContext] ;
    NSPersistentStoreCoordinator *psc = [context persistentStoreCoordinator];
    NSManagedObjectModel *model = [psc managedObjectModel];
    NSEntityDescription *entity = [[model entitiesByName] objectForKey:@"Stats"];
    
    //    NSString *bar = [entity valueForKey:@"aveScore3"];
    
    //    NSLog(@"bar: %@",bar );
    
    NSFetchRequest * fetch = [[NSFetchRequest alloc] init];
    [fetch setEntity:entity];
    
    NSArray * result = [context executeFetchRequest:fetch error:nil];
    NSLog(@"result: %@",result);
    
    for (id ave in result)
    {
        NSString *foo = [NSString stringWithFormat:@"%@",ave];
        NSRange startRange = [foo rangeOfString:@"aveScore3 ="];
        NSRange searchRange = NSMakeRange(startRange.location+12, 5);
        NSString *bar = [[foo substringWithRange:searchRange] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        NSLog(@"%@",ave);
        ret += [bar intValue];
    }
    
    [fetch release];
    
    NSLog(@"ret: %d",ret);
    
    return ret/[result count];
}

-(IBAction)calcAveButton:(id)sender
{
    NSLog(@"%d",[self calcAve]);
}


@end
