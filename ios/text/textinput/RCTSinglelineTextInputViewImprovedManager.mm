/*
 * @see https://github.com/fabriziobertoglio1987/react-native-improved
 *
 * @author Fabrizio Bertoglio https://github.com/fabriziobertoglio1987
 */

#import "RCTSinglelineTextInputViewImprovedManager.h"
#import "RCTSinglelineTextInputViewImproved.h"

#import <React/RCTBaseTextInputShadowView.h>
#import <React/RCTSinglelineTextInputView.h>

@implementation RCTSinglelineTextInputViewImprovedManager

RCT_EXPORT_MODULE()

- (RCTShadowView *)shadowView
{
  RCTBaseTextInputShadowView *shadowView = (RCTBaseTextInputShadowView *)[super shadowView];

  shadowView.maximumNumberOfLines = 1;

  return shadowView;
}

- (UIView *)view
{
  return [[RCTSinglelineTextInputViewImproved alloc] initWithBridge:self.bridge];
}

@end
