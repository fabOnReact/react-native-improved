/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
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
