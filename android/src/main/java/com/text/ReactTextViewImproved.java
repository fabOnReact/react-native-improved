package com.text;

import android.graphics.Color;

import com.facebook.react.bridge.ReactContext;
import com.facebook.react.views.text.ReactTextView;

public class ReactTextViewImproved extends ReactTextView {

  public ReactTextViewImproved(ReactContext context) {
    super(context);
  }

  @Override
  public void onAttachedToWindow() {
    super.onAttachedToWindow();
    // original was red, we change to blue
    setBackgroundColor(Color.BLUE);
  }
}
