/*
 * @see https://github.com/fabriziobertoglio1987/react-native-improved
 *
 * @author Fabrizio Bertoglio https://github.com/fabriziobertoglio1987
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
  _modalViewController = [RCTModalHostViewControllerImproved new];
  UIView *containerView = [UIView new];
  containerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  _modalViewController.view = containerView;
  _touchHandler = [[RCTTouchHandler alloc] initWithBridge:bridge];
  _isPresented = NO;
  _modalViewController.modalHostView = self;

  return self;
}

- (void)insertReactSubview:(UIView *)subview atIndex:(NSInteger)atIndex
{
  [super insertReactSubview:subview atIndex:atIndex];
  [_modalViewController.view insertSubview:subview atIndex:0];
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
  [self dismissModalViewControllerWithCompletion: nil];
}

- (void)dismissModalViewControllerWithCompletion:(void (^)(void))completion
{
  if (_isPresented) {
    [self.delegate dismissModalHostViewWithCompletion:self 
                                   withViewController:_modalViewController
                                             animated:[self hasAnimationType]
                                           completion: completion];
    _isPresented = NO;
  }
}

- (BOOL)hasAnimationType
{
  return ![self.animationType isEqualToString:@"none"];
}

@end
