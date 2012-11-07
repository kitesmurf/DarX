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


#import "CheckOut.h"


@implementation CheckOut


-(id)init
{
	[super init];

	if (!arrayCheckOut)
	{
		arrayCheckOut = [[NSMutableArray alloc] init];
		[arrayCheckOut addObject:@"-"];
		cOutCalc = [[CheckOutCalc alloc]init];
	}
	return self;
}

-(id)arrayCheckOut
{	return self;
}

-(void)setArrayCheckOut:(int)num
{
	[arrayCheckOut removeAllObjects];
	switch (num) {
		case 170:
			[arrayCheckOut addObject:@"T20, T20, Bull"];
			break;
		case 167:
			[arrayCheckOut addObject:@"T20, T19, Bull"];
			break;
		case 164:
			[arrayCheckOut addObject:@"T20, T18, Bull"];
			break;
		case 161:
			[arrayCheckOut addObject:@"T20, T17, Bull"];
			break;
		case 160:
			[arrayCheckOut addObject:@"T20, T20, D20"];
			break;
		case 158:
			[arrayCheckOut addObject:@"T20, T20, D19"];
			break;
		case 157:
			[arrayCheckOut addObject:@"T20, T19, D20"];
			break;
		case 156:
			[arrayCheckOut addObject:@"T20, T20, D18"];
			break;
		case 155:
			[arrayCheckOut addObject:@"T20, T19, D19"];
			break;
		case  154:
			[arrayCheckOut addObject:@"T20, T18, D20"];
			break;
		case  153:
			[arrayCheckOut addObject:@"T20, T19, D18"];
			break;
		case  152:
			[arrayCheckOut addObject:@"T20, T20, D16"];
			break;
		case  151:
			[arrayCheckOut addObject:@"T20, T17, D20"];
			break;
		case  150:
			[arrayCheckOut addObject:@"T20, T18, D18"];
			break;
		case  149:
			[arrayCheckOut addObject:@"T20, T19, D16"];
			break;
		case  148:
			[arrayCheckOut addObject:@"T20, T16, D20"];
			break;
		case  147:
			[arrayCheckOut addObject:@"T20, T17, D18"];
			break;
		case  146:
			[arrayCheckOut addObject:@"T20, T18, D16"];
			break;
		case 145:
			[arrayCheckOut addObject:@"T20 T15 D20"];
			break;
		case 144:
			[arrayCheckOut addObject:@"T20 T20 D12"];
			break;
		case 143:
			[arrayCheckOut addObject:@"T20 T17 D16"];
			break;
		case 142:
			[arrayCheckOut addObject:@"T20 T14 D20"];
			break;
		case 141:
			[arrayCheckOut addObject:@"T20 T15 D18"];
			break;
		case 140:
			[arrayCheckOut addObject:@"T20 T16 D16"];
			break;
		case 139:
			[arrayCheckOut addObject:@"T20 T13 D20"];
			break;
		case 138:
			[arrayCheckOut addObject:@"T20 T14 D18"];
			break;
		case 137:
			[arrayCheckOut addObject:@"T20 T15 D16"];
			break;
		case 136:
			[arrayCheckOut addObject:@"T20 T20 D8"];
			break;
		case 135:
			[arrayCheckOut addObject:@"T20 T13 D18"];
			break;
		case 134:
			[arrayCheckOut addObject:@"T20 T14 D16"];
			break;
		case 133:
			[arrayCheckOut addObject:@"T20 T19 D8"];
			break;
		case 132:
			[arrayCheckOut addObject:@"T20 T16 D12"];
			break;
		case 131:
			[arrayCheckOut addObject:@"T20 T13 D16"];
			break;
		case 130:
			[arrayCheckOut addObject:@"T20 T18 D8"];
			break;
		case 129:
			[arrayCheckOut addObject:@"T19 T16 D12"];
			break;
		case 128:
			[arrayCheckOut addObject:@"T20 T20 D4"];
			break;
		case 127:
			[arrayCheckOut addObject:@"T20 T17 D8"];
			break;
		case 126:
			[arrayCheckOut addObject:@"T19 19 Bull"];
			break;
		case 125:
			[arrayCheckOut addObject:@"T20 T19 D4"];
			break;
		case 124:
			[arrayCheckOut addObject:@"T20 T16 D8"];
			break;
		case 123:
			[arrayCheckOut addObject:@"T20 T13 D12"];
			break;
		case 122:
			[arrayCheckOut addObject:@"T18 18 Bull"];
			break;
		case 121:
			[arrayCheckOut addObject:@"25 T20 D18"];
			break;
		case 120:
			[arrayCheckOut addObject:@"T20 20 D20"];
			break;
		case 119:
			[arrayCheckOut addObject:@"19 T20 D20"];
			break;
		case 118:
			[arrayCheckOut addObject:@"T20 18 D20"];
			break;
		case 117:
			[arrayCheckOut addObject:@"T20 17 D20"];
			break;
		case 116:
			[arrayCheckOut addObject:@"T20 16 D20"];
			break;
		case 115:
			[arrayCheckOut addObject:@"19 T20 D18"];
			break;
		case 114:
			[arrayCheckOut addObject:@"T20 14 D20"];
			break;
		case 113:
			[arrayCheckOut addObject:@"T20 13 D20"];
			break;
		case 112:
			[arrayCheckOut addObject:@"T20 12 D20"];
			break;
		case 111:
			[arrayCheckOut addObject:@"T20 19 D16"];
			break;
		case 110:
			[arrayCheckOut addObject:@"T20 10 D20"];
			break;
		case 109:
			[arrayCheckOut addObject:@"T20 17 D16"];
			break;
		case 108:
			[arrayCheckOut addObject:@"T19 19 D16"];
			break;
		case 107:
			[arrayCheckOut addObject:@"T19 10 D20"];
			break;
		case 106:
			[arrayCheckOut addObject:@"T20 10 D18"];
			break;
		case 105:
			[arrayCheckOut addObject:@"T20 13 D16"];
			break;
		case 104:
			[arrayCheckOut addObject:@"T20 12 D16"];
			break;
		case 103:
			[arrayCheckOut addObject:@"T19 10 D18"];
			break;
		case 102:
			[arrayCheckOut addObject:@"T20 10 D16"];
			break;
		case 101:
			[arrayCheckOut addObject:@"T17 10 D20"];
			break;
		case 100:
			[arrayCheckOut addObject:@"- T20 D20"];
			break;
		case 99:
			[arrayCheckOut addObject:@"- T20 S7 D16"];
			break;
		case 98:
			[arrayCheckOut addObject:@"- T20 D19"];
			break;
		case 97:
			[arrayCheckOut addObject:@"- T19 D20"];
			break;
		case 96:
			[arrayCheckOut addObject:@"- T20 D18"];
			break;
		case 95:
			[arrayCheckOut addObject:@"- T19 D19"];
			break;
		case 94:
			[arrayCheckOut addObject:@"- T18 D20"];
			break;
		case 93:
			[arrayCheckOut addObject:@"- T19 D18"];
			break;
		case 92:
			[arrayCheckOut addObject:@"- T20 D16"];
			break;
		case 91:
			[arrayCheckOut addObject:@"- T17 D20"];
			break;
		case 90:
			[arrayCheckOut addObject:@"- T18 D18"];
			break;
		case 89:
			[arrayCheckOut addObject:@"- T19 D16"];
			break;
		case 88:
			[arrayCheckOut addObject:@"- T16 D20"];
			break;
		case 87:
			[arrayCheckOut addObject:@"- T17 D18"];
			break;
		case 86:
			[arrayCheckOut addObject:@"- T18 D16"];
			break;
		case 85:
			[arrayCheckOut addObject:@"- T15 D20"];
			break;
		case 84:
			[arrayCheckOut addObject:@"- T20 D12"];
			break;
		case 83:
			[arrayCheckOut addObject:@"- T17 D16"];
			break;
		case 82:
			[arrayCheckOut addObject:@"- T14 D20"];
			break;
		case 81:
			[arrayCheckOut addObject:@"- T15 D18"];
			break;
		case 80:
			[arrayCheckOut addObject:@"- T20 D10"];
			break;
		case 79:
			[arrayCheckOut addObject:@"- T13 D20"];
			break;
		case 78:
			[arrayCheckOut addObject:@"- T18 D12"];
			break;
		case 77:
			[arrayCheckOut addObject:@"- T19 D10"];
			break;
		case 76:
			[arrayCheckOut addObject:@"- T20 D8"];
			break;
		case 75:
			[arrayCheckOut addObject:@"- T17 D12"];
			break;
		case 74:
			[arrayCheckOut addObject:@"- T18 D10"];
			break;
		case 73:
			[arrayCheckOut addObject:@"- T19 D8"];
			break;
		case 72:
			[arrayCheckOut addObject:@"- T12 D18"];
			break;
		case 71:
			[arrayCheckOut addObject:@"- T17 D10"];
			break;
		case 70:
			[arrayCheckOut addObject:@"- T10 D20"];
			break;
		case 69:
			[arrayCheckOut addObject:@"- T13 D15"];
			break;
		case 68:
			[arrayCheckOut addObject:@"- T20 D4"];
			break;
		case 67:
			[arrayCheckOut addObject:@"- T17 D8"];
			break;
		case 66:
			[arrayCheckOut addObject:@"- T10 D18"];
			break;
		case 65:
			[arrayCheckOut addObject:@"- 25 D20"];
			break;
		case 64:
			[arrayCheckOut addObject:@"- T16 D8"];
			break;
		case 63:
			[arrayCheckOut addObject:@"- T13 D12"];
			break;
		case 62:
			[arrayCheckOut addObject:@"- T10 D16"];
			break;
		case 61:
			[arrayCheckOut addObject:@"- 25 D18"];
			break;
		case 60:
			[arrayCheckOut addObject:@"- S20 D20"];
			break;                  			
		case 500:
			[arrayCheckOut addObject:@"ahahaha"];
			break;
		default:
			[arrayCheckOut addObject:@"-"];
			break;
			
	}
	if ( num > 60 )
    {
        [self addScore:num];
    }
	[tableCheckOut reloadData];
}

-(void)addScore:(int)score
{
	NSArray *ins = [cOutCalc calc:score];
	int count = [ins count];
	
	for (int i=0;i<count;i++)
	{		
		NSString *ret;
		ret = [NSString stringWithFormat:@"%@",[ins objectAtIndex:i]];
		[arrayCheckOut addObject:[NSString stringWithFormat:@"%@",[cOutCalc replaceScores:ret]]];
	}
}
- (int)numberOfRowsInTableView:(NSTableView *)tv
{	
	return [arrayCheckOut count];
}

-(void)refuseTabCheckout
{
    [tableCheckOut setRefusesFirstResponder:TRUE];
}

- (id)tableView:(NSTableView *)tv
objectValueForTableColumn:(NSTableColumn *)tColumn
			row:(int)row
{
	NSString *v = [arrayCheckOut objectAtIndex:row];
	return v;
}

@end
