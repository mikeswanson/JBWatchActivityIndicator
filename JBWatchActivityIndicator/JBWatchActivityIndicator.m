//
//  JBWatchActivityIndicator.m
//
//  Created by Mike Swanson on 5/3/2015
//  Copyright (c) 2015 Mike Swanson. All rights reserved.
//  http://blog.mikeswanson.com
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "JBWatchActivityIndicator.h"

static const double PI2 = M_PI * 2.0;

@interface JBWatchActivityIndicator ()

@end

@implementation JBWatchActivityIndicator

#pragma mark - Object management

- (instancetype)init {
    
    return [self initWithType:JBWatchActivityIndicatorTypeDefault];
}

- (instancetype)initWithType:(JBWatchActivityIndicatorType)type {

    self = [super init];
    if (self) {

        _indicatorRadius = 10.0f;
        _brightestAlpha = (254.0f / 255.0f);
        _darkestAlpha = (57.0f / 255.0f);
        _numberOfFrames = 15;

        switch (type) {
                
            case JBWatchActivityIndicatorTypeDefault:
            case JBWatchActivityIndicatorTypeDefaultSmall:
            case JBWatchActivityIndicatorTypeDefaultLarge: {
                
                _numberOfSegments = 6;
                _segmentRadius = 4.25f;
                _indicatorScale = (type == JBWatchActivityIndicatorTypeDefault ? 1.0f :
                                   (type == JBWatchActivityIndicatorTypeDefaultSmall ? 0.5f : 2.0f));
                break;
            }
            case JBWatchActivityIndicatorTypeDots:
            case JBWatchActivityIndicatorTypeDotsSmall:
            case JBWatchActivityIndicatorTypeDotsLarge: {
                
                _numberOfSegments = 10;
                _segmentRadius = 2.5f;
                _indicatorScale = (type == JBWatchActivityIndicatorTypeDots ? 1.0f :
                                   (type == JBWatchActivityIndicatorTypeDotsSmall ? 0.5f : 2.0f));
                break;
            }
            case JBWatchActivityIndicatorTypeRing:
            case JBWatchActivityIndicatorTypeRingSmall:
            case JBWatchActivityIndicatorTypeRingLarge: {
                
                _numberOfSegments = 60;
                _segmentRadius = 1.0f;
                _indicatorScale = (type == JBWatchActivityIndicatorTypeRing ? 1.0f :
                                   (type == JBWatchActivityIndicatorTypeRingSmall ? 0.5f : 2.0f));
                break;
            }
            default: {
                
                NSAssert(NO, @"Invalid type");
                break;
            }
        }
    }
    return self;
}

#pragma mark - Methods

- (UIImage *)animatedImageWithDuration:(NSTimeInterval)duration {
    
    return [UIImage animatedImageWithImages:[self allImages] duration:duration];
}

- (NSArray *)allImages {
    
    NSMutableArray *images = [NSMutableArray array];
    
    for (NSUInteger frameIndex = 0; frameIndex < self.numberOfFrames; frameIndex++) {
        
        [images addObject:[self imageForFrameAtIndex:frameIndex]];
    }
    
    return [NSArray arrayWithArray:images];
}

- (UIImage *)imageForFrameAtIndex:(NSUInteger)frameIndex {

    // Sizing
    CGFloat imageSize = ceilf(((self.indicatorRadius * 2.0f) + (self.segmentRadius * 2.0f)) * self.indicatorScale);

    // Shading
    CGFloat semiAmplitude = ((self.brightestAlpha - self.darkestAlpha) * 0.5f);
    CGFloat alphaAxis = (self.darkestAlpha + semiAmplitude);
    CGFloat frameAngle = (((CGFloat)frameIndex / (CGFloat)self.numberOfFrames) * PI2);

    // Because we're generating Watch images, use a 2.0 scale factor
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageSize, imageSize), NO, 2.0f);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, (imageSize * 0.5f), (imageSize * 0.5f));
    CGContextScaleCTM(context, self.indicatorScale, self.indicatorScale);
    
    // Offset by half of a segment
    CGFloat angleOffset = (0.5f / (CGFloat)self.numberOfSegments) * PI2;
    
    for (NSUInteger segmentIndex = 0; segmentIndex < self.numberOfSegments; segmentIndex++) {
        
        CGFloat segmentAngle = angleOffset + (((CGFloat)segmentIndex / (CGFloat)self.numberOfSegments) * PI2);
        
        CGPoint segmentCenter = CGPointMake((self.indicatorRadius * cosf(segmentAngle)),
                                            (self.indicatorRadius * sinf(segmentAngle)));
        
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(segmentCenter.x - self.segmentRadius,
                                                                               segmentCenter.y - self.segmentRadius,
                                                                               self.segmentRadius * 2.0f,
                                                                               self.segmentRadius * 2.0f)];
        
        
        CGFloat alphaAngle = (((CGFloat)(self.numberOfSegments - segmentIndex) / (CGFloat)self.numberOfSegments) * PI2);
        CGFloat alpha = alphaAxis + (sinf(frameAngle + alphaAngle) * semiAmplitude);
        
        [[UIColor colorWithWhite:1.0f alpha:alpha] setFill];
        [path fill];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

@end
