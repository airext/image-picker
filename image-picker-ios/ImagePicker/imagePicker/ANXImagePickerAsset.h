//
//  ANXImagePickerAsset.h
//  ImagePicker
//
//  Created by Maxim on 10/16/14.
//  Copyright (c) 2014 Max Rozdobudko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AssetsLibrary/AssetsLibrary.h>

#import "FlashRuntimeExtensions.h"

@interface ANXImagePickerAsset : NSObject

#pragma mark Constructor

-(id) initWithAsset:(ALAsset *)asset andURL: (NSURL*) url;

#pragma mark methods

-(FREObject) toFREObject;

@end
