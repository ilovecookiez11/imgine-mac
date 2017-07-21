//
//  Services.m
//  imgine-mac
//
//  Created by yelyah on 7/19/17.
//  Copyright © 2017 yelyah. All rights reserved.
//

#import "Services.h"
#import "MLIMGURUploader.h"

@implementation Services

-(void)googleServiceHandler:(NSPasteboard*)pboard userData:(NSString*)userData error:(NSString**)err{
    
    if([[pboard types] containsObject:NSFilenamesPboardType]){
        NSArray* fileArray=[pboard propertyListForType:NSFilenamesPboardType];
        NSLog(@"fileArray:%@",fileArray);
        
        //[[NSApp windows] makeObjectsPerformSelector:@selector(hide)];
        [genericUploadWindow makeKeyAndOrderFront:self];
        
        NSURL *myFileURL = [NSURL fileURLWithPath:[fileArray objectAtIndex:0]];
        
        NSData *image = [NSData dataWithContentsOfURL:myFileURL];
        
        [MLIMGURUploader uploadPhoto:image
                               title:nil
                         description:nil
                       imgurClientID:@"32ea9cecdcd5fda"
                     completionBlock:^(NSString *result) {
                         //NSLog(@"%@", result);
                         
                         NSString *searchResult = @"https://www.google.com/searchbyimage?image_url=";
                         
                         result = [searchResult stringByAppendingString:result];
                         
                         [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:result]];
                         [NSApp terminate:self];
                         
                     }
                        failureBlock:^(NSURLResponse *response, NSError *error, NSInteger status){
                            [appErrorWindow makeKeyAndOrderFront:self];
                        }];
    }
    
}

-(void)uploadServiceHandler:(NSPasteboard*)pboard userData:(NSString*)userData error:(NSString**)err{
    
    if([[pboard types] containsObject:NSFilenamesPboardType]){
        NSArray* fileArray=[pboard propertyListForType:NSFilenamesPboardType];
        NSLog(@"fileArray:%@",fileArray);
        
        //[[NSApp windows] makeObjectsPerformSelector:@selector(hide)];
        [genericUploadWindow makeKeyAndOrderFront:self];
        
        NSURL *myFileURL = [NSURL fileURLWithPath:[fileArray objectAtIndex:0]];
        
        NSData *image = [NSData dataWithContentsOfURL:myFileURL];
        
        [MLIMGURUploader uploadPhoto:image
                               title:nil
                         description:nil
                       imgurClientID:@"32ea9cecdcd5fda"
                     completionBlock:^(NSString *result) {
                         //NSLog(@"%@", result);
                         
                         [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:result]];
                         [NSApp terminate:self];
                     }
                        failureBlock:^(NSURLResponse *response, NSError *error, NSInteger status){
                            [appErrorWindow makeKeyAndOrderFront:self];
                        }];
    }
    
}

@end
