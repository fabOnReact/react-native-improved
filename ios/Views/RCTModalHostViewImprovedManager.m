/*
 * @see https://github.com/fabriziobertoglio1987/react-native-improved
 *
 * @author Fabrizio Bertoglio https://github.com/fabriziobertoglio1987
 */

#import "RCTModalHostViewImprovedManager.h"
#import "RCTModalHostViewControllerImproved.h"
#import "RCTModalHostViewImproved.h"
#import "RCTShadowView.h"
#import "RCTModalManager.h"
#import "RCTModalHostViewManager.h"

@interface RCTModalHostViewImprovedManager () <RCTModalHostViewInteractorImproved>

@end

@implementation RCTModalHostViewImprovedManager {
  NSPointerArray *_hostViews;
}

RCT_EXPORT_MODULE()

- (UIView *)view
{
  [super view];
  RCTModalHostViewImproved *view = [[RCTModalHostViewImproved alloc] initWithBridge:self.bridge];
  view.delegate = self;
  if (!_hostViews) {
    _hostViews = [NSPointerArray weakObjectsPointerArray];
  }
  [_hostViews addPointer:(__bridge void *)view];
  return view;
}

- (void)presentModalHostView:(RCTModalHostViewImproved *)modalHostView
          withViewController:(RCTModalHostViewControllerImproved *)viewController
                    animated:(BOOL)animated
{
  dispatch_block_t completionBlock = ^{
    if (modalHostView.onShow) {
      modalHostView.onShow(nil);
    }
  };

  dispatch_async(dispatch_get_main_queue(), ^{
    if (self.presentationBlock) {
      self.presentationBlock([modalHostView reactViewController], viewController, animated, completionBlock);
    } else {
      [[modalHostView reactViewController] presentViewController:viewController
                                                        animated:animated
                                                      completion:completionBlock];
    }
  });
}

- (void)dismissModalHostView:(RCTModalHostViewImproved *)modalHostView
          withViewController:(RCTModalHostViewControllerImproved *)viewController
                    animated:(BOOL)animated
{
  dispatch_block_t completionBlock = ^{
    if (modalHostView.identifier) {
      [[self.bridge moduleForClass:[RCTModalManager class]] modalDismissed:modalHostView.identifier];
    }
  };

  dispatch_async(dispatch_get_main_queue(), ^{
    if (self.dismissalBlock) {
      self.dismissalBlock([modalHostView reactViewController], viewController, animated, completionBlock);
    } else {
      [viewController.presentingViewController dismissViewControllerAnimated:animated completion:completionBlock];
    }
  });
}

- (void)invalidate
{
  for (RCTModalHostView *hostView in _hostViews) {
    [hostView invalidate];
  }
  _hostViews = nil;
}

@end
