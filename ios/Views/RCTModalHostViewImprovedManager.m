/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
*
* This source code is licensed under the MIT license found in the
* LICENSE file in the root directory of this source tree.
*/

#import "RCTModalHostViewImprovedManager.h"
#import "RCTModalHostViewImproved.h"
#import "RCTShadowView.h"

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

- (void)dismissModalHostViewWithCompletion:(RCTModalHostView *)modalHostView
                        withViewController:(RCTModalHostViewController *)viewController
                                  animated:(BOOL)animated completion:(void (^)(void))completion
{
  NSLog(@"dismissModalHostViewWithCompletion");
}

/* Over-ride this method to add custom shadow view
- (RCTShadowView *)shadowView
{
  return [RCTModalHostShadowView new];
}
*/

@end
