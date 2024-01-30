/*
 * @see https://github.com/fabriziobertoglio1987/react-native-improved
 *
 * @author Fabrizio Bertoglio https://github.com/fabriziobertoglio1987
 */

#import <React/RCTMultilineTextInputView.h>

#import <React/RCTUtils.h>

#import <React/RCTUITextView.h>

#import "RCTSinglelineTextInputViewImproved.h"

#import "Utils.h"

#import <React/RCTUITextView.h>
#import <React/RCTSinglelineTextInputView.h>

#import <React/RCTSinglelineTextInputView.h>

#import <React/RCTBridge.h>

#import <React/RCTUITextField.h>

@implementation RCTSinglelineTextInputViewImproved {
  RCTUITextField *_backedTextInputView;
}

- (instancetype)initWithBridge:(RCTBridge *)bridge
{
  if (self = [super initWithBridge:bridge]) {
    // `submitBehavior` defaults to `"blurAndSubmit"` for <TextInput multiline={false}> by design.
    self.submitBehavior = @"blurAndSubmit";

    _backedTextInputView = [[RCTUITextField alloc] initWithFrame:self.bounds];
    _backedTextInputView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _backedTextInputView.textInputDelegate = self;

    [self addSubview:_backedTextInputView];
  }

  return self;
}

- (id<RCTBackedTextInputViewProtocol>)backedTextInputView
{
  return _backedTextInputView;
}

@end
