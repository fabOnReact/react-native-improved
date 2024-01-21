import * as React from 'react';

import { View, StyleSheet, Text, TextInput } from 'react-native';
import { TextInputScreen } from './TextInputScreen';

export default function App() {
  return <CurrentScreen />;
}

function CurrentScreen() {
  // return <TextScreen />;
  return <TextInputScreen />;
}

const styles = StyleSheet.create({});
