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

#import "CheckOutCalc.h"


@implementation CheckOutCalc

- (id)init
{
    self = [super initWithWindowNibName:@"CheckOutCalc"];
    if (self) {
        arrRet = [[NSMutableArray alloc]init ];
        stringOut = [[NSMutableString alloc]init];
        retString = [[NSMutableString alloc]init];
    }
    
    return self;
}


-(NSArray *)calc:(int)scoreToCalc
{
    [arrRet removeAllObjects];
    
    //dartpro lösung
    if (!arrFields)
    {
        arrFields = [[NSArray alloc]initWithObjects:@"25",@"24",@"27",@"30",@"33",@"36",@"39",@"42",@"45",@"48",@"51",@"54",@"57",@"0",@"60",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"50",@"2",@"4",@"6",@"8",@"10",@"12",@"14",@"16",@"18",@"20",@"22",@"24",@"26",@"28",@"30",@"32",@"34",@"36",@"38",@"40", nil];
    }
    
    switch (scoreToCalc) {
        case 170:
            [arrRet addObject:[NSString stringWithFormat:@"60 60 %@",[self replaceScoresDouble:[NSString stringWithFormat:@"%d",50]]]];
            break;
        case 167:
            [arrRet addObject:[NSString stringWithFormat:@"60 57 %@",[self replaceScoresDouble:[NSString stringWithFormat:@"%d",50]]]];
            break;
        case 164:
            [arrRet addObject:[NSString stringWithFormat:@"60 54 %@",[self replaceScoresDouble:[NSString stringWithFormat:@"%d",50]]]];
            [arrRet addObject:[NSString stringWithFormat:@"57 57 %@",[self replaceScoresDouble:[NSString stringWithFormat:@"%d",50]]]];
            break;
        case 161:
            [arrRet addObject:[NSString stringWithFormat:@"60 51 %@",[self replaceScoresDouble:[NSString stringWithFormat:@"%d",50]]]];
            [arrRet addObject:[NSString stringWithFormat:@"57 54 %@",[self replaceScoresDouble:[NSString stringWithFormat:@"%d",50]]]];
            break;
        case 156:
            [arrRet addObject:[NSString stringWithFormat:@"60 60 %@",[self replaceScoresDouble:[NSString stringWithFormat:@"%d",36]]]];
            break;
            
        default:
            for ( int z=45;z>=26;z--)
            {
                for (int y=0;y<=26;y++)
                {
                    for (int x=0;x<=26;x++)
                    {
                        int s1 = [[arrFields objectAtIndex:x] intValue];
                        int s2 = [[arrFields objectAtIndex:y] intValue];
                        int d = [[arrFields objectAtIndex:z] intValue];
                        
                        if ( s1+s2+d == scoreToCalc )
                        {
                            if (s1 == 0)
                            {
                                [arrRet insertObject:[NSString stringWithFormat:@"- %d %@",s2,[self replaceScoresDouble:[NSString stringWithFormat:@"%d",d]]] atIndex:0];
                            }
                            else if ( s1 >= s2 && s2 != 0)
                            { 
                                [arrRet addObject:[NSString stringWithFormat:@"%d %d %@",s1,s2,[self replaceScoresDouble:[NSString stringWithFormat:@"%d",d]]]];
                            }
                        }
                    }
                }
            }
            break;
    }
    
    
    //alte lösung
    
    /*
     
     if (!arrScore)
     {
     arrScore = [[NSArray alloc] initWithObjects:@"60",@"57",@"54",@"51",@"50",@"48",@"45",@"42",@"40",@"38",@"36",@"34",@"33",@"32",@"30",@"28",@"27",@"26",@"25",@"24",@"22",@"21",@"20",@"19",@"18",@"17",@"16",@"15",@"14",@"13",@"12",@"11",@"10",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2",@"1",@"0",nil];
     }
     
     if (!arrDouble)
     {
     arrDouble = [[NSArray alloc] initWithObjects:@"40",@"38",@"36",@"34",@"32",@"30",@"28",@"26",@"24",@"22",@"20",@"18",@"16",@"14",@"12",@"10",@"8",@"6",@"4",@"2",@"50",nil];
     }
     
    int countD = [arrScore count];
    int count = [arrDouble count];
    
    for (int i=0; i <count;i++)
    {
        for (int j=0;j<count;j++)
        {
            for (int k=0;k<countD;k++)
            {
                int s1 = [[arrScore objectAtIndex:k] intValue];
                int s2 = [[arrScore objectAtIndex:j] intValue];
                int d = [[arrDouble objectAtIndex:i] intValue];
                int total = s1 + s2 + d;
                if (total == scoreToCalc)
                {
                    if (s1 == 0)
					{
						[arrRet insertObject:[NSString stringWithFormat:@"- %d %@",s2,[self replaceScoresDouble:[NSString stringWithFormat:@"%d",d]]] atIndex:0];
					}
                    else if ( s1 >= s2 && s2 != 0)
                    { 
                        [arrRet addObject:[NSString stringWithFormat:@"%d %d %@",s1,s2,[self replaceScoresDouble:[NSString stringWithFormat:@"%d",d]]]];
                    }
                }
            }
        }
    }*/
    return arrRet;
}

-(IBAction)calcButton:(id)sender
{
    score = [scoreIn intValue];
    
    arrDisp = [self calc:score];
    
    [stringOut setString:@""];
   
    int countArrDisp = [arrDisp count];
    if (  countArrDisp > 0 )
    {
        for (int i=0;i<countArrDisp;i++)
        {
			[stringOut appendFormat:@"%@\n",[self replaceScores:[NSString stringWithFormat:@"%@",[arrDisp objectAtIndex:i]]]];
        }  
    }
    else
    {
        [stringOut setString:@"No checkout"];
    }
    [stringOut replaceOccurrencesOfString:@" " withString:@"\t\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [stringOut length])];
    [scoreOut setString:stringOut];
}


-(NSString *)replaceScores:(NSString *)stringToReplace
{
    [retString setString:stringToReplace];
    
    [retString replaceOccurrencesOfString:@" 0 " withString:@" - " options:NSCaseInsensitiveSearch range:NSMakeRange(0, [retString length]-3)];
    [retString replaceOccurrencesOfString:@"22" withString:@"D11" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [retString length]-3)];
    [retString replaceOccurrencesOfString:@"24" withString:@"T8" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [retString length]-3)];
    [retString replaceOccurrencesOfString:@"26" withString:@"D13" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [retString length]-3)];
    [retString replaceOccurrencesOfString:@"27" withString:@"T9" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [retString length]-3)];
    [retString replaceOccurrencesOfString:@"28" withString:@"D14" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [retString length]-3)];
    [retString replaceOccurrencesOfString:@"30" withString:@"T10" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [retString length]-3)];
    [retString replaceOccurrencesOfString:@"32" withString:@"D16" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [retString length]-3)];
    [retString replaceOccurrencesOfString:@"33" withString:@"T11" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [retString length]-3)];
    [retString replaceOccurrencesOfString:@"34" withString:@"D17" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [retString length]-3)];
    [retString replaceOccurrencesOfString:@"36" withString:@"T12" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [retString length]-3)];
    [retString replaceOccurrencesOfString:@"38" withString:@"D19" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [retString length]-3)];
    [retString replaceOccurrencesOfString:@"39" withString:@"T13" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [retString length]-3)];
    [retString replaceOccurrencesOfString:@"40" withString:@"D20" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [retString length]-3)];
    [retString replaceOccurrencesOfString:@"42" withString:@"T14" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [retString length]-3)];
    [retString replaceOccurrencesOfString:@"45" withString:@"T15" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [retString length]-3)];
    [retString replaceOccurrencesOfString:@"48" withString:@"T16" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [retString length]-3)];
    [retString replaceOccurrencesOfString:@"51" withString:@"T17" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [retString length]-3)];
    [retString replaceOccurrencesOfString:@"54" withString:@"T18" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [retString length]-3)];
    [retString replaceOccurrencesOfString:@"57" withString:@"T19" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [retString length]-3)];
    [retString replaceOccurrencesOfString:@"60" withString:@"T20" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [retString length]-3)];
    [retString replaceOccurrencesOfString:@"50" withString:@"Bull" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [retString length]-3)];
    
	
    return retString;
}

-(NSString *)replaceScoresDouble:(NSString *)stringToReplace
{
    [retString setString:stringToReplace];
    
	int rep = [stringToReplace intValue];
	
	if (rep == 50)
	{
		[retString replaceOccurrencesOfString:[NSString stringWithFormat:@"%d",rep] withString:@"Bull" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [retString length])];
	}
	else 
	{
		[retString replaceOccurrencesOfString:[NSString stringWithFormat:@"%d",rep] withString:[NSString stringWithFormat:@"D%d",rep/2] options:NSCaseInsensitiveSearch range:NSMakeRange(0, [retString length])];
	}
    
    return retString;
}

-(void)dealloc
{
    [arrRet release];
    [stringOut release];
    [retString release];
    
    [super dealloc];
}

@end
