//
//  DoubleIndicator.h
//  Wolaidai
//
//  Created by leon on 15/12/17.
//  Copyright © 2015年 Michael Swanson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface DoubleIndicator : NSObject

@property (nonatomic, readwrite, assign)    NSUInteger                              numberOfSegments;
@property (nonatomic, readwrite, assign)    CGFloat                                 segmentRadius;
@property (nonatomic, readwrite, assign)    CGFloat                                 strokeSpacingDegrees;
@property (nonatomic, readwrite, assign)    CGFloat                                 indicatorRadius;
@property (nonatomic, readwrite, assign)    CGFloat                                 brightestAlpha;
@property (nonatomic, readwrite, assign)    CGFloat                                 darkestAlpha;
@property (nonatomic, readwrite, assign)    CGFloat                                 numberOfFrames;
@property (nonatomic, readwrite, assign)    CGFloat                                 indicatorScale;
@property (nonatomic, readwrite, assign)    BOOL                                    isDevideMode;

- (instancetype)initWithRadius:(CGFloat)radius NS_DESIGNATED_INITIALIZER;

- (UIImage *)animatedImageWithDuration:(NSTimeInterval)duration;

@end
