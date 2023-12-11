package com.text;

import com.facebook.react.bridge.ReactContext;
import com.facebook.react.views.text.ReactTextView;

public class ReactTextViewImproved extends ReactTextView {

  public ReactTextViewImproved(ReactContext context) {
    super(context);
    setText("Hello World");
  }
}
