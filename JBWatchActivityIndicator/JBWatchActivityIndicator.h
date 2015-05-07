//
//  JBWatchActivityIndicator.h
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JBWatchActivityIndicatorType) {
    
    JBWatchActivityIndicatorTypeDefault,
    JBWatchActivityIndicatorTypeDefaultSmall,
    JBWatchActivityIndicatorTypeDefaultLarge,
    JBWatchActivityIndicatorTypeDots,
    JBWatchActivityIndicatorTypeDotsSmall,
    JBWatchActivityIndicatorTypeDotsLarge,
    JBWatchActivityIndicatorTypeRing,
    JBWatchActivityIndicatorTypeRingSmall,
    JBWatchActivityIndicatorTypeRingLarge,
    JBWatchActivityIndicatorTypeSegments,
    JBWatchActivityIndicatorTypeSegmentsSmall,
    JBWatchActivityIndicatorTypeSegmentsLarge
};

typedef NS_ENUM(NSInteger, JBWatchActivityIndicatorSegmentStyle) {
    
    JBWatchActivityIndicatorSegmentStyleCircle,
    JBWatchActivityIndicatorSegmentStyleStroke
};

@interface JBWatchActivityIndicator : NSObject

@property (nonatomic, readwrite, assign)    JBWatchActivityIndicatorSegmentStyle    segmentStyle;
@property (nonatomic, readwrite, assign)    NSUInteger                              numberOfSegments;
@property (nonatomic, readwrite, assign)    CGFloat                                 segmentRadius;
@property (nonatomic, readwrite, assign)    CGFloat                                 strokeSpacingDegrees;
@property (nonatomic, readwrite, assign)    CGFloat                                 indicatorRadius;
@property (nonatomic, readwrite, assign)    CGFloat                                 brightestAlpha;
@property (nonatomic, readwrite, assign)    CGFloat                                 darkestAlpha;
@property (nonatomic, readwrite, assign)    CGFloat                                 numberOfFrames;
@property (nonatomic, readwrite, assign)    CGFloat                                 indicatorScale;

- (instancetype)initWithType:(JBWatchActivityIndicatorType)type NS_DESIGNATED_INITIALIZER;

- (UIImage *)animatedImageWithDuration:(NSTimeInterval)duration;
- (NSArray *)allImages;
- (UIImage *)imageForFrameAtIndex:(NSUInteger)frameIndex;

@end
