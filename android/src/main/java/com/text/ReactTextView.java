package com.text;

import android.content.Context;
import android.util.AttributeSet;
import android.widget.TextView;
import androidx.annotation.Nullable;

public class ReactTextView extends TextView {

  public ReactTextView(Context context) {
    super(context);
  }

  public ReactTextView(Context context, @Nullable AttributeSet attrs) {
    super(context, attrs);
  }

  public ReactTextView(Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
    super(context, attrs, defStyleAttr);
  }
}
