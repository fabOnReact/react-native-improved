/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
*
* This source code is licensed under the MIT license found in the
* LICENSE file in the root directory of this source tree.
*/

#import "RCTModalHostViewImprovedManager.h"
#import "RCTModalHostViewControllerImproved.h"
#import "RCTModalHostViewImproved.h"
#import "RCTShadowView.h"
#import "RCTModalManager.h"

@interface RCTModalHostShadowView : RCTShadowView

@end

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
  [[modalHostView reactViewController] presentViewController:viewController
                                                        animated:animated
                                                      completion:completionBlock];
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
  [[modalHostView reactViewController] presentViewController:viewController
                                                    animated:animated
                                                  completion:completionBlock];
}

/**
Over-ride this method to add change the React Native Shadow View for this class.

- (RCTShadowView *)shadowView
{
 return [RCTModalHostShadowViewImproved new];
}
**/

@end
