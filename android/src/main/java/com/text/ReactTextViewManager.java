package com.text;

import android.graphics.Color;

import androidx.annotation.Nullable;

import com.facebook.react.module.annotations.ReactModule;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;

@ReactModule(name = ReactTextViewManager.NAME)
public class ReactTextViewManager extends TextViewManagerSpec<ReactTextView> {

  public static final String NAME = "TextView";

  @Override
  public String getName() {
    return NAME;
  }

  @Override
  public ReactTextView createViewInstance(ThemedReactContext context) {
    return new ReactTextView(context);
  }

  @Override
  @ReactProp(name = "color")
  public void setColor(ReactTextView view, @Nullable String color) {
    view.setBackgroundColor(Color.parseColor(color));
  }
}
