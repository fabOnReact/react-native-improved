/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RCTModalHostView.h"
#import "RCTModalHostViewImproved.h"
#import "RCTModalHostViewControllerImproved.h"
#import "RCTModalHostViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RCTModalHostViewInteractorImproved;

@interface RCTModalHostViewImproved : RCTModalHostView

@property (nonatomic, weak) id<RCTModalHostViewInteractorImproved> delegate;
@property (nonatomic, strong) UIWindow *modalWindow;

- (void)dismissModalViewControllerWithCompletion:(void (^)(void))completion;

@end

@protocol RCTModalHostViewInteractorImproved <NSObject>

- (void)presentModalHostView:(RCTModalHostView *)modalHostView
          withViewController:(RCTModalHostViewController *)viewController
                    animated:(BOOL)animated;
- (void)dismissModalHostView:(RCTModalHostViewImproved *)modalHostView
          withViewController:(RCTModalHostViewController *)viewController
                    animated:(BOOL)animated;
- (void)dismissModalHostViewWithCompletion:(RCTModalHostViewImproved *)modalHostView
                        withViewController:(RCTModalHostViewController *)viewController
                                  animated:(BOOL)animated completion: (void (^)(void))completion;

@end

NS_ASSUME_NONNULL_END
