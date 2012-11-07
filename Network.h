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


#import <Foundation/Foundation.h>

#import "ManagingViewController.h"
#import "Connect.h"
#import "ConnErr.h"

@interface Network :  NSObject  <NSStreamDelegate> 
{

    IBOutlet NSTextField *output;
    IBOutlet NSTextField *input;
    
    NSInputStream *iStream;
    NSOutputStream *oStream;
    NSMutableData *data;
    NSMutableString *content;
    
    ConnErr *winConErr;
    
    
}

-(void)openConn:(NSString *)urlStr;
-(void)closeConn;
-(void)connGame;
-(void)sendRemote:(NSString *)stringToSend;


@property (retain) NSMutableString *content;
@property (retain) NSInputStream *iStream;
@property (retain) NSOutputStream *oStream;

@end
