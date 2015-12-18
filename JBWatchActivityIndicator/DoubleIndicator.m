//
//  DoubleIndicator.m
//  Wolaidai
//
//  Created by leon on 15/12/17.
//  Copyright © 2015年 Michael Swanson. All rights reserved.
//

#import "DoubleIndicator.h"
static const double PI2 = M_PI * 2.0;

@implementation DoubleIndicator

- (instancetype)init {
    return [self initWithRadius:10.f];
}

- (instancetype)initWithRadius:(CGFloat)radius {
    self = [super init];
    if (self) {
        _indicatorRadius = radius;
        _brightestAlpha = (254.0f / 255.0f);
        _darkestAlpha = (57.0f / 255.0f);
        _numberOfFrames = 15;
        _isDevideMode = YES;
        _numberOfSegments = 120;
        _segmentRadius = 1.0f;
        _indicatorScale = 2.0f;//1.0f ;//0.5f

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
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageSize, imageSize), NO, 2.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, (imageSize * 0.5f), (imageSize * 0.5f));
    CGContextScaleCTM(context, self.indicatorScale, self.indicatorScale);
    
    // Offset by half of a segment
    CGFloat angleOffset = (0.5f / (CGFloat)self.numberOfSegments) * PI2;
    for (NSUInteger segmentIndex = 0; segmentIndex < self.numberOfSegments; segmentIndex++) {
        
        NSUInteger alphaIndex = (segmentIndex > self.numberOfSegments/2-1)?(segmentIndex - self.numberOfSegments/2-1):segmentIndex;
        CGFloat alphaAngle = (((CGFloat)(self.numberOfSegments - alphaIndex) / (CGFloat)self.numberOfSegments) * PI2);
        CGFloat alpha = alphaAxis + (sinf(frameAngle + alphaAngle) * semiAmplitude);
        alpha = 1-alpha;
        
        CGFloat segmentAngle = angleOffset + (((CGFloat)segmentIndex / (CGFloat)self.numberOfSegments) * PI2);
        
        CGPoint segmentCenter = CGPointMake((self.indicatorRadius * cosf(segmentAngle)),
                                            (self.indicatorRadius * sinf(segmentAngle)));
        
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(segmentCenter.x - self.segmentRadius,
                                                                               segmentCenter.y - self.segmentRadius,
                                                                               self.segmentRadius * 2.0f,
                                                                               self.segmentRadius * 2.0f)];
        
        [[UIColor colorWithWhite:1.0f alpha:alpha] setFill];
        [path fill];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
