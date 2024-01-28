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
#import "RCTModalHostView.h"
#import "RCTTouchHandler.h"
#import "RCTUIManager.h"
#import "RCTUtils.h"
#import "UIView+React.h"

@implementation RCTModalHostViewImproved {
  __weak RCTBridge *_bridge;
  BOOL _isPresented;
  RCTModalHostViewController *_modalViewController;
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
  _modalViewController = [RCTModalHostViewController new];
  UIView *containerView = [UIView new];
  containerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  _modalViewController.view = containerView;
  _touchHandler = [[RCTTouchHandler alloc] initWithBridge:bridge];
  _isPresented = NO;

  return self;
}

- (void)ensurePresentedOnlyIfNeeded
{
  BOOL shouldBePresented = !_isPresented && super.visible && self.window;
  if (shouldBePresented) {
    RCTAssert(self.reactViewController, @"Can't present modal view controller without a presenting view controller");

    [self.delegate presentModalHostView:self withViewController:_modalViewController animated:[self hasAnimationType]];
    _isPresented = YES;
  }

  BOOL shouldBeHidden = _isPresented && (!super.visible || !self.superview);
  if (shouldBeHidden) {
    [self dismissModalViewController];
  }
}

- (void)dismissModalViewController
{
  if (_isPresented) {
    [self.delegate dismissModalHostView:self withViewController:_modalViewController animated:[self hasAnimationType]];
    _isPresented = NO;
  }
}

- (BOOL)hasAnimationType
{
  return ![self.animationType isEqualToString:@"none"];
}
@end
