//
//  ViewController.m
//  JBWatchActivityIndicator
//
//  Created by Michael Swanson on 5/3/15.
//  Copyright (c) 2015 Michael Swanson. All rights reserved.
//

#import "ViewController.h"
#import "JBWatchActivityIndicator.h"
#import "DoubleIndicator.h"
static NSString * const kDefaultImagePrefix = @"Activity";

@interface ViewController ()

@property (nonatomic, readwrite, weak)      IBOutlet    UIImageView                 *imageView;
@property (nonatomic, readwrite, weak)      IBOutlet    UISegmentedControl          *styleSegmentedControl;
@property (nonatomic, readwrite, weak)      IBOutlet    UIStepper                   *segmentsStepper;
@property (nonatomic, readwrite, weak)      IBOutlet    UILabel                     *segmentsLabel;
@property (nonatomic, readwrite, weak)      IBOutlet    UIStepper                   *segmentRadiusStepper;
@property (nonatomic, readwrite, weak)      IBOutlet    UILabel                     *segmentRadiusLabel;
@property (nonatomic, readwrite, weak)      IBOutlet    UILabel                     *strokeSpacingTitleLabel;
@property (nonatomic, readwrite, weak)      IBOutlet    UIStepper                   *strokeSpacingStepper;
@property (nonatomic, readwrite, weak)      IBOutlet    UILabel                     *strokeSpacingLabel;
@property (nonatomic, readwrite, weak)      IBOutlet    UIStepper                   *indicatorRadiusStepper;
@property (nonatomic, readwrite, weak)      IBOutlet    UILabel                     *indicatorRadiusLabel;
@property (nonatomic, readwrite, weak)      IBOutlet    UIStepper                   *framesStepper;
@property (nonatomic, readwrite, weak)      IBOutlet    UILabel                     *framesLabel;
@property (nonatomic, readwrite, weak)      IBOutlet    UIStepper                   *indicatorScaleStepper;
@property (nonatomic, readwrite, weak)      IBOutlet    UILabel                     *indicatorScaleLabel;
@property (nonatomic, readwrite, weak)      IBOutlet    UIStepper                   *brightestAlphaStepper;
@property (nonatomic, readwrite, weak)      IBOutlet    UILabel                     *brightestAlphaLabel;
@property (nonatomic, readwrite, weak)      IBOutlet    UIStepper                   *darkestAlphaStepper;
@property (nonatomic, readwrite, weak)      IBOutlet    UILabel                     *darkestAlphaLabel;
@property (nonatomic, readwrite, weak)      IBOutlet    UIStepper                   *durationStepper;
@property (nonatomic, readwrite, weak)      IBOutlet    UILabel                     *durationLabel;
@property (nonatomic, readwrite, weak)      IBOutlet    UITextField                 *imagePrefixTextField;
@property (nonatomic, readwrite, weak)      IBOutlet    UILabel                     *totalImageBytesLabel;
@property (nonatomic, readwrite, strong)                JBWatchActivityIndicator    *watchActivityIndicator;
@property (nonatomic, readwrite, strong)                DoubleIndicator             *doubleIndicator;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.totalImageBytesLabel.text = @"";

    //[self applyType:JBWatchActivityIndicatorTypeRingDevide];
    [self testdoubleRing];
}

- (void)testdoubleRing
{
    //self.doubleIndicator = [[DoubleIndicator alloc] init];
    //[self update];

    self.imageView.image = [[[DoubleIndicator alloc] init] animatedImageWithDuration:1.0f];
}

- (void)applyType:(JBWatchActivityIndicatorType)type {
    
    self.watchActivityIndicator = [[JBWatchActivityIndicator alloc] initWithType:type];
    [self initializeControls];
    [self update];
}

- (void)initializeControls {
    
    self.styleSegmentedControl.selectedSegmentIndex = self.watchActivityIndicator.segmentStyle;
    self.segmentsStepper.value = self.watchActivityIndicator.numberOfSegments;
    self.segmentRadiusStepper.value = self.watchActivityIndicator.segmentRadius;
    self.indicatorRadiusStepper.value = self.watchActivityIndicator.indicatorRadius;
    self.framesStepper.value = self.watchActivityIndicator.numberOfFrames;
    self.indicatorScaleStepper.value = self.watchActivityIndicator.indicatorScale;
    self.brightestAlphaStepper.value = self.watchActivityIndicator.brightestAlpha;
    self.darkestAlphaStepper.value = self.watchActivityIndicator.darkestAlpha;
    self.durationStepper.value = 1.0f;
    self.imagePrefixTextField.text = kDefaultImagePrefix;
}

- (void)update {
    
    BOOL strokeSpacingEnabled = (self.styleSegmentedControl.selectedSegmentIndex == JBWatchActivityIndicatorSegmentStyleStroke);
    self.strokeSpacingTitleLabel.enabled = strokeSpacingEnabled;
    self.strokeSpacingStepper.enabled = strokeSpacingEnabled;
    self.strokeSpacingLabel.enabled = strokeSpacingEnabled;
    BOOL strokeSpacingWarning = (self.strokeSpacingStepper.value >= (360.0f / self.segmentsStepper.value));
    self.strokeSpacingLabel.textColor = (strokeSpacingWarning ? [UIColor redColor] : [UIColor blackColor]);
    
    self.segmentsLabel.text = [NSString stringWithFormat:@"%.0f", self.segmentsStepper.value];
    self.segmentRadiusLabel.text = [NSString stringWithFormat:@"%.2f", self.segmentRadiusStepper.value];
    self.strokeSpacingLabel.text = [NSString stringWithFormat:@"%.1f°", self.strokeSpacingStepper.value];
    self.indicatorRadiusLabel.text = [NSString stringWithFormat:@"%.2f", self.indicatorRadiusStepper.value];
    self.framesLabel.text = [NSString stringWithFormat:@"%.0f (%.1f fps)", self.framesStepper.value, (self.framesStepper.value / self.durationStepper.value)];
    self.indicatorScaleLabel.text = [NSString stringWithFormat:@"%.2f", self.indicatorScaleStepper.value];
    self.brightestAlphaLabel.text = [NSString stringWithFormat:@"%.2f", self.brightestAlphaStepper.value];
    self.darkestAlphaLabel.text = [NSString stringWithFormat:@"%.2f", self.darkestAlphaStepper.value];
    self.durationLabel.text = [NSString stringWithFormat:@"%.2fs", self.durationStepper.value];
    
    self.imageView.image = [self.watchActivityIndicator animatedImageWithDuration:self.durationStepper.value];
}

#pragma mark - Interaction

- (IBAction)defaultButtonTouched:(UIButton *)sender {

    [self applyType:JBWatchActivityIndicatorTypeDefault];
}

- (IBAction)dotsButtonTouched:(UIButton *)sender {

    [self applyType:JBWatchActivityIndicatorTypeDots];
}

- (IBAction)ringButtonTouched:(UIButton *)sender {

    [self applyType:JBWatchActivityIndicatorTypeRing];
}

- (IBAction)segmentsButtonTouched:(UIButton *)sender {
    
    [self applyType:JBWatchActivityIndicatorTypeSegments];
}

- (IBAction)styleSegmentedControlValueChanged:(UISegmentedControl *)sender {
    
    self.watchActivityIndicator.segmentStyle = (JBWatchActivityIndicatorSegmentStyle)sender.selectedSegmentIndex;
    [self update];
}

- (IBAction)segmentsStepperValueChanged:(UIStepper *)sender {
    
    self.watchActivityIndicator.numberOfSegments = sender.value;
    [self update];
}

- (IBAction)segmentRadiusStepperValueChanged:(UIStepper *)sender {

    self.watchActivityIndicator.segmentRadius = sender.value;
    [self update];
}

- (IBAction)strokeSpacingStepperValueChanged:(UIStepper *)sender {
    
    self.watchActivityIndicator.strokeSpacingDegrees = sender.value;
    [self update];
}

- (IBAction)indicatorRadiusStepperValueChanged:(UIStepper *)sender {
    
    self.watchActivityIndicator.indicatorRadius = sender.value;
    [self update];
}

- (IBAction)framesStepperValueChanged:(UIStepper *)sender {

    self.watchActivityIndicator.numberOfFrames = sender.value;
    [self update];
}

- (IBAction)indicatorScaleStepperValueChanged:(UIStepper *)sender {

    self.watchActivityIndicator.indicatorScale = sender.value;
    [self update];
}

- (IBAction)brightestAlphaStepperValueChanged:(UIStepper *)sender {

    self.watchActivityIndicator.brightestAlpha = sender.value;
    [self update];
}

- (IBAction)darkestAlphaStepperValueChanged:(UIStepper *)sender {

    self.watchActivityIndicator.darkestAlpha = sender.value;
    [self update];
}

- (IBAction)durationStepperValueChanged:(UIStepper *)sender {

    [self update];
}

- (IBAction)outputImageFramesButtonTouched:(UIButton *)sender {
    
    self.view.userInteractionEnabled = NO;
    
    NSArray *images = [self.watchActivityIndicator allImages];
    
    NSUInteger totalImageBytes = 0;
    
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];

    NSString *imagePrefix = (self.imagePrefixTextField.text.length > 0 ? self.imagePrefixTextField.text : kDefaultImagePrefix);
    [self removeFilesForImagePrefix:imagePrefix];
    
    for (NSUInteger frameIndex = 0; frameIndex < images.count; frameIndex++) {
        
        NSString *fileName = [NSString stringWithFormat:@"%@%@@2x.png",
                              imagePrefix,
                              [NSString stringWithFormat:@"%lu", (frameIndex + 1)]];
        NSString *filePath = [documentDirectory stringByAppendingPathComponent:fileName];
        
        NSData *imageData = UIImagePNGRepresentation(images[frameIndex]);
        
        [imageData writeToFile:filePath atomically:NO];
        
        totalImageBytes += imageData.length;
    }

    self.totalImageBytesLabel.text = [NSString stringWithFormat:@"Wrote %lu total image bytes", totalImageBytes];
    NSLog(@"Wrote %lu image frames to %@ with %lu total bytes", images.count, documentDirectory, totalImageBytes);
    
    self.view.userInteractionEnabled = YES;
}

- (void)removeFilesForImagePrefix:(NSString *)imagePrefix {
    
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSMutableArray *files = [NSMutableArray arrayWithArray:[fileManager
                                                            contentsOfDirectoryAtPath:documentDirectory
                                                            error:NULL]];

    for (NSString *file in files) {
        
        if ([[file substringToIndex:imagePrefix.length] isEqualToString:imagePrefix]) {

            [fileManager removeItemAtPath:[documentDirectory stringByAppendingPathComponent:file] error:NULL];
        }
    }
}

@end
