#import <React/RCTViewManager.h>
#import <React/RCTUIManager.h>
#import "RCTBridge.h"
#import "Utils.h"
#import <React/RCTUITextView.h>
#import <React/RCTMultilineTextInputView.h>
#import "TextView.h"
#import "RCTBaseTextInputViewManager.h"

@interface TextViewManager : RCTBaseTextInputViewManager
@end

@implementation TextViewManager

RCT_EXPORT_MODULE(TextView)

- (UIView *)view
{
  return [[TextView alloc] initWithBridge:self.bridge];
}

RCT_CUSTOM_VIEW_PROPERTY(color, NSString, UIView)
{
  [view setBackgroundColor: [Utils hexStringToColor:json]];
  NSLog(@"ehllo");
}

@end
