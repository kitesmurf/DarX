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
#import "ManagingViewController.h"
#import "PreferenceController.h"
#import "CheckOutCalc.h"

@class ManagingViewController;
@interface DarX_AppDelegate : NSPersistentDocument 
{
    NSWindow *window;
    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
	
	//own
	
	PreferenceController *prefController;
    CheckOutCalc *checkOutCalculator;
	
	IBOutlet NSPopUpButton *playerButton;
	IBOutlet NSBox *box;
	NSMutableArray *viewControllers;
	
}

@property (nonatomic, retain) IBOutlet NSWindow *window;

@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveAction:sender;

//own
-(IBAction)showPreferencePanel:(id)sender;
-(IBAction)showCheckOutCalculator:(id)sender;
-(IBAction)changeViewController:(id)sender;
-(void)displayViewController:(ManagingViewController *)vc;

@end
