/*
 * @see https://github.com/fabriziobertoglio1987/react-native-improved
 *
 * @author Fabrizio Bertoglio https://github.com/fabriziobertoglio1987
 */
package com.text;

import androidx.annotation.Nullable;
import com.facebook.react.module.annotations.ReactModule;
import com.facebook.react.uimanager.ThemedReactContext;
import com.facebook.react.views.text.ReactTextShadowNode;
import com.facebook.react.views.text.ReactTextView;
import com.facebook.react.views.text.ReactTextViewManager;
import com.facebook.react.views.text.ReactTextViewManagerCallback;

@ReactModule(name = ReactTextViewImprovedManager.NAME)
public class ReactTextViewImprovedManager extends ReactTextViewManager {
  public static final String NAME = "RCTTextImproved";
  protected @Nullable ReactTextViewManagerCallback mReactTextViewManagerCallback;

  @Override
  public String getName() {
    return NAME;
  }

  public ReactTextViewImprovedManager() {
    this(null);
  }

  public ReactTextViewImprovedManager(
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
    return new ReactTextViewImprovedShadowNode(mReactTextViewManagerCallback);
  }

  @Override
  public Class<ReactTextShadowNode> getShadowNodeClass() {
    return ReactTextShadowNode.class;
  }
}
