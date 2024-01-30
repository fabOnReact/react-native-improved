/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

package com.text;

import androidx.annotation.Nullable;
import com.facebook.react.module.annotations.ReactModule;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.views.text.ReactTextShadowNode;
import com.facebook.react.views.text.ReactTextView;
import com.facebook.react.views.text.ReactTextViewManager;
import com.facebook.react.views.text.ReactTextViewManagerCallback;

@ReactModule(name = ReactTextViewManagerImproved.NAME)
public class ReactTextViewManagerImproved extends ReactTextViewManager {
  public static final String NAME = "RCTTextImproved";
  protected @Nullable ReactTextViewManagerCallback mReactTextViewManagerCallback;

  @Override
  public String getName() {
    return NAME;
  }

  public ReactTextViewManagerImproved() {
    this(null);
  }

  public ReactTextViewManagerImproved(
      @Nullable ReactTextViewManagerCallback reactTextViewManagerCallback) {
    super(reactTextViewManagerCallback);
    mReactTextViewManagerCallback = reactTextViewManagerCallback;
  }

  @Override
  public ReactTextView createViewInstance(ThemedReactContext context) {
    return new ReactTextViewImproved(context);
  }

  @Override
  public ReactTextShadowNode createShadowNodeInstance() {
    return new ReactTextViewShadowNodeImproved(mReactTextViewManagerCallback);
  }

  @Override
  public Class<ReactTextShadowNode> getShadowNodeClass() {
    return ReactTextShadowNode.class;
  }
}
