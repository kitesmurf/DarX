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


#import "Nx012.h"


@implementation Nx012

- (id) init
{
	[super initWithNibName:@"Nx012" bundle:nil];
	[self setTitle:@"Remote x01"];
	
	player = 1;
	won1 = 0;
	won2 = 0;
    set1 = 0;
    set2 = 0;
	[p1 setScore:startScore];
	[p2 setScore:startScore];
    netStack = [[Network alloc]init];
    winServer = [[ServerClientDecide alloc] init];
    winBusy = [[Busy alloc] init];
    
    
	
    NSNotificationCenter *ncThrowChange = [NSNotificationCenter defaultCenter];
    [ncThrowChange addObserver:self
                      selector:@selector(handleThrowChange:)
                          name:netThrowChanged
                        object:nil];
    
    NSNotificationCenter *ncConnectToServer = [NSNotificationCenter defaultCenter];
    [ncConnectToServer addObserver:self
                          selector:@selector(openConn)
                              name:connHost
                            object:nil];
    
    NSNotificationCenter *ncRecievedFromServer = [NSNotificationCenter defaultCenter];
    [ncRecievedFromServer addObserver:self
                             selector:@selector(recievedFromServer)
                                 name:hostSent
                               object:nil];
    
    NSNotificationCenter *ncSetGameCancel = [NSNotificationCenter defaultCenter];
    [ncSetGameCancel addObserver:self
                  selector:@selector(handleSetGameCancel)
                      name:setGameCancel
                    object:nil];
    
    NSNotificationCenter *ncSetGameOK = [NSNotificationCenter defaultCenter];
    [ncSetGameOK addObserver:self
                    selector:@selector(handleSetGameOK)
                        name:setGameOK
                      object:nil];
    
    NSNotificationCenter *ncServerClientDecide = [NSNotificationCenter defaultCenter];
    [ncServerClientDecide addObserver:self
                    selector:@selector(handleServerClientDecide)
                        name:serverClient
                      object:nil];
    
	NSNotificationCenter *ncNetErr = [NSNotificationCenter defaultCenter];
    [ncNetErr addObserver:self
                             selector:@selector(handleNetErr)
                                 name:netErr
                               object:nil];
    
    NSNotificationCenter *ncViewChanged = [NSNotificationCenter defaultCenter];
    [ncViewChanged addObserver:self
                 selector:@selector(handleViewChange)
                     name:viewChanged
                   object:nil];
    
    NSNotificationCenter *ncServerStart = [NSNotificationCenter defaultCenter];
    [ncServerStart addObserver:self
                      selector:@selector(handleServerStart)
                          name:serverStart
                        object:nil];

	
	return self;
	
}


- (int)numberOfRowsInTableView:(NSTableView *)tv
{
	//return [p1.arrayThrow count];
	if (player == 1)
	{
		return [p1.arrayThrow count];
	}
	else if (player == 2)
	{
		return [p2.arrayThrow count];
	}
	return 0;
}

- (id)tableView:(NSTableView *)tv
objectValueForTableColumn:(NSTableColumn *)tColumn
			row:(int)row
{
	if (player == 2)
	{
		if ([[tColumn identifier] isEqualToString:@"score"]) {
			NSString *v = [p1.arrayThrow objectAtIndex:row];
			return v;
		}
		else //if ([[tColumn identifier] isEqualToString:@"throws"])
		{
			return [NSString stringWithFormat:@"%d",row+1];
		}
	}
	else if (player == 1)
	{
		if ([[tColumn identifier] isEqualToString:@"score"]) {
			//NSString *v = @"foo";
			NSString *v = [p2.arrayThrow objectAtIndex:row];
			return v;
		}
		else //if ([[tColumn identifier] isEqualToString:@"throws"])
		{
			return [NSString stringWithFormat:@"%d",row+1];
		}
	}
	
	
	return nil;
}


-(IBAction)submit:(id)sender
{
    if (![[fieldScored stringValue] isEqualToString:@""])
    {
        int scored = [fieldScored intValue];
        [netStack sendRemote:[NSString stringWithFormat:@"SCORE|%@|%d ",player2,scored]];
        [self calcScore:scored];        
    }
}


-(void)calcScore:(int)scored
{
	if (player == 1 )
	{
		
		if (scored > p1.score || scored > 180)
		{
			[p1.arrayThrow addObject:[NSString stringWithFormat:@"0"]];
		}
		else
		{
			
			if (scored == p1.score)
			{
				won = 1;
				won1++;
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
		
		
			[p1.arrayThrow addObject:[NSString stringWithFormat:@"%d",scored]];
		}
		[p1.playerScore setStringValue:[NSString stringWithFormat:@"%d",p1.score]];
	
		float liveAve = (float) (startScore - p1.score)  / [p1.arrayThrow count];
		[p1.fieldLiveAve setStringValue:[NSString stringWithFormat:@"%f",liveAve]];
		[tabP1 reloadData];
		[cOut setArrayCheckOut:p2.score];
        [submitButton setEnabled:FALSE];
		player = 2;
	}
	else if (player == 2 )
	{
		if (scored > p2.score || scored > 180)
		{
			[p2.arrayThrow addObject:[NSString stringWithFormat:@"0"]];
		}
		else
		{
			
			
			p2.score -= scored;
			if (scored == 180) {
				[p2 countUp:@"hs180" player:2];
			}
			else if (scored >= 140) {
				[p2 countUp:@"hs140" player:2];
			}
			else if (scored >= 100) {
				[p2 countUp:@"hs100" player:2];
			}
			else if (scored >= 60) {
				[p2 countUp:@"hs60" player:2];
			}
			[p2.arrayThrow addObject:[NSString stringWithFormat:@"%d",scored]];
            
			
		}
		[p2.playerScore setStringValue:[NSString stringWithFormat:@"%d",p2.score]];
		
		float liveAve = (float) (startScore - p2.score)  / [p2.arrayThrow count];
		[p2.fieldLiveAve setStringValue:[NSString stringWithFormat:@"%f",liveAve]];
		[tabP2 reloadData];
		[cOut setArrayCheckOut:p1.score];
        [submitButton setEnabled:TRUE];
		player = 1;
        if (0 == p2.score)
        {
            won = 2;
            won2++;
            winPane.throws = 3;
            [self handleThrowChange:nil];
        }
	}
	

	[fieldScored setStringValue:@""];
	[p1 changePlayerDisp:player];
    [tabP1 scrollRowToVisible:[p1.arrayThrow count]-1];
    [tabP2 scrollRowToVisible:[p2.arrayThrow count]-1];
}

-(int)showWinPane
{
	if (!winPane)
	{
		winPane = [[NetWinPane alloc]init];
	}
	[winPane showWindow:self];
	return winPane.throws;
}

-(void)handleThrowChange:(NSNotification *) note
{
	float aveScore1;
	float aveScore31;
	float aveScore2;
	float aveScore32;
    
	if (won == 1)
	{
		aveScore1 = (float)startScore / ((([p1.arrayThrow count] - 1)*3) + (winPane.throws));
		aveScore31 = (float)startScore / ((([p1.arrayThrow count] - 1)) + (winPane.throws)/3);
	
		aveScore2 = (float)(startScore-p2.score) / [p2.arrayThrow count]/3;
		aveScore32 = (float)(startScore-p2.score) / [p2.arrayThrow count];
		
	}
	else
	{
		aveScore2 = (float)startScore / ((([p2.arrayThrow count] - 1)*3) + (winPane.throws));
		aveScore32 = (float)startScore / ((([p2.arrayThrow count] - 1)) + (winPane.throws)/3);
		
		aveScore1 = (float)(startScore-p1.score) / [p1.arrayThrow count]/3;
		aveScore31 = (float)(startScore-p1.score) / [p1.arrayThrow count];
	}
    
	
	[p1.fieldAveScore setStringValue:[NSString stringWithFormat:@"%f",aveScore1]];
	[p1.fieldAveScore3 setStringValue:[NSString stringWithFormat:@"%f",aveScore31]];
	[p2.fieldAveScore setStringValue:[NSString stringWithFormat:@"%f",aveScore2]];
	[p2.fieldAveScore3 setStringValue:[NSString stringWithFormat:@"%f",aveScore32]];
	[p1 reloadTable];
	[p2 reloadTable];
    if (won1*2 >  bestOf || won2*2 > bestOf)
    {
        if (won == 1)
            set1++;
        else
            set2++;
        
        won1=0;
        won2=0;
        
        if (set1+set2 == sets)
        {
            if (!winGame)
            {
                winGame = [[WinGame alloc]init];
            }
            [winGame open:set1 scorep2:set2];
            set1=0;
            set2=0;
            [self restartG:2];
        }
        [self restartG:0];
    }
    else
        [self restartG:0];
}



-(void)restartG:(int)pref
{
	if (pref == 0) {
		switch (startPlayer) {
			case 1:
				startPlayer = 2;
				player = 2;
                [submitButton setEnabled:FALSE];
				break;
			case 2:
				startPlayer = 1;
				player = 1;
                [submitButton setEnabled:TRUE];
				break;
				
			default:
				startPlayer = 1;
				player = 1;
                [submitButton setEnabled:TRUE];
				break;
		}
	}
	else if (pref == 1) 
    {
        NSLog(@"only shown once");
        [p1 reset];
        [p2 reset];
        [p1 reloadTable];
        [p2 reloadTable];
		player = 1;
        startPlayer = 1;
	}
    else if (pref == 2)
    {
        switch (setStartPlayer) {
            case 1:
                startPlayer = 2;
                player = 2;
                setStartPlayer = 2;
                break;
            case 2:
                startPlayer = 1;
                player = 1;
                setStartPlayer = 1;
                break;
            default:
                startPlayer = 1;
                player = 1;
                setStartPlayer = 1;
                break;
        }
    }

	
	//numPlayers = 2;
	[p1 changePlayerDisp:player];
	[p1.arrayThrow removeAllObjects];
	[p2.arrayThrow removeAllObjects];
	[tabP1 reloadData];
	[tabP2 reloadData];
	[p1 setScore:startScore];
	[p2 setScore:startScore];
	[p1.playerScore setStringValue:[NSString stringWithFormat:@"%d",p1.score]];
	[p2.playerScore setStringValue:[NSString stringWithFormat:@"%d",p2.score]];
	[p1.fieldLiveAve setStringValue:@"-"];
	[p2.fieldLiveAve setStringValue:@"-"];
	

	[fieldScored setStringValue:@""];
	winPane.throws = 0;
	[fieldStats setStringValue:[NSString stringWithFormat:@"%d:%d",won1,won2]];
    [fieldSets setStringValue:[NSString stringWithFormat:@"%d:%d",set1,set2]];
	NSLog(@"ende restartG player %d, startplayer %d",player, startPlayer);
	
}

- (void)awakeFromNib 
{    
    startScore = 501;
    [tabP1 setRefusesFirstResponder:TRUE];
    [tabP2 setRefusesFirstResponder:TRUE];
    [p1 refuseTableHighscore];
    [p2 refuseTableHighscore];
    [cOut refuseTabCheckout];
	[p1.playerScore setStringValue:[NSString stringWithFormat:@"%d",p1.score]];
	[p1 changePlayerDisp:player];
	[p1.fieldAveScore setStringValue:@"-"];
	[p1.fieldAveScore3 setStringValue:@"-"];
	[p2.playerScore setStringValue:[NSString stringWithFormat:@"%d",p2.score]];
	[p2.fieldAveScore setStringValue:@"-"];
	[p2.fieldAveScore3 setStringValue:@"-"];
	[self restartG:0];
    [submitButton setEnabled:FALSE];
    [closeButton setEnabled:FALSE];
    [winServer showWindow:self];
    [[fieldScored window] setInitialFirstResponder:fieldScored];
}

-(void)openConn
{
    NSString *strHost = [winConn hostString];
    [netStack openConn:strHost];
    if (netStack.iStream && netStack.oStream)
    {
        [closeButton setEnabled:TRUE];
        [connectButton setEnabled:FALSE];
    }
}


-(IBAction)closeGame:(id)sender
{
    [self restartGame];
    [netStack sendRemote:@"DISCONNECT| "];
    [netStack closeConn];
    [closeButton setEnabled:FALSE];
    [connectButton setEnabled:TRUE];
}

-(IBAction)connect:(id)sender
{
    if (!isConWinOpen)
    {
        [winServer showWindow:self];
    }
}

-(void)recievedFromServer
{
    
    if (!boolServer) //ist Client
    {
        NSLog(@"ist client");
        NSString *recieved = netStack.content;
        
        NSArray *stringArr;
        stringArr = [recieved componentsSeparatedByString:@"|"];
         
        NSLog(@"recieved: %@",recieved);
        
        if([[NSString stringWithFormat:@"%@",recieved] rangeOfString:@"LISTUSERS"].location != NSNotFound)
        {
            [player2 setString:[[NSString stringWithFormat:@"%@",[stringArr objectAtIndex:2]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
            NSLog(@"setplayer2: %@",player2);
            
            [self insertInChat:[NSString stringWithFormat:@"System: %@ joined\n", player2]];
        }
        else if ([[NSString stringWithFormat:@"%@",recieved] rangeOfString:@"SETGAME"].location != NSNotFound )
        {
            
            //obj0: gegenspieler, obj1: selbst, obj2: wer fängt an, obj3: sätze, obj4: legs
            //Spiel vorbereiten
            NSArray *gameArr = [[stringArr objectAtIndex:1] componentsSeparatedByString:@"~"];
            NSLog(@"startplayer: %@",[gameArr objectAtIndex:2]);
            if ([[NSString stringWithFormat:@"%@",[gameArr objectAtIndex:2]] isEqualToString:[NSString stringWithFormat:@"%@",player1]])
            {
                startPlayer = 2;
            }
            else
            {
                startPlayer = 1;
            }
            bestOf = [[gameArr objectAtIndex:4] intValue];
            sets = [[gameArr objectAtIndex:3] intValue];
            
            if (!winSetGame)
            {
                winSetGame = [[SetGame alloc]init];
            }
            
            [winSetGame showSetGame:bestOf sets:sets startPlayer:[gameArr objectAtIndex:2]];
            [self insertInChat:[NSString stringWithFormat:@"System: Legs: %d, Sets: %d, Startplayer: %@\n", bestOf,sets,[gameArr objectAtIndex:2]]];
            
            
        }
        else if ([[NSString stringWithFormat:@"%@",recieved] rangeOfString:@"SCORE"].location != NSNotFound )
        {
            int p2Score = [[stringArr objectAtIndex:1]intValue];
            if (p2Score <= 180 && p2Score <= p2.score)
            {
                [self calcScore:p2Score];
            }
        }
        else if ([[NSString stringWithFormat:@"%@",recieved] rangeOfString:@"DEADSERVER"].location != NSNotFound )
        {
            [self restartGame];
            if (!winDisco)
            {
                winDisco = [[ServerDisconnect alloc]init];
            }
            [winDisco showWindow:self];
            [netStack closeConn];
            [self insertInChat:[NSString stringWithFormat:@"System: %@ disconnected\n", player2]];
            [closeButton setEnabled:FALSE];
            [connectButton setEnabled:TRUE];
        }
        else if ([[NSString stringWithFormat:@"%@",recieved] rangeOfString:@"CHAT"].location !=NSNotFound )
        {
            [self insertInChat:[NSString stringWithFormat:@"%@: %@",player2,[[recieved componentsSeparatedByString:[NSString stringWithFormat:@"%@:",player2]] objectAtIndex:1]]];
        }
        else if ([[NSString stringWithFormat:@"%@",recieved] rangeOfString:@"BUSY"].location !=NSNotFound )
        {
            [winBusy showWindow:self];
            [self insertInChat:[NSString stringWithFormat:@"System: Server is busy\n"]];
            [netStack closeConn];
            [closeButton setEnabled:FALSE];
        }
        
    }
    else if (boolServer) // ist Server
    {
        NSLog(@"ist server");
        NSString *recieved = server.content;
        
        NSArray *stringArr;
        stringArr = [recieved componentsSeparatedByString:@"|"];
        
        NSLog(@"recieved: %@",recieved);

        if([[NSString stringWithFormat:@"%@",recieved] rangeOfString:@"CONNECT"].location != NSNotFound)
        {
            [player2 setString:[[NSString stringWithFormat:@"%@",[stringArr objectAtIndex:1]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
            NSLog(@"setplayer2: %@",player2);
            
            [server sendRemote:[NSString stringWithFormat:@"JOIN\nLISTUSERS|%@|%@\n",player2,player1]];
            
            [server sendRemote:[NSString stringWithFormat:@"SETGAME|%@~%@~%@~1~3\n",player1,player1,player2]];
            
            [self insertInChat:[NSString stringWithFormat:@"System: %@ joined\n", player2]];
        }
        else if ([[NSString stringWithFormat:@"%@",recieved] rangeOfString:@"SETGAME"].location != NSNotFound )
        {
        
        }
//        [recieved release];
    }
     
}

-(IBAction)chat:(id)sender
{
    NSString *textToSend = [fieldChatOut stringValue];
    if ( textToSend != @"" )
    {
        [self insertInChat:[NSString stringWithFormat:@"%@: %@\n",player1,textToSend]];
        [netStack sendRemote:[NSString stringWithFormat:@"CHAT| %@ ",textToSend]];
        [fieldChatOut setStringValue:@""];
    }
}

-(void)handleSetGameCancel
{
    [netStack sendRemote:[NSString stringWithFormat:@"CANCELGAME|%@| ",player2]];
}

-(void)handleSetGameOK
{
    [netStack sendRemote:[NSString stringWithFormat:@"OKGAME|%@| ",player2]];
    [self restartG:0];
}

-(void)handleNetErr
{
    NSLog(@"neterr");
    [closeButton setEnabled:FALSE];
    [submitButton setEnabled:FALSE];
    [connectButton setEnabled:TRUE];
}

-(void)restartGame
{
    won1=0;
    won2=0;
    set1=0;
    set2=0;
    player=1;
    startPlayer = 0;
    NSLog(@"restartGame");
    [self restartG:1];
}

-(void)handleServerClientDecide
{
    if (boolServer)
    {
        [self startServer:nil];
    }
    else
    {
        if (!winConn)
        {
            winConn = [[Connect alloc]init];
        }
        isConWinOpen = TRUE;
        [winConn showWindow:self];
    }
}

-(void)handleViewChange
{
    if (isConWinOpen)
    {
        [winConn close];
        [winServer close];
        isConWinOpen = FALSE;
    }
}


-(void)insertInChat:(NSString *)stringToInsert
{
    [fieldChatIn setEditable:TRUE];
    [fieldChatIn insertText:stringToInsert];
    [fieldChatIn setEditable:FALSE];
}

-(IBAction)startServer:(id)sender
{
    server = [[Server alloc] init];
    NSError * startError = nil;
    [server setType:@"_cocoaecho._tcp."];
    if (![server start:&startError] ) {
        NSLog(@"Error starting server: %@", startError);
    } else {
        NSLog(@"Starting server on port %d", [server port]);
    }
}

-(void)handleServerStart
{
    //[server sendRemote:[NSString stringWithFormat:@"LISTUSERS"]];
}

-(void)dealloc
{
    [winBusy release];
    [winDisco release];
    [winSetGame release];
    [winConn release];
    [netStack release];
    [winPane release];
    [winGame release];
    [server release];
    
    [super dealloc];
}


@end
