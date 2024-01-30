/*
 * @see https://github.com/fabriziobertoglio1987/react-native-improved
 *
 * @author Fabrizio Bertoglio https://github.com/fabriziobertoglio1987
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
