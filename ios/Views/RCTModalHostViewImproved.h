/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RCTModalHostView.h"
#import "RCTModalHostViewImproved.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RCTModalHostViewInteractorImproved;

@interface RCTModalHostViewImproved : RCTModalHostView

@property (nonatomic, weak) id<RCTModalHostViewInteractorImproved> delegate;

@end

@protocol RCTModalHostViewInteractorImproved <NSObject>

- (void)presentModalHostView:(RCTModalHostViewImproved *)modalHostView
          withViewController:(RCTModalHostViewController *)viewController
                    animated:(BOOL)animated;
- (void)dismissModalHostView:(RCTModalHostViewImproved *)modalHostView
          withViewController:(RCTModalHostViewController *)viewController
                    animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
