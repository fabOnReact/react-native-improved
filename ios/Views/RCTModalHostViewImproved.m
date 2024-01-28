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

- (void)insertReactSubview:(UIView *)subview atIndex:(NSInteger)atIndex
{
  [super insertReactSubview:subview atIndex:atIndex];
  [_modalViewController.view insertSubview:subview atIndex:0];
}

- (void)removeReactSubview:(UIView *)subview
{
  RCTAssert(subview == _reactSubview, @"Cannot remove view other than modal view");
  // Superclass (category) removes the `subview` from actual `superview`.
  [super removeReactSubview:subview];
  [_touchHandler detachFromView:subview];
  _reactSubview = nil;
}

- (void)didUpdateReactSubviews
{
  // Do nothing, as subview (singular) is managed by `insertReactSubview:atIndex:`
}

- (void)ensurePresentedOnlyIfNeeded
{
  BOOL shouldBePresented = !_isPresented && super.visible && self.window;
  if (shouldBePresented) {
    RCTAssert(self.reactViewController, @"Can't present modal view controller without a presenting view controller");
    _modalViewController.supportedInterfaceOrientations = [self supportedOrientationsMask];

    if ([self.animationType isEqualToString:@"fade"]) {
      _modalViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    } else if ([self.animationType isEqualToString:@"slide"]) {
      _modalViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    }
    if (self.presentationStyle != UIModalPresentationNone) {
      _modalViewController.modalPresentationStyle = self.presentationStyle;
    }
    _modalViewController.presentationController.delegate = self;
    [self.delegate presentModalHostView:self withViewController:_modalViewController animated:[self hasAnimationType]];
    _isPresented = YES;
  }

  BOOL shouldBeHidden = _isPresented && (!super.visible || !self.superview);
  if (shouldBeHidden) {
    [self dismissModalViewController];
  }
}

- (UIInterfaceOrientationMask)supportedOrientationsMask
{
  if (self.supportedOrientations.count == 0) {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
      return UIInterfaceOrientationMaskAll;
    } else {
      return UIInterfaceOrientationMaskPortrait;
    }
  }

  UIInterfaceOrientationMask supportedOrientations = 0;
  for (NSString *orientation in self.supportedOrientations) {
    if ([orientation isEqualToString:@"portrait"]) {
      supportedOrientations |= UIInterfaceOrientationMaskPortrait;
    } else if ([orientation isEqualToString:@"portrait-upside-down"]) {
      supportedOrientations |= UIInterfaceOrientationMaskPortraitUpsideDown;
    } else if ([orientation isEqualToString:@"landscape"]) {
      supportedOrientations |= UIInterfaceOrientationMaskLandscape;
    } else if ([orientation isEqualToString:@"landscape-left"]) {
      supportedOrientations |= UIInterfaceOrientationMaskLandscapeLeft;
    } else if ([orientation isEqualToString:@"landscape-right"]) {
      supportedOrientations |= UIInterfaceOrientationMaskLandscapeRight;
    }
  }
  return supportedOrientations;
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
