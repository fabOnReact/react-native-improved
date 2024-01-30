/*
 * @see https://github.com/fabriziobertoglio1987/react-native-improved
 *
 * @author Fabrizio Bertoglio https://github.com/fabriziobertoglio1987
 */
package com.text;

import android.util.Log;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.views.text.ReactTextView;

public class ReactTextViewImproved extends ReactTextView {

  public ReactTextViewImproved(ReactContext context) {
    super(context);
    Log.w("TESTING", "ReactTextViewImproved");
  }
}
