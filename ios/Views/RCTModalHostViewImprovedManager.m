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
          withViewController:(RCTModalHostViewController *)viewController
                    animated:(BOOL)animated
{
  dispatch_block_t completionBlock = ^{
    if (modalHostView.onShow) {
      modalHostView.onShow(nil);
    }
  };
  dispatch_async(dispatch_get_main_queue(), ^{
    if (super.presentationBlock) {
      super.presentationBlock([modalHostView reactViewController], viewController, animated, completionBlock);
    } else {
      UIViewController* presentingViewController;
      // pageSheet and formSheet presentation style animate the presented view so we need to use the last presented view controller
      // For other presentation styles we use the new window
      if (modalHostView.presentationStyle == UIModalPresentationPageSheet || modalHostView.presentationStyle == UIModalPresentationFormSheet) {
        UIViewController *lastPresentedViewController = RCTKeyWindow().rootViewController;
        UIViewController *presentedViewController = nil;
        while (lastPresentedViewController != nil) {
          presentedViewController = lastPresentedViewController;
          lastPresentedViewController = lastPresentedViewController.presentedViewController;
        }
        presentingViewController = presentedViewController;
      } else {
        modalHostView.modalWindow = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        modalHostView.modalWindow.windowLevel = UIWindowLevelAlert;
        UIViewController *newViewController = [[UIViewController alloc] init];
        modalHostView.modalWindow.rootViewController = newViewController;
        [modalHostView.modalWindow makeKeyAndVisible];
        presentingViewController = newViewController;
      }
      [presentingViewController presentViewController:viewController animated:animated completion:completionBlock];
    }
  });
}


- (void)dismissModalHostViewWithCompletion:(RCTModalHostViewImproved *)modalHostView
                        withViewController:(RCTModalHostViewControllerImproved *)viewController
                                  animated:(BOOL)animated completion:(void (^)(void))completion
{
  dispatch_block_t completionBlock = ^{
    if (modalHostView.identifier) {
      [[self.bridge moduleForClass:[RCTModalManager class]] modalDismissed:modalHostView.identifier];
    }
    if (completion) {
      completion();
    }
    modalHostView.modalWindow = nil;
  };
  dispatch_async(dispatch_get_main_queue(), ^{
    if (super.dismissalBlock) {
      super.dismissalBlock([modalHostView reactViewController], viewController, animated, completionBlock);
    } else {
      // Will be true for pageSheet and formSheet presentation styles
      // We dismiss the nested modal and then dismiss the current modal
      if (viewController.presentedViewController != nil && [viewController.presentedViewController isKindOfClass:[RCTModalHostViewController class]]) {
        RCTModalHostViewControllerImproved* presentedModalViewController = (RCTModalHostViewControllerImproved *)viewController.presentedViewController;
        dispatch_block_t childModalCompletionBlock = ^{
          [viewController.presentingViewController dismissViewControllerAnimated:animated completion:completionBlock];
        };


        [presentedModalViewController.modalHostView dismissModalViewControllerWithCompletion: childModalCompletionBlock];
      } else {
        [viewController.presentingViewController dismissViewControllerAnimated:animated completion:completionBlock];
      }
    }
  });
}

/* Over-ride this method to add custom shadow view
- (RCTShadowView *)shadowView
{
  return [RCTModalHostShadowView new];
}
*/

@end
