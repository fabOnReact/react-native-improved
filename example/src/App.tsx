import * as React from 'react';

import { View, StyleSheet } from 'react-native';
import { TextViewImproved } from 'react-native-text';

export default function App() {
  return <TextViewImproved style={parentText} />;
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  parentText: {
    width: 60,
    height: 60,
    marginVertical: 20,
    backgroundColor: 'red',
  },
  childText: {
    color: 'blue',
  },
});
