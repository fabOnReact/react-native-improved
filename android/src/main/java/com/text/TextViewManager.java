package com.text;

import android.graphics.Color;

import androidx.annotation.Nullable;

import com.facebook.react.module.annotations.ReactModule;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;

@ReactModule(name = TextViewManager.NAME)
public class TextViewManager extends TextViewManagerSpec<TextView> {

  public static final String NAME = "TextView";

  @Override
  public String getName() {
    return NAME;
  }

  @Override
  public TextView createViewInstance(ThemedReactContext context) {
    return new TextView(context);
  }

  @Override
  @ReactProp(name = "color")
  public void setColor(TextView view, @Nullable String color) {
    view.setBackgroundColor(Color.parseColor(color));
  }
}
