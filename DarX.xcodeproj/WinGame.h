//
//  WinGame.h
//  DarX
//
//  Created by lupus on 12.03.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Global.h"


@interface WinGame : NSWindowController {

    IBOutlet NSTextField *fieldWin;
}
-(void)open:(int)won1 scorep2:(int)won2;
-(IBAction)close:(id)sender;


@end
