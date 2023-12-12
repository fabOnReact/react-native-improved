package com.text;

import com.facebook.react.module.annotations.ReactModule;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.views.text.ReactTextShadowNode;
import com.facebook.react.views.text.ReactTextView;
import com.facebook.react.views.text.ReactTextViewManager;
import com.facebook.react.views.text.ReactTextViewManagerCallback;

import androidx.annotation.Nullable;

@ReactModule(name = ReactTextViewImprovedManager.NAME)
public class ReactTextViewImprovedManager
  extends ReactTextViewManager {
  public static final String NAME = "RCTTextImproved";
  protected @Nullable ReactTextViewManagerCallback mReactTextViewManagerCallback2;

  @Override
  public String getName() {
    return NAME;
  }

  public ReactTextViewImprovedManager() {
    this(null);
  }

  public ReactTextViewImprovedManager(@Nullable ReactTextViewManagerCallback reactTextViewManagerCallback) {
    super(reactTextViewManagerCallback);
    mReactTextViewManagerCallback2 = reactTextViewManagerCallback;
  }

  @Override
  public ReactTextView createViewInstance(ThemedReactContext context) {
    return new ReactTextViewImproved(context);
  }

  @Override
  public ReactTextShadowNode createShadowNodeInstance() {
    return new ReactTextViewImprovedShadowNode(mReactTextViewManagerCallback2);
  }

  @Override
  public Class<ReactTextShadowNode> getShadowNodeClass() {
    return ReactTextShadowNode.class;
  }
}
