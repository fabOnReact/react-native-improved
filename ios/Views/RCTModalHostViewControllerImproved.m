/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import "RCTModalHostViewControllerImproved.h"

#import "RCTLog.h"
#import "RCTModalHostView.h"

@implementation RCTModalHostViewControllerImproved {
  CGRect _lastViewFrame;
  UIStatusBarStyle _preferredStatusBarStyle;
  BOOL _preferredStatusBarHidden;
}

- (instancetype)init
{
  if (!(self = [super init])) {
    return nil;
  }

  self.modalInPresentation = YES;

  // _preferredStatusBarStyle = [RCTSharedApplication() statusBarStyle];
  // _preferredStatusBarHidden = [RCTSharedApplication() isStatusBarHidden];

  return self;
}


@end

