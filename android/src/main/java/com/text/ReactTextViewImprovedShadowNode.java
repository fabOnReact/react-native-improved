package com.text;

import androidx.annotation.Nullable;

import com.facebook.react.views.text.ReactBaseTextShadowNode;
import com.facebook.react.views.text.ReactTextShadowNode;
import com.facebook.react.views.text.ReactTextViewManagerCallback;
import com.facebook.yoga.YogaMeasureFunction;
import com.facebook.yoga.YogaMeasureMode;
import com.facebook.yoga.YogaMeasureOutput;
import com.facebook.yoga.YogaNode;

public class ReactTextViewImprovedShadowNode extends ReactTextShadowNode {

  private final YogaMeasureFunction mTextMeasureFunction =
    new YogaMeasureFunction() {
      @Override
      public long measure(
        YogaNode node,
        float width,
        YogaMeasureMode widthMode,
        float height,
        YogaMeasureMode heightMode) {
        return YogaMeasureOutput.make(200, 200);
      }
    };

  public ReactTextViewImprovedShadowNode() {
    this(null);
  }

  public ReactTextViewImprovedShadowNode(@Nullable ReactTextViewManagerCallback reactTextViewManagerCallback) {
    super(reactTextViewManagerCallback);
    initMeasureFunction();
  }

  private void initMeasureFunction() {
    if (!isVirtual()) {
      setMeasureFunction(mTextMeasureFunction);
    }
  }
}
