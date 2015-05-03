JBWatchActivityIndicator
========================

By [Mike Swanson](http://blog.mikeswanson.com/)

Unfortunately, the current version of WatchKit doesn't include an activity indicator control (like UIKit's _UIActivityIndicatorView_), even though the Apple Watch displays an indicator while our interface controllers are loading.

One common approach is to use a _WKInterfaceImage_ object to display an animation while a long-running task is executing. The biggest challenge is finding a series of Apple-like images to animate.

I created _JBWatchActivityIndicator_ to make it easier to configure and generate a series of images.

If you'd just like to grab some Apple-like images, check out the [Common Images](https://github.com/mikeswanson/JBWatchActivityIndicator/tree/master/Common%20Images) folder.

Here's an example from the included project that shows some of the attributes that can be interactively modified.

![JBWatchActivityIndicator Example](http://www.mikeswanson.com/files/JBWatchActivityIndicator/JBWatchActivityIndicator.gif)

After you've designed a look that you like, tap the _Output Image Frames_ button, and you'll find a series of properly-named PNG images in the document directory (which will be logged during export to make it easy to copy-and-paste the path into the Finder). 

## Usage

To use the exported image sequence, first copy the numbered files to the bundle of your WatchKit app (not your WatchKit extension). I'd highly recommend putting them in an assets library.

Then, to animate the images from your WatchKit extension:

        // Animate a series of images prefixed with the string "Activity"
        [self.interfaceImage setImageNamed:@"Activity"];
        [self.interfaceImage startAnimatingWithImagesInRange:NSMakeRange(0, 15)
                                                    duration:1.0
                                                 repeatCount:0];

To stop the animation:

    	[self.interfaceImage stopAnimating];
    
That's it.

While this project is primarily intended to create image files that are included in your app bundle, you can alternately use the _JBWatchActivityIndicator_ class to generate image sequences on-the-fly for direct use on the Watch.

Enjoy!