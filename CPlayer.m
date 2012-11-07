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


#import "CPlayer.h"


@implementation CPlayer

- (id)init
{
    self = [super init];
    if (self) {
        
        arrLastThrow = [[NSMutableArray alloc]init];
        arrLastScore = [[NSMutableArray alloc]init];
        arrLastButton = [[NSMutableArray alloc]init];
        scored = [[NSMutableString alloc]init];
    }
    
    return self;
}

-(void)endThrowCricket:(int)aThrows
{
    for (int i = aThrows;i<3;i++)
    {
          scored = [scored stringByAppendingString:@"0 "];
    }
}

-(int)countLevelInd
{
	if (!lInd) {
		lInd = [[NSArray alloc] initWithObjects:l20, l19, l18, l17, l16, l15, lB, nil];
	}
	lCount = 0;
	for (NSLevelIndicator *ob in lInd)
	{
		lCount = lCount + [ob intValue];
	}
	return lCount;
}
-(BOOL)checkLevelFull:(int)ind
{
	if ([[lInd objectAtIndex:ind] intValue] == 3) {
 		return YES;
	}
	else {
 		return NO;
	}
    
}

-(void)revertCricket
{
    int newScore;
    int lastButton = [[arrLastButton lastObject] intValue];
    
    if (lastButton % 3 == 0 && lastButton/2 != 18 && lastButton/2 != 15 && lastButton != 15 && lastButton != 18)
    {
        newScore = lastButton / 3;
    }
    else if (lastButton % 2 == 0 && lastButton != 20 && lastButton != 18 && lastButton != 16)
    {
        newScore = lastButton /2;
    }
    else
    {
        newScore = lastButton;
    }
    
	if (!lInd) {
		lInd = [[NSArray alloc] initWithObjects:l20, l19, l18, l17, l16, l15, lB, nil];
    }
    
    int lIndArrNum;
    
    switch (newScore) {
        case 20:
            lIndArrNum = 0;
            break;
        case 19:
            lIndArrNum = 1;
            break;
        case 18:
            lIndArrNum = 2;
            break;
        case 17:
            lIndArrNum = 3;
            break;
        case 16:
            lIndArrNum = 4;
            break;
        case 15:
            lIndArrNum = 5;
            break;
        case 25:
            lIndArrNum = 6;
            break;
        default:
            lIndArrNum = 7;
            break;
    }
    if (lIndArrNum < 7 )
    {
        int setint1 = [[lInd objectAtIndex:lIndArrNum] intValue];
        int setint2 = [[arrLastThrow lastObject] intValue];
        [[lInd objectAtIndex:lIndArrNum] setIntValue: setint1-setint2];
        score -= [[arrLastScore lastObject] intValue];
    }
    
    [arrLastThrow removeLastObject];
    [arrLastScore removeLastObject];
    [arrLastButton removeLastObject];
}

-(void)resetLevelInd
{
	for (NSLevelIndicator *ob in lInd)
	{
		[ob setIntValue:0];
	}
}

-(void)calcThrow:(id)levelIndicator value: (int)value multi: (int)multi
{
    
    int countLT=0;
    int countLS=0;
    int countLB=0;
    switch (multi) {
        case 1:
            mChar = @"S";
            break;
        case 2:
            mChar = @"D";
            break;
        case 3:
            mChar = @"T";
            break;
            
        default:
            mChar = @"";
            break;
    }
    
    scored = [scored stringByAppendingString:[NSString stringWithFormat:@"%@%d ",mChar,value]];
    [scored retain];
    while (multi > 0)
    {
        liValue = [levelIndicator intValue];
        if (liValue < 3)
        {
            [levelIndicator setIntValue:liValue+1];
            countLT++;
        }
        else
        {
            countLS+=value;
            score += value;
        }
        
        countLB+=value;
        multi--;
    }
    
    [arrLastButton addObject:[NSString stringWithFormat:@"%d",countLB]];
    [arrLastScore addObject:[NSString stringWithFormat:@"%d",countLS]];
    [arrLastThrow addObject:[NSString stringWithFormat:@"%d",countLT]];
    
}

-(void)dealloc
{
    [arrLastThrow release];
    [arrLastScore release];
    [arrLastButton release];
    [scored release];
    
    [super dealloc];
}

@synthesize l20;
@synthesize l19;
@synthesize l18;
@synthesize l17;
@synthesize l16;
@synthesize l15;
@synthesize lB;
@synthesize arrLastThrow;
@synthesize arrLastScore;
@synthesize fieldThrows;
@synthesize arrLastButton;

@end
