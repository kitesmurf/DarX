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
#import "Server.h"

@implementation Server

-(id)init
{
    [super init];
    
    content = [[NSMutableString alloc]init];
    iStream = [[NSInputStream alloc]init];
    oStream = [[NSOutputStream alloc]init];
    
    return self;
}

- (void)setupInputStream:(NSInputStream *)istream outputStream:(NSOutputStream *)ostream {
    iStream = (NSInputStream *)istream;
    oStream = (NSOutputStream *)ostream;
    [iStream retain];
    [oStream retain];
    [iStream setDelegate:self];
    [oStream setDelegate:self];
    [iStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [oStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    CFDictionarySetValue(connections, iStream, oStream);
    [iStream open];
    [oStream open];
    NSLog(@"Added connection.");
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:serverStart object:self];
    
    
}

- (void)shutdownInputStream:(NSInputStream *)istream outputStream:(NSOutputStream *)ostream {
    [istream close];
    [ostream close];
    [istream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [ostream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [istream setDelegate:nil];
    [ostream setDelegate:nil];
    CFDictionaryRemoveValue(connections, istream);
    [istream release];
    [ostream release];
    NSLog(@"Connection closed.");
}

- (void)handleNewConnectionFromAddress:(NSData *)addr inputStream:(NSInputStream *)istr outputStream:(NSOutputStream *)ostr {
    if (!connections) {
        connections = CFDictionaryCreateMutable(NULL, 0, NULL, NULL);
    }
    [self setupInputStream:istr outputStream:ostr];
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)streamEvent {
    NSInputStream * istream;
    switch(streamEvent) {
        case NSStreamEventHasBytesAvailable:;
            if(!data) {
                data = [[NSMutableData data] retain];
            }
            istream = (NSInputStream *)aStream;
            
            uint8_t buffer[2048];
            int actuallyRead = [istream read:(uint8_t *)buffer maxLength:2048];
            if (actuallyRead > 0) {
                [data appendBytes:(const void *)buffer length:actuallyRead];
                
                NSString *recieved = [[NSString alloc]  initWithBytes:[data bytes] length:[data length] encoding: NSUTF8StringEncoding];
                
                [content setString:recieved];
                [recieved release];
                
//                data = nil;
                NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
                [nc postNotificationName:hostSent object:self];
            }
                break;
        case NSStreamEventEndEncountered:;
            istream = (NSInputStream *)aStream;
            oStream = nil;
            if (CFDictionaryGetValueIfPresent(connections, istream, (const void **)&oStream)) {
                [self shutdownInputStream:istream outputStream:oStream];
            }
                break;
         
        case NSStreamEventHasSpaceAvailable:
        case NSStreamEventErrorOccurred:
        {
            NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
            //[nc postNotificationName:netErr object:self];
            //[winConErr openErr:@"Network error"];
           // [self closeConn];
            break;
        }
        case NSStreamEventOpenCompleted:
        case NSStreamEventNone:
        default:
            break;
    }
}

-(void)sendRemote:(NSString *)stringToSend
{
    oStream = (NSOutputStream *)CFDictionaryGetValue(connections, iStream);
    NSData * dataToSend = [stringToSend dataUsingEncoding:NSASCIIStringEncoding];
    if (oStream) {
        int remainingToWrite = [dataToSend length];
        void * marker = (void *)[dataToSend bytes];
        [oStream write:marker maxLength:remainingToWrite];
        /*
        while ( 0 <remainingToWrite)
        {
            int actuallyWritten = 0;
            actuallyWritten = [oStream write:marker maxLength:remainingToWrite];
            remainingToWrite -= actuallyWritten;
            marker += actuallyWritten;
        }
        */
        NSLog(@"send text: %@",stringToSend);
    }
}

-(void)dealloc
{
    [content release];
    [iStream release];
    [oStream release];
    [super dealloc];
}

@synthesize content;
@synthesize iStream;
@synthesize oStream;

@end