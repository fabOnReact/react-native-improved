/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

package com.textinput;

import android.util.Log;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.views.text.ReactTextUpdate;
import com.facebook.react.views.textinput.ReactEditText;

public class ReactEditTextImproved extends ReactEditText {

  public ReactEditTextImproved(ReactContext context) {
    super(context);
  }

  public void maybeSetText(ReactTextUpdate reactTextUpdate) {
    super.maybeSetText(reactTextUpdate);
    Log.w("TESTING", "ReactEditTextImproved => maybeSetText");
  }
}
