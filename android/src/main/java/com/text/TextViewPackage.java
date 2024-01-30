
package com.text;

import com.facebook.react.ReactPackage;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.uimanager.ViewManager;
import com.modal.ReactModalHostManagerImproved;
import com.textinput.ReactTextInputManagerImproved;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class TextViewPackage implements ReactPackage {
  @Override
  public List<ViewManager> createViewManagers(ReactApplicationContext reactContext) {
    List<ViewManager> viewManagers = new ArrayList<>();
    viewManagers.add(new ReactTextViewManagerImproved());
    viewManagers.add(new ReactTextInputManagerImproved());
    viewManagers.add(new ReactModalHostManagerImproved());
    return viewManagers;
  }

  @Override
  public List<NativeModule> createNativeModules(ReactApplicationContext reactContext) {
    return Collections.emptyList();
  }
}
