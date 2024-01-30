/*
 * @see https://github.com/fabriziobertoglio1987/react-native-improved
 *
 * @author Fabrizio Bertoglio https://github.com/fabriziobertoglio1987
 */
package com.textinput;

import android.graphics.Color;
import android.graphics.Paint;
import android.text.Editable;
import android.text.InputType;
import android.text.Spannable;
import android.text.SpannableStringBuilder;
import android.text.Spanned;
import android.text.TextUtils;
import androidx.annotation.Nullable;
import androidx.core.util.Predicate;
import com.facebook.common.logging.FLog;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactSoftExceptionLogger;
import com.facebook.react.uimanager.StateWrapper;
import com.facebook.react.views.text.CustomLetterSpacingSpan;
import com.facebook.react.views.text.CustomLineHeightSpan;
import com.facebook.react.views.text.CustomStyleSpan;
import com.facebook.react.views.text.ReactAbsoluteSizeSpan;
import com.facebook.react.views.text.ReactBackgroundColorSpan;
import com.facebook.react.views.text.ReactForegroundColorSpan;
import com.facebook.react.views.text.ReactSpan;
import com.facebook.react.views.text.ReactStrikethroughSpan;
import com.facebook.react.views.text.ReactTextUpdate;
import com.facebook.react.views.text.ReactUnderlineSpan;
import com.facebook.react.views.text.TextAttributes;
import com.facebook.react.views.text.TextLayoutManager;
import com.facebook.react.views.textinput.ReactEditText;
import com.facebook.react.views.view.ReactViewBackgroundManager;
import java.util.Objects;

public class ReactEditTextImproved extends ReactEditText {
  private final String TAG = ReactEditTextImproved.class.getSimpleName();
  private StateWrapper mStateWrapper = null;
  private ReactViewBackgroundManager mReactBackgroundManager;
  private TextAttributes mTextAttributes;
  private @Nullable String mFontFamily = null;
  private static final int UNSET = -1;
  private int mFontStyle = UNSET;
  private int mFontWeight = UNSET;

  public ReactEditTextImproved(ReactContext context) {
    super(context);
    mTextAttributes = new TextAttributes();
    mReactBackgroundManager = new ReactViewBackgroundManager(this);
  }

  public void maybeSetText(ReactTextUpdate reactTextUpdate) {
    if (isSecureText() && TextUtils.equals(getText(), reactTextUpdate.getText())) {
      return;
    }

    // Only set the text if it is up to date.
    if (!canUpdateWithEventCount(reactTextUpdate.getJsEventCounter())) {
      return;
    }

    if (DEBUG_MODE) {
      FLog.e(
          TAG,
          "maybeSetText["
              + getId()
              + "]: current text: "
              + getText()
              + " update: "
              + reactTextUpdate.getText());
    }

    // The current text gets replaced with the text received from JS. However, the spans on the
    // current text need to be adapted to the new text. Since TextView#setText() will remove or
    // reset some of these spans even if they are set directly, SpannableStringBuilder#replace() is
    // used instead (this is also used by the keyboard implementation underneath the covers).
    SpannableStringBuilder spannableStringBuilder =
        new SpannableStringBuilder(reactTextUpdate.getText());

    manageSpans(spannableStringBuilder);
    stripStyleEquivalentSpans(spannableStringBuilder);

    mContainsImages = reactTextUpdate.containsImages();

    // When we update text, we trigger onChangeText code that will
    // try to update state if the wrapper is available. Temporarily disable
    // to prevent an (asynchronous) infinite loop.
    mDisableTextDiffing = true;

    // On some devices, when the text is cleared, buggy keyboards will not clear the composing
    // text so, we have to set text to null, which will clear the currently composing text.
    if (reactTextUpdate.getText().length() == 0) {
      setText(null);
    } else {
      // When we update text, we trigger onChangeText code that will
      // try to update state if the wrapper is available. Temporarily disable
      // to prevent an infinite loop.
      getText().replace(0, length(), spannableStringBuilder);
    }
    mDisableTextDiffing = false;

    if (getBreakStrategy() != reactTextUpdate.getTextBreakStrategy()) {
      setBreakStrategy(reactTextUpdate.getTextBreakStrategy());
    }

    // Update cached spans (in Fabric only).
    updateCachedSpannable();
  }

  private boolean isSecureText() {
    return (getInputType()
            & (InputType.TYPE_NUMBER_VARIATION_PASSWORD | InputType.TYPE_TEXT_VARIATION_PASSWORD))
        != 0;
  }

  /**
   * Update the cached Spannable used in TextLayoutManager to measure the text in Fabric. This is
   * mostly copied from ReactTextInputShadowNode.java (the non-Fabric version) and
   * TextLayoutManager.java with some very minor modifications. There's some duplication between
   * here and TextLayoutManager, so there might be an opportunity for refactor.
   */
  private void updateCachedSpannable() {
    // Noops in non-Fabric
    if (mStateWrapper == null) {
      return;
    }
    // If this view doesn't have an ID yet, we don't have a cache key, so bail here
    if (getId() == -1) {
      return;
    }

    Editable currentText = getText();
    boolean haveText = currentText != null && currentText.length() > 0;

    SpannableStringBuilder sb = new SpannableStringBuilder();

    // A note of caution: appending currentText to sb appends all the spans of currentText - not
    // copies of the Spans, but the actual span objects. Any modifications to sb after that point
    // can modify the spans of sb/currentText, impact the text or spans visible on screen, and
    // also call the TextChangeWatcher methods.
    if (haveText) {
      // This is here as a workaround for T76236115, which looks like this:
      // Hopefully we can delete all this stuff if we can get rid of the soft errors.
      // - android.text.SpannableStringBuilder.charAt (SpannableStringBuilder.java:123)
      // - android.text.CharSequenceCharacterIterator.current
      // (CharSequenceCharacterIterator.java:58)
      // - android.text.CharSequenceCharacterIterator.setIndex
      // (CharSequenceCharacterIterator.java:83)
      // - android.icu.text.RuleBasedBreakIterator.CISetIndex32 (RuleBasedBreakIterator.java:1126)
      // - android.icu.text.RuleBasedBreakIterator.isBoundary (RuleBasedBreakIterator.java:503)
      // - android.text.method.WordIterator.isBoundary (WordIterator.java:95)
      // - android.widget.Editor$SelectionHandleView.positionAtCursorOffset (Editor.java:6666)
      // - android.widget.Editor$HandleView.invalidate (Editor.java:5241)
      // - android.widget.Editor$SelectionModifierCursorController.invalidateHandles
      // (Editor.java:7442)
      // - android.widget.Editor.invalidateHandlesAndActionMode (Editor.java:2112)
      // - android.widget.TextView.spanChange (TextView.java:11189)
      // - android.widget.TextView$ChangeWatcher.onSpanAdded (TextView.java:14189)
      // - android.text.SpannableStringBuilder.sendSpanAdded (SpannableStringBuilder.java:1283)
      // - android.text.SpannableStringBuilder.sendToSpanWatchers (SpannableStringBuilder.java:663)
      // - android.text.SpannableStringBuilder.replace (SpannableStringBuilder.java:579)
      // - android.text.SpannableStringBuilder.append (SpannableStringBuilder.java:269)
      // - ReactEditText.updateCachedSpannable (ReactEditText.java:995)
      // - ReactEditText$TextWatcherDelegator.onTextChanged (ReactEditText.java:1044)
      // - android.widget.TextView.sendOnTextChanged (TextView.java:10972)
      // ...
      // - android.text.method.BaseKeyListener.onKeyDown (BaseKeyListener.java:479)
      // - android.text.method.QwertyKeyListener.onKeyDown (QwertyKeyListener.java:362)
      // - ReactEditText$InternalKeyListener.onKeyDown (ReactEditText.java:1094)
      // ...
      // - android.app.Activity.dispatchKeyEvent (Activity.java:3447)
      try {
        sb.append(currentText.subSequence(0, currentText.length()));
      } catch (IndexOutOfBoundsException e) {
        ReactSoftExceptionLogger.logSoftException(TAG, e);
      }
    }

    // If we don't have text, make sure we have *something* to measure.
    // Hint has the same dimensions - the only thing that's different is background or foreground
    // color
    if (!haveText) {
      if (getHint() != null && getHint().length() > 0) {
        sb.append(getHint());
      } else {
        // Measure something so we have correct height, even if there's no string.
        sb.append("I");
      }
    }

    addSpansFromStyleAttributes(sb);
    TextLayoutManager.setCachedSpannabledForTag(getId(), sb);
  }

  /**
   * Copy styles represented as attributes to the underlying span, for later measurement or other
   * usage outside the ReactEditText.
   */
  private void addSpansFromStyleAttributes(SpannableStringBuilder workingText) {
    int spanFlags = Spannable.SPAN_INCLUSIVE_INCLUSIVE;

    // Set all bits for SPAN_PRIORITY so that this span has the highest possible priority
    // (least precedence). This ensures the span is behind any overlapping spans.
    spanFlags |= Spannable.SPAN_PRIORITY;

    workingText.setSpan(
        new ReactAbsoluteSizeSpan(mTextAttributes.getEffectiveFontSize()),
        0,
        workingText.length(),
        spanFlags);

    workingText.setSpan(
        new ReactForegroundColorSpan(getCurrentTextColor()), 0, workingText.length(), spanFlags);

    int backgroundColor = mReactBackgroundManager.getBackgroundColor();
    if (backgroundColor != Color.TRANSPARENT) {
      workingText.setSpan(
          new ReactBackgroundColorSpan(backgroundColor), 0, workingText.length(), spanFlags);
    }

    if ((getPaintFlags() & Paint.STRIKE_THRU_TEXT_FLAG) != 0) {
      workingText.setSpan(new ReactStrikethroughSpan(), 0, workingText.length(), spanFlags);
    }

    if ((getPaintFlags() & Paint.UNDERLINE_TEXT_FLAG) != 0) {
      workingText.setSpan(new ReactUnderlineSpan(), 0, workingText.length(), spanFlags);
    }

    float effectiveLetterSpacing = mTextAttributes.getEffectiveLetterSpacing();
    if (!Float.isNaN(effectiveLetterSpacing)) {
      workingText.setSpan(
          new CustomLetterSpacingSpan(effectiveLetterSpacing), 0, workingText.length(), spanFlags);
    }

    if (mFontStyle != UNSET
        || mFontWeight != UNSET
        || mFontFamily != null
        || getFontFeatureSettings() != null) {
      workingText.setSpan(
          new CustomStyleSpan(
              mFontStyle,
              mFontWeight,
              getFontFeatureSettings(),
              mFontFamily,
              getContext().getAssets()),
          0,
          workingText.length(),
          spanFlags);
    }

    float lineHeight = mTextAttributes.getEffectiveLineHeight();
    if (!Float.isNaN(lineHeight)) {
      workingText.setSpan(new CustomLineHeightSpan(lineHeight), 0, workingText.length(), spanFlags);
    }
  }

  private static boolean sameTextForSpan(
      final Editable oldText,
      final SpannableStringBuilder newText,
      final int start,
      final int end) {
    if (start > newText.length() || end > newText.length()) {
      return false;
    }
    for (int charIdx = start; charIdx < end; charIdx++) {
      if (oldText.charAt(charIdx) != newText.charAt(charIdx)) {
        return false;
      }
    }
    return true;
  }

  /**
   * Remove and/or add {@link Spanned.SPAN_EXCLUSIVE_EXCLUSIVE} spans, since they should only exist
   * as long as the text they cover is the same. All other spans will remain the same, since they
   * will adapt to the new text, hence why {@link SpannableStringBuilder#replace} never removes
   * them.
   */
  private void manageSpans(SpannableStringBuilder spannableStringBuilder) {
    Object[] spans = getText().getSpans(0, length(), Object.class);
    for (int spanIdx = 0; spanIdx < spans.length; spanIdx++) {
      Object span = spans[spanIdx];
      int spanFlags = getText().getSpanFlags(span);
      boolean isExclusiveExclusive =
          (spanFlags & Spanned.SPAN_EXCLUSIVE_EXCLUSIVE) == Spanned.SPAN_EXCLUSIVE_EXCLUSIVE;

      // Remove all styling spans we might have previously set
      if (span instanceof ReactSpan) {
        getText().removeSpan(span);
      }

      // We only add spans back for EXCLUSIVE_EXCLUSIVE spans
      if (!isExclusiveExclusive) {
        continue;
      }

      final int spanStart = getText().getSpanStart(span);
      final int spanEnd = getText().getSpanEnd(span);

      // Make sure the span is removed from existing text, otherwise the spans we set will be
      // ignored or it will cover text that has changed.
      getText().removeSpan(span);
      if (sameTextForSpan(getText(), spannableStringBuilder, spanStart, spanEnd)) {
        spannableStringBuilder.setSpan(span, spanStart, spanEnd, spanFlags);
      }
    }
  }

  /**
   * Remove spans from the SpannableStringBuilder which can be represented by TextAppearance
   * attributes on the underlying EditText. This works around instability on Samsung devices with
   * the presence of spans https://github.com/facebook/react-native/issues/35936 (S318090)
   */
  private void stripStyleEquivalentSpans(SpannableStringBuilder sb) {
    stripSpansOfKind(
        sb,
        ReactAbsoluteSizeSpan.class,
        (span) -> span.getSize() == mTextAttributes.getEffectiveFontSize());

    stripSpansOfKind(
        sb,
        ReactBackgroundColorSpan.class,
        (span) -> span.getBackgroundColor() == mReactBackgroundManager.getBackgroundColor());

    stripSpansOfKind(
        sb,
        ReactForegroundColorSpan.class,
        (span) -> span.getForegroundColor() == getCurrentTextColor());

    stripSpansOfKind(
        sb,
        ReactStrikethroughSpan.class,
        (span) -> (getPaintFlags() & Paint.STRIKE_THRU_TEXT_FLAG) != 0);

    stripSpansOfKind(
        sb, ReactUnderlineSpan.class, (span) -> (getPaintFlags() & Paint.UNDERLINE_TEXT_FLAG) != 0);

    stripSpansOfKind(
        sb,
        CustomLetterSpacingSpan.class,
        (span) -> span.getSpacing() == mTextAttributes.getEffectiveLetterSpacing());

    stripSpansOfKind(
        sb,
        CustomStyleSpan.class,
        (span) -> {
          return span.getStyle() == mFontStyle
              && Objects.equals(span.getFontFamily(), mFontFamily)
              && span.getWeight() == mFontWeight
              && Objects.equals(span.getFontFeatureSettings(), getFontFeatureSettings());
        });
  }

  private <T> void stripSpansOfKind(
      SpannableStringBuilder sb, Class<T> clazz, Predicate<T> shouldStrip) {
    T[] spans = sb.getSpans(0, sb.length(), clazz);

    for (T span : spans) {
      if (shouldStrip.test(span)) {
        sb.removeSpan(span);
      }
    }
  }
}
