//
//  ANXImagePickerAssetInput.h
//  ImagePicker
//
//  Created by Maxim on 10/16/14.
//  Copyright (c) 2014 Max Rozdobudko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AssetsLibrary/AssetsLibrary.h>

#import "FlashRuntimeExtensions.h"

@interface ANXImagePickerAssetInput : NSObject

#pragma mark Constructor

-(id) initWithAsset:(ALAsset *)asset;

#pragma mark properties

@property(readonly) ALAsset *asset;

#pragma mark methods

-(long long) getSize;

-(void) readBytes: (FREObject) bytes fromOffset: (long long) offset desiredLength: (NSUInteger) length;

@end
