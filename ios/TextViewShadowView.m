#import <React/RCTBaseTextInputShadowView.h>

#import <React/RCTBridge.h>
#import <React/RCTShadowView+Layout.h>
#import <React/RCTUIManager.h>
#import <yoga/Yoga.h>

#import <React/RCTBaseTextInputView.h>
#import "NSTextStorage+FontScaling.h"
#import "TextViewShadowView.h"

@implementation TextViewShadowView {
  __weak RCTBridge *_bridge;
  NSAttributedString *_Nullable _previousAttributedText;
  BOOL _needsUpdateView;
  NSAttributedString *_Nullable _localAttributedText;
  CGSize _previousContentSize;

  NSString *_text;
  NSTextStorage *_textStorage;
  NSTextContainer *_textContainer;
  NSLayoutManager *_layoutManager;
}

- (void)uiManagerWillPerformMounting
{
  [super uiManagerWillPerformMounting];
  NSMutableAttributedString *attributedText = [[self attributedTextWithBaseTextAttributes:nil] mutableCopy];
  [self postprocessAttributedText:attributedText];
}

- (void)postprocessAttributedText:(NSMutableAttributedString *)attributedText
{
  __block CGFloat maximumLineHeight = 0;

  [attributedText enumerateAttribute:NSParagraphStyleAttributeName
                             inRange:NSMakeRange(0, attributedText.length)
                             options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
                          usingBlock:^(NSParagraphStyle *paragraphStyle, __unused NSRange range, __unused BOOL *stop) {
    if (!paragraphStyle) {
      return;
    }

    maximumLineHeight = MAX(paragraphStyle.maximumLineHeight, maximumLineHeight);
  }];

  if (maximumLineHeight == 0) {
    // `lineHeight` was not specified, nothing to do.
    return;
  }

  __block CGFloat maximumFontLineHeight = 0;

  [attributedText enumerateAttribute:NSFontAttributeName
                             inRange:NSMakeRange(0, attributedText.length)
                             options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
                          usingBlock:^(UIFont *font, NSRange range, __unused BOOL *stop) {
    if (!font) {
      return;
    }

    if (maximumFontLineHeight <= font.lineHeight) {
      maximumFontLineHeight = font.lineHeight;
    }
  }];

  if (maximumLineHeight < maximumFontLineHeight) {
    return;
  }

  CGFloat baseLineOffset = maximumLineHeight / 2.0 - maximumFontLineHeight / 2.0;

  [attributedText addAttribute:NSBaselineOffsetAttributeName
                         value:@(baseLineOffset)
                         range:NSMakeRange(0, attributedText.length)];
}

@end
