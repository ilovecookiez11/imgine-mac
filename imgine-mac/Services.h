//
//  Services.h
//  imgine-mac
//
//  Created by yelyah on 7/19/17.
//  Copyright © 2017 yelyah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>

@interface Services : NSResponder{
    IBOutlet id appErrorWindow;
    IBOutlet NSWindow *genericUploadWindow;
    IBOutlet id theUploaderWindow;
}

-(void)googleServiceHandler:(NSPasteboard*)pboard userData:(NSString*)userData error:(NSString**)err;
-(void)uploadServiceHandler:(NSPasteboard*)pboard userData:(NSString*)userData error:(NSString**)err;

@end
