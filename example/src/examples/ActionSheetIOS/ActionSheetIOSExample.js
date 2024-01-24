/**
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 * @format
 * @flow
 */

'use strict';

import type {NativeMethods} from 'react-native/Libraries/Renderer/shims/ReactNativeTypes';

const React = require('react');
const {
  StyleSheet,
  Text,
  View,
  Alert,
  findNodeHandle,
} = require('react-native');

const style = StyleSheet.create({
  button: {
    marginBottom: 10,
    fontWeight: '500',
  },
  anchorRow: {
    flex: 1,
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
});

exports.title = 'ActionSheetIOS';
exports.category = 'iOS';
exports.description = "Interface to show iOS' action sheets";
exports.examples = [
  {
    title: 'Show Action Sheet',
    render(): React.Element<any> {
      return <Text>Do nothing</Text>;
    },
  },
];
