//
//  ANXImagePickerFacade.h
//  ImagePicker
//
//  Created by Maxim on 10/16/14.
//  Copyright (c) 2014 Max Rozdobudko. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FlashRuntimeExtensions.h"

@interface ANXImagePickerFacade : NSObject

@end

#pragma mark API

FREObject ANXImagePickerIsSupported(FREContext context, void* functionData, uint32_t argc, FREObject argv[]);

FREObject ANXImagePickerBrowse(FREContext context, void* functionData, uint32_t argc, FREObject argv[]);

FREObject ANXImagePickerGetAsset(FREContext context, void* functionData, uint32_t argc, FREObject argv[]);

FREObject ANXImagePickerAssetInputOpen(FREContext context, void* functionData, uint32_t argc, FREObject argv[]);

FREObject ANXImagePickerAssetInputClose(FREContext context, void* functionData, uint32_t argc, FREObject argv[]);

FREObject ANXImagePickerAssetInputGetSize(FREContext context, void* functionData, uint32_t argc, FREObject argv[]);

FREObject ANXImagePickerAssetInputReadBytes(FREContext context, void* functionData, uint32_t argc, FREObject argv[]);

#pragma mark ContextInitializer/ContextFinalizer

void ANXImagePickerContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet);

void ANXImagePickerContextFinalizer(FREContext ctx);

#pragma mark Initializer/Finalizer

void ANXImagePickerInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet);

void ANXImagePickerFinalizer(void* extData);