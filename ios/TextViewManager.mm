#import <React/RCTViewManager.h>
#import <React/RCTUIManager.h>
#import "RCTBridge.h"
#import "Utils.h"
#import <React/RCTUITextView.h>
#import <React/RCTMultilineTextInputView.h>
#import "TextView.h"
#import "TextViewShadowView.h"
#import "RCTBaseTextInputViewManager.h"
#import <React/RCTBaseTextInputShadowView.h>

@interface TextViewManager : RCTBaseTextInputViewManager
@end

@implementation TextViewManager {
  NSHashTable<RCTBaseTextInputShadowView *> *_shadowViews;
}

RCT_EXPORT_MODULE(TextView)

- (UIView *)view
{
  return [[TextView alloc] initWithBridge:self.bridge];
}

RCT_CUSTOM_VIEW_PROPERTY(color, NSString, UIView)
{
  [view setBackgroundColor: [Utils hexStringToColor:json]];
}

- (RCTShadowView *)shadowView
{
  TextViewShadowView *shadowView = [[TextViewShadowView alloc] initWithBridge:self.bridge];
  [_shadowViews addObject:shadowView];
  return shadowView;
}

- (void)setBridge:(RCTBridge *)bridge
{
  [super setBridge:bridge];

  _shadowViews = [NSHashTable weakObjectsHashTable];

  // [bridge.uiManager.observerCoordinator addObserver:self];
}

@end
