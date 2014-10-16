//
//  ANXImagePickerAssetInput.m
//  ImagePicker
//
//  Created by Maxim on 10/16/14.
//  Copyright (c) 2014 Max Rozdobudko. All rights reserved.
//

#import "ANXImagePickerAssetInput.h"

#import "ANXImagePicker.h"

@implementation ANXImagePickerAssetInput

#pragma mark Constructor

-(id)initWithAsset:(ALAsset *)asset
{
    self = [super init];
    
    if (self)
    {
        _asset = asset;
    }
    
    return self;
}

#pragma mark properties

@synthesize asset = _asset;

#pragma mark methods

-(long long) getSize
{
    ALAssetRepresentation *representation = [self.asset defaultRepresentation];
    
    return representation.size;
}

-(void) readBytes: (FREObject) bytes fromOffset: (long long) offset desiredLength: (NSUInteger) length
{
    ALAssetRepresentation *representation = [self.asset defaultRepresentation];
    
    uint8_t *buffer = malloc(length);
    
    NSError *error;
    
    NSUInteger actualLength = [representation getBytes:buffer fromOffset:offset length:length error:&error];
    
    if (error != nil)
    {
        [[ANXImagePicker sharedInstance] dispatch:@"ImagePicker.AssetInput.ReadBytes.Failed" withLevel: error.localizedDescription];
        
        free(buffer);
        
        return;
    }
    
    FREResult result;
    
    FREObject size;
    result = FRENewObjectFromUint32((uint32_t) actualLength, &size);
    
    if (result != FRE_OK)
    {
        [[ANXImagePicker sharedInstance] dispatchError:@"ImagePicker.AssetInput.ReadBytes.Failed"];
        
        free(buffer);
        
        return;
    }
    
    result = FRESetObjectProperty(bytes, (const uint8_t *) "length", size, NULL);
    
    if (result != FRE_OK)
    {
        [[ANXImagePicker sharedInstance] dispatchError:@"ImagePicker.AssetInput.ReadBytes.Failed"];
        
        free(buffer);
        
        return;
    }
    
    FREByteArray container;
    result = FREAcquireByteArray(bytes, &container);
    
    if (result != FRE_OK)
    {
        [[ANXImagePicker sharedInstance] dispatchError:@"ImagePicker.AssetInput.ReadBytes.Failed"];
        
        FREReleaseByteArray(bytes);
        
        free(buffer);
        
        return;
    }
    
    memcpy(container.bytes, buffer, actualLength);
    
    free(buffer);
    
    FREReleaseByteArray(bytes);

}

@end
