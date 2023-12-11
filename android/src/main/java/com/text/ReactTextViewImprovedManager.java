package com.text;

import android.graphics.Color;
import android.widget.TextView;

import androidx.annotation.Nullable;
import com.facebook.react.module.annotations.ReactModule;
import com.facebook.react.uimanager.IViewManagerWithChildren;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.uimanager.annotations.ReactProp;
import com.facebook.react.views.text.ReactTextAnchorViewManager;
import com.facebook.react.views.text.ReactTextShadowNode;
import com.facebook.react.views.text.ReactTextView;
import com.facebook.react.views.text.ReactTextViewManager;

@ReactModule(name = ReactTextViewImprovedManager.NAME)
public class ReactTextViewImprovedManager
  extends ReactTextViewManager {
  // Need to rename to ReactTextViewImproved
  public static final String NAME = "TextView";

  @Override
  public String getName() {
    return NAME;
  }
}
