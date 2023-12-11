package com.text;

import android.view.View;

import androidx.annotation.Nullable;

import com.facebook.react.uimanager.SimpleViewManager;
import com.facebook.react.uimanager.ViewManagerDelegate;
import com.facebook.react.viewmanagers.TextViewManagerDelegate;
import com.facebook.react.viewmanagers.TextViewManagerInterface;

public abstract class TextViewManagerSpec<T extends View> extends SimpleViewManager<T> implements TextViewManagerInterface<T> {
  private final ViewManagerDelegate<T> mDelegate;

  public TextViewManagerSpec() {
    mDelegate = new TextViewManagerDelegate(this);
  }

  @Nullable
  @Override
  protected ViewManagerDelegate<T> getDelegate() {
    return mDelegate;
  }
}
