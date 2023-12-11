package com.text;

import android.graphics.Color;

import androidx.annotation.Nullable;

import com.facebook.react.module.annotations.ReactModule;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;

@ReactModule(name = ReactTextViewManager.NAME)
public class ReactTextViewManager extends TextViewManagerSpec<ReactTextViewImproved> {

  public static final String NAME = "TextView";

  @Override
  public String getName() {
    return NAME;
  }

  @Override
  public ReactTextViewImproved createViewInstance(ThemedReactContext context) {
    return new ReactTextViewImproved(context);
  }

  @Override
  @ReactProp(name = "color")
  public void setColor(ReactTextViewImproved view, @Nullable String color) {
    view.setBackgroundColor(Color.parseColor(color));
  }
}
