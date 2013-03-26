//
//  ImageToDataTransformer.m
//  BombaJob
//
//  Created by supudo on 3/25/13.
//  Copyright (c) 2013 supudo.net. All rights reserved.
//

#import "ImageToDataTransformer.h"

@implementation ImageToDataTransformer

+ (BOOL)allowsReverseTransformation {
    return YES;
}

+ (Class)transformedValueClass {
    return [NSData class];
}

- (id)transformedValue:(id)value {
    NSBitmapImageRep *rep = [[value representations] objectAtIndex: 0];
    NSData *data = [rep representationUsingType:NSPNGFileType properties:nil];
    return data;
}

- (id)reverseTransformedValue:(id)value {
    NSImage *uiImage = [[NSImage alloc] initWithData:value];
    return uiImage;
}

@end