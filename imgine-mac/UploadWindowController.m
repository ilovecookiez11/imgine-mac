//
//  UploadWindowController.m
//  imgine-mac
//
//  Created by yelyah on 7/2/17.
//  Copyright © 2017 yelyah. All rights reserved.
//

#import "UploadWindowController.h"
#import "MLIMGURUploader.h"

@implementation UploadWindowController


- (IBAction)filePicker:(id)sender{
    NSArray *filetypes = [NSArray arrayWithObjects:@"jpg", @"jpeg", @"png", @"gif", @"tif", @"tiff", @"apng", @"bmp", @"pdf", @"xcf", @"webp", nil];
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    [openPanel setTitle:@"Choose a File"];
    [openPanel setAllowedFileTypes:filetypes];
    [openPanel setCanChooseDirectories:NO];
    
    if ([openPanel runModal] == NSOKButton){
        _theURL = [openPanel URL];
        
        NSImage *thumbnail = [[NSImage alloc] initWithContentsOfURL:_theURL];
        [myImageView setImage:thumbnail];
        
        [fileLabel setStringValue:@"File selected:"];
        [filenameLabel setStringValue:[_theURL lastPathComponent]];
        
        //[uploadWindow display];
        
        NSLog(@"nsurl picked: %@", _theURL);
        googleSearch.enabled = YES;
        upload.enabled = YES;
    }

}

- (IBAction)uploadButton:(id)sender{
    
    NSData *image = [NSData dataWithContentsOfURL:_theURL];
    NSLog(@"nsurl picked: %@", _theURL);
    
    [fileLabel setStringValue:[[@"Uploading " stringByAppendingString:[_theURL lastPathComponent]] stringByAppendingString:@"..."]];

    
    [uploadSheet setPreventsApplicationTerminationWhenModal:NO];
    [progressBar animate:NULL];
    [uploadSheet display];
    [NSApp beginSheet:uploadSheet
       modalForWindow:uploadWindow
        modalDelegate:self
       didEndSelector:NULL
          contextInfo:nil];
    
    [MLIMGURUploader uploadPhoto:image
                           title:nil
                     description:nil
                   imgurClientID:@"32ea9cecdcd5fda"
                 completionBlock:^(NSString *result) {
                     NSLog(@"%@", result);
                     [uploadSheet orderOut:nil];
                     [NSApp endSheet:uploadSheet];
        [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:[result stringByReplacingOccurrencesOfString:@"http://" withString:@"https://"]]];
    }
                    failureBlock:^(NSURLResponse *response, NSError *error, NSInteger status){
                        [errorWindow display];
                    }];
}


- (IBAction)googleSearchButton:(id)sender{
    NSData *image = [NSData dataWithContentsOfURL:_theURL];
    
    [fileLabel setStringValue:[[@"Uploading and searching " stringByAppendingString:[_theURL lastPathComponent]] stringByAppendingString:@"..."]];
    
    NSLog(@"%@", [fileLabel stringValue]);
    
    [uploadSheet setPreventsApplicationTerminationWhenModal:NO];
    //[progressBar animate:NULL];
    [uploadSheet display];
    [NSApp beginSheet:uploadSheet
       modalForWindow:uploadWindow
        modalDelegate:self
       didEndSelector:NULL
          contextInfo:nil];
    
    
    [MLIMGURUploader uploadPhoto:image
                           title:nil
                     description:nil
                   imgurClientID:@"32ea9cecdcd5fda"
                 completionBlock:^(NSString *result) {
                     //NSLog(@"%@", result);
                     [uploadSheet orderOut:nil];
                     [NSApp endSheet:uploadSheet];
                     NSString *searchResult = @"https://www.google.com/searchbyimage?image_url=";
                     
                     result = [searchResult stringByAppendingString:result];
                     
                     [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:result]];
                 }
                    failureBlock:^(NSURLResponse *response, NSError *error, NSInteger status){
                        [errorWindow display];
                    }];
    
}


#pragma mark - performDragOperation

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender {
    
    BOOL acceptsDrag = [super performDragOperation:sender];
  
    return acceptsDrag;
}


- (void) delete:(id)sender {
}

- (void) cut:(id)sender {
}

- (IBAction)droppedImage:(id)sender {
    
    NSImage *myImage = [sender image];
    //doing some juggling to convert NSImage to JPEG
    NSData *tiffData = [myImage TIFFRepresentationUsingCompression:NSTIFFCompressionLZW factor:6];
    NSBitmapImageRep *bitmap = [NSBitmapImageRep imageRepWithData:tiffData];
    NSNumber *factor = [NSNumber numberWithFloat: 0.5];
    NSDictionary *props = [NSDictionary dictionaryWithObject:factor forKey:NSImageCompressionFactor];
    NSData *pngData = [bitmap representationUsingType:NSPNGFileType properties:props];
    
    
    NSFileManager* fileManager = [[NSFileManager alloc] init];
    NSString *tempPath = [NSTemporaryDirectory() stringByAppendingString:@"image.png"];
    
    
    
    [fileManager createFileAtPath:tempPath contents:pngData attributes:nil];
    
    NSURL *tempURL = [NSURL fileURLWithPath:tempPath];
    
    _theURL = tempURL;
    
    [fileLabel setStringValue:@" "];
    [filenameLabel setStringValue:@"Acquired image via drag and drop. Image will be uploaded as PNG."];
    googleSearch.enabled = YES;
    upload.enabled = YES;
    
}


@end
