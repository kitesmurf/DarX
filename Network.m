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

#import "Network.h"
#import "Global.h"


@implementation Network

- (id)init
{
    
    [super init];
     
    iStream = [[NSInputStream alloc] init];
    oStream = [[NSOutputStream alloc] init];
    content = [[NSMutableString alloc]init];

    return self;
}
//verbindung
- (void)openConn:(NSString *)urlStr
{
    NSLog(@"urlstr: %@",urlStr);
    if (![urlStr isEqualToString:@""]) 
    {
        
        NSLog(@"open connection");
        NSHost *host= [NSHost hostWithAddress:urlStr];
        [NSStream getStreamsToHost:host port:47141 inputStream:&iStream outputStream:&oStream];
        
        [iStream retain];
        [oStream retain];
        
        [iStream setDelegate:self];
        [oStream setDelegate:self];
        [iStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                           forMode:NSDefaultRunLoopMode];
        [oStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
                           forMode:NSDefaultRunLoopMode];
        [iStream open];
        [oStream open];
        
        
        while ([iStream streamStatus] == NSStreamStatusOpening) {
            sleep(2);
            NSLog(@"sleep");
        }
        switch ([oStream streamStatus]) {
            case NSStreamStatusNotOpen:
            NSLog(@"NSStreamStatusNotOpen");
                break;
            case NSStreamStatusOpening:
                NSLog(@"NSStreamStatusOpening");
                break;
            case NSStreamStatusOpen:
                NSLog(@"NSStreamStatusOpen");
                break;
            case NSStreamStatusReading:
                NSLog(@"NSStreamStatusReading");
                break;
            case NSStreamStatusWriting:
                NSLog(@"NSStreamStatusWriting");
                break;
            case NSStreamStatusAtEnd:
                NSLog(@"NSStreamStatusAtEnd");
                break;
            case NSStreamStatusClosed:
                NSLog(@"NSStreamStatusClosed");
                break;
            case NSStreamStatusError:
                NSLog(@"NSStreamStatusError");
                break;
            default:
                NSLog(@"kacke");
                break;
        }
        if ([iStream streamStatus] == NSStreamStatusOpen)
        {
            [self connGame];
        }
        else
        {
            if (!winConErr)
            {
                winConErr = [[ConnErr alloc] init];
            }
            [winConErr openErr:@"Network error"];
        }
    }
    
    
  
}

-(void)closeConn
{
    if (iStream)
    {
        [iStream close];
        [iStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [iStream setDelegate:nil];
        [iStream release];
    }
    if (oStream)
    {
        [oStream close];
        [oStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [oStream setDelegate:nil];
        [oStream release];
    }
    isConWinOpen = FALSE;
    NSLog(@"Connection closed.");
}

//stream erhalten
- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode 
{
    
    switch(eventCode) {
        case NSStreamEventErrorOccurred:
        {
            NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
            [nc postNotificationName:netErr object:self];
            [winConErr openErr:@"Network error"];
            [self closeConn];
            break;
        }
        case NSStreamEventHasBytesAvailable:
        {
            if(!data) {
                data = [[NSMutableData data] retain];
            }
            uint8_t buf[1024];
            unsigned int len = 0;
            len = [(NSInputStream *)stream read:buf maxLength:1024];
            if(len) {
                [data appendBytes:(const void *)buf length:len];
                
                

                NSString *recieved = [[NSString alloc]  initWithBytes:[data bytes] length:[data length] encoding: NSUTF8StringEncoding];
                
                NSLog(@"foo: %@",recieved);
                if (recieved)
                    [content setString:recieved];
                else
                    NSLog(@"foo: %@",recieved);
                [recieved release];
           
                data = nil;
                NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
                [nc postNotificationName:hostSent object:self];

                
            } else {
                NSLog(@"no buffer!");
            }
            break;
        }
    }
}


-(void)sendRemote:(NSString *)stringToSend
{
    NSData * dataToSend = [stringToSend dataUsingEncoding:NSUTF8StringEncoding];
    if (oStream) {
        int remainingToWrite = [dataToSend length];
        void * marker = (void *)[dataToSend bytes];
        while (0 < remainingToWrite) {
            int actuallyWritten = 0;
            actuallyWritten = [oStream write:marker maxLength:remainingToWrite];
            remainingToWrite -= actuallyWritten;
            marker += actuallyWritten;
        }
        
        NSLog(@"send text: %@",stringToSend);
    }
}


-(void)connGame
{
    isConWinOpen = TRUE;
    [self sendRemote:[NSString stringWithFormat:@"CONNECT|%@ ",player1]];
}

-(void)dealloc
{
    [winConErr release];
    [content release];
    [output release];
    [input release];
    [data release];
    [iStream release];
    [oStream release];
    [super dealloc];
}

@synthesize content;
@synthesize iStream;
@synthesize oStream;

@end
