//
//  UploadWindowController.h
//  imgine-mac
//
//  Created by yelyah on 7/2/17.
//  Copyright © 2017 yelyah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>

@interface UploadWindowController : NSImageView {
    IBOutlet NSButton *googleSearch;
    IBOutlet NSButton *upload;
    IBOutlet id uploadSheet;
    IBOutlet id uploadWindow;
    IBOutlet id errorWindow;
    IBOutlet id fileLabel;
    IBOutlet id filenameLabel;
    IBOutlet NSProgressIndicator *progressBar;
    IBOutlet id myImageView;   
}

- (IBAction)filePicker:(id)sender;
- (IBAction)uploadButton:(id)sender;
- (IBAction)googleSearchButton:(id)sender;
- (IBAction)droppedImage:(id)sender;


@property NSURL *theURL;
@property (strong, retain) NSString *resultString;

@end
