/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#import <UIKit/UIKit.h>

#import "RCTAssert.h"
#import "RCTBridge.h"
#import "RCTModalHostViewControllerImproved.h"
#import "RCTTouchHandler.h"
#import "RCTUIManager.h"
#import "RCTUtils.h"
#import "UIView+React.h"

@implementation RCTModalHostViewImproved {
  __weak RCTBridge *_bridge;
  BOOL _isPresented;
  RCTModalHostViewControllerImproved *_modalViewController;
  RCTTouchHandler *_touchHandler;
  UIView *_reactSubview;
  UIInterfaceOrientation _lastKnownOrientation;
  RCTDirectEventBlock _onRequestClose;
}

RCT_NOT_IMPLEMENTED(-(instancetype)initWithFrame : (CGRect)frame)
RCT_NOT_IMPLEMENTED(-(instancetype)initWithCoder : coder)

- (instancetype)initWithBridge:(RCTBridge *)bridge
{
  self = [super initWithBridge:bridge];
  _modalViewController.modalHostView = self;

  return self;
}

- (void)dismissModalViewController
{
  [self dismissModalViewControllerWithCompletion: nil];
}

- (void)dismissModalViewControllerWithCompletion:(void (^)(void))completion
{
  if (_isPresented) {
    [self.delegate dismissModalHostView:self withViewController:_modalViewController animated:[self hasAnimationType]];
    [self.delegate dismissModalHostViewWithCompletion:self withViewController:_modalViewController animated:[self hasAnimationType] completion: completion];
    _isPresented = NO;
  }
}

- (BOOL)hasAnimationType
{
  return ![self.animationType isEqualToString:@"none"];
}

@end
