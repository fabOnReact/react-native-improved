/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

package com.textinput;

import androidx.annotation.Nullable;
import com.facebook.react.module.annotations.ReactModule;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.views.text.ReactTextViewManagerCallback;
import com.facebook.react.views.textinput.ReactEditText;
import com.facebook.react.views.textinput.ReactTextInputManager;

@ReactModule(name = ReactTextInputImprovedManager.NAME)
public class ReactTextInputImprovedManager extends ReactTextInputManager {
  public static final String NAME = "RCTTextInputImproved";
  protected @Nullable ReactTextViewManagerCallback mReactTextViewManagerCallback;

  @Override
  public String getName() {
    return NAME;
  }

  /*
  public ReactTextInputImprovedManager() {
    this(null);
  }


  public ReactTextInputImprovedManager(
      @Nullable ReactTextViewManagerCallback reactTextViewManagerCallback) {
    super(reactTextViewManagerCallback);
  }
  */

  @Override
  public ReactEditText createViewInstance(ThemedReactContext context) {
    return new ReactEditTextImproved(context);
  }
}
