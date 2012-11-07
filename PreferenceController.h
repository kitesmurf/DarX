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

#import <Cocoa/Cocoa.h>
#import "Global.h"


@interface PreferenceController : NSWindowController {
	IBOutlet NSMatrix *gameType;
    IBOutlet NSTextField *fieldBestOf;
    IBOutlet NSTextField *fieldSets;
	NSInteger row;
	NSInteger column;
	IBOutlet NSTextField *p1Name;
	IBOutlet NSTextField *p2Name;

}

-(IBAction)changeGame:(id)sender;
-(IBAction)closePrefPane:(id)sender;
-(NSString *)sP1Name;
-(NSString *)sP2Name;
-(int)sBOf;
-(int)sStartScore;
-(int)sSets;

@end
