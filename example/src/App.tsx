import * as React from 'react';

import { ScrollView, View, StyleSheet, Text, TextInput } from 'react-native';
import { TextScreen } from './TextScreen';
import { TextInputScreen } from './TextInputScreen';

export default function App() {
  const email =
    'From vincenzoddragon+five@gmail.com  From vincenzoddrlxagon+five@gmail.com';
  return <CurrentScreen />;
}

function CurrentScreen() {
  // return <TextScreen />;
  return <TextInputScreen />;
}

const styles = StyleSheet.create({});
