//
//  ImagePicker.h
//  ImagePicker
//
//  Created by Maxim on 10/16/14.
//  Copyright (c) 2014 Max Rozdobudko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "FlashRuntimeExtensions.h"

#import "ANXImagePickerAsset.h"

#import "ANXImagePickerAssetInput.h"

@interface ANXImagePicker : NSObject<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

#pragma mark Shared Instance

+(ANXImagePicker*) sharedInstance;

#pragma mark Properties

@property FREContext context;

#pragma mark API Funcitons

-(BOOL) isSupported;

-(BOOL) browse: (NSDictionary*) options;

#pragma mark API Funcitons: Asset

-(ANXImagePickerAsset*) getAsset: (NSString*) urlString;

#pragma mark API Funcitons: AssetInput

-(void) openAssetInput: (NSString*) url;

-(void) closeAssetInput: (NSString*) url;

-(ANXImagePickerAssetInput*) getAssetInput: (NSString*) url;

#pragma mark Dispatch events

-(void) dispatch: (NSString *) code withLevel: (NSString *) level;

-(void) dispatchError: (NSString *)code;

-(void) dispatchStatus: (NSString *)code;

@end
