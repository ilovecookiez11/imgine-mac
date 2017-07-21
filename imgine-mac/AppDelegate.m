//
//  AppDelegate.m
//  imgine-mac
//
//  Created by yelyah on 7/2/17.
//  Copyright © 2017 yelyah. All rights reserved.
//

#import "AppDelegate.h"
#import "MLIMGURUploader.h"
#import "Services.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    Services *serviceHandler = [[Services alloc]init];
    NSRegisterServicesProvider(serviceHandler, @"imgine");
    [NSApp setServicesProvider:serviceHandler];
    [NSApp registerServicesMenuSendTypes:[NSArray arrayWithObjects:@"NSFilenamesPboardType",nil] returnTypes:[NSArray arrayWithObjects:@"0", nil]];
    NSUpdateDynamicServices();
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}



@end
