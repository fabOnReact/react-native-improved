/**
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *
 * @flow strict-local
 * @format
 */

/* eslint-disable no-alert */

import * as React from 'react';
import {
  Button,
  Modal,
  Platform,
  StyleSheet,
  Switch,
  Text,
  View,
} from 'react-native';
import type { RNTesterModuleExample } from '../../types/RNTesterTypes';
import type { Props as ModalProps } from 'react-native/Libraries/Modal/Modal';
import RNTOption from '../../components/RNTOption';
const RNTesterButton = require('../../components/RNTesterButton');

const animationTypes = ['slide', 'none', 'fade'];
const presentationStyles = [
  'fullScreen',
  'pageSheet',
  'formSheet',
  'overFullScreen',
];
const supportedOrientations = [
  'portrait',
  'portrait-upside-down',
  'landscape',
  'landscape-left',
  'landscape-right',
];

function ModalPresentation() {
  const [firstModalVisible, setFirstModalVisible] = React.useState(true);
  const [secondModalVisible, setSecondModalVisible] = React.useState(true);
  return (
    <View>
      <Modal visible={firstModalVisible} presentationStyle="pageSheet">
        <Text>This is first modal</Text>
        <Button
          title="dismiss first modal"
          onPress={() => setFirstModalVisible(false)}
        />
      </Modal>
    </View>
  );
}

const styles = StyleSheet.create({
  row: {
    flexWrap: 'wrap',
    flexDirection: 'row',
  },
  rowWithSpaceBetween: {
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  block: {
    borderColor: 'rgba(0,0,0, 0.1)',
    borderBottomWidth: 1,
    padding: 6,
  },
  inlineBlock: {
    padding: 6,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    borderColor: 'rgba(0,0,0, 0.1)',
    borderBottomWidth: 1,
  },
  title: {
    margin: 3,
    fontWeight: 'bold',
  },
  option: {
    marginRight: 8,
    marginTop: 6,
  },
  modalContainer: {
    flex: 1,
    justifyContent: 'center',
    padding: 20,
  },
  modalInnerContainer: {
    borderRadius: 10,
    backgroundColor: '#fff',
    padding: 10,
  },
  warning: {
    margin: 3,
    fontSize: 12,
    color: 'red',
  },
});

export default ({
  title: 'Modal Presentation',
  name: 'basic',
  description: 'Modals can be presented with or without animation',
  render: (): React.Node => <ModalPresentation />,
}: RNTesterModuleExample);
