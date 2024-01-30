/*
 * @see https://github.com/fabriziobertoglio1987/react-native-improved
 *
 * @author Fabrizio Bertoglio https://github.com/fabriziobertoglio1987
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

