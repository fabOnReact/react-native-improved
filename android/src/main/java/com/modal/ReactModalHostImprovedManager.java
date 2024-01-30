/*
 * @see https://github.com/fabriziobertoglio1987/react-native-improved
 *
 * @author Fabrizio Bertoglio https://github.com/fabriziobertoglio1987
 */
package com.modal;

import com.facebook.react.module.annotations.ReactModule;
import com.facebook.react.views.modal.ReactModalHostManager;

/** View manager for {@link ReactModalHostView} components. */
@ReactModule(name = ReactModalHostManager.REACT_CLASS)
public class ReactModalHostImprovedManager extends ReactModalHostManager {

  public static final String REACT_CLASS = "RCTModalHostViewImproved";

  @Override
  public String getName() {
    return REACT_CLASS;
  }
}
