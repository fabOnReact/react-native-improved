import * as React from 'react';

import { View, StyleSheet, Text, TextInput } from 'react-native';
import { TextViewImproved } from 'react-native-text';

export default function App() {
  return (
    <View>
      <TextViewImproved style={styles.parentText}>New text</TextViewImproved>
      <Text>This is normal text</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  parentText: {
    width: 160,
    height: 60,
    marginVertical: 20,
    backgroundColor: 'red',
  },
  childText: {
    color: 'blue',
  },
});
