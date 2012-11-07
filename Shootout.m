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

#import "Shootout.h"


@implementation Shootout

- (id)init
{
   
    [super initWithNibName:@"Shootout" bundle:nil];
    [self setTitle:@"Shootout"];
    
    NSNotificationCenter *ncThrowChange = [NSNotificationCenter defaultCenter];
    [ncThrowChange addObserver:self
                      selector:@selector(restartGNote:)
                          name:shootOutSaved
                        object:nil];

    p1.score = 0;
    
    return self;
}

-(IBAction)submit:(id)sender
{
    int scored = [fieldScored intValue];
    [p1.arrayThrow addObject:[NSString stringWithFormat:@"%d",scored]];
    p1.score += scored;
    [p1.playerScore setStringValue:[NSString stringWithFormat:@"%d",p1.score]];
    
    float ave = (float) p1.score/[p1.arrayThrow count];
    
    [p1.fieldAveScore3 setStringValue:[NSString stringWithFormat:@"%f",ave]];
    [p1.fieldAveScore setStringValue:[NSString stringWithFormat:@"%f",ave/3]];
    
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
    
    [tabScored reloadData];
    [tabScored scrollRowToVisible:[tabScored numberOfRows]-1];
    
	[fieldScored setStringValue:@""];
    
    [arrayStatsHighScore replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@"%lu",[p1.arrayThrow count]]]; 
    [arrayStatsHighScore replaceObjectAtIndex:5 withObject:[NSString stringWithFormat:@"%d",p1.score]];
}

-(IBAction)restart:(id)sender
{
    [self restartG];
}

-(void)restartG
{
    
    [p1.arrayThrow removeAllObjects];
    [tabScored reloadData];
    p1.score = 0;
    [p1.playerScore setStringValue:[NSString stringWithFormat:@"%d",p1.score]];
    [p1.fieldAveScore3 setStringValue:@"0"];
    [p1.fieldAveScore setStringValue:@"0"];
    [p1 reset];
    [p1 reloadTable];
    
    for (int i =0; i<4; i++) {
		[p1.arrayHighScore replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"0"]];
	}
    
    for (int i=0;i<6;i++)
    {
        [arrayStatsHighScore replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"0"]];
    }
}


-(void)restartGNote:(NSNotification *)note
{
    [self restartG];
}


-(IBAction)revert:(id)sender
{
    int lScore = [[p1.arrayThrow lastObject] intValue];
    p1.score -= lScore;
    [p1.playerScore setStringValue:[NSString stringWithFormat:@"%d",p1.score]];
    
    [p1.arrayThrow removeLastObject];
    [tabScored reloadData];

    float ave = (float) p1.score/[p1.arrayThrow count];
    
    [p1.fieldAveScore3 setStringValue:[NSString stringWithFormat:@"%f",ave]];
    [p1.fieldAveScore setStringValue:[NSString stringWithFormat:@"%f",ave/3]];
    
    if (lScore == 180) {
        [p1 countDown:@"hs180" player:1];
    }
    else if (lScore >= 140) {
        [p1 countDown:@"hs140" player:1];
    }
    else if (lScore >= 100) {
        [p1 countDown:@"hs100" player:1];
    }
    else if (lScore >= 60) {
        [p1 countDown:@"hs60" player:1];
    }
}


-(void)awakeFromNib
{
    [tabStats setRefusesFirstResponder:TRUE];
    [tabScored setRefusesFirstResponder:TRUE];
    [tabHS setRefusesFirstResponder:TRUE];
    [p1.playerDisp setStringValue:[NSString stringWithFormat:@"%@'s turn",player1]];
    [tabHS setRefusesFirstResponder:TRUE];
    [tabScored setRefusesFirstResponder:TRUE];
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

-(void)dealloc
{
    [p1 release];
    [fieldScored release];
    [tabScored release];
    [tabHS release];
    
    [super dealloc];
}


@end
