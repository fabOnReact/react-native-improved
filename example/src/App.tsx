import * as React from 'react';

import { View, StyleSheet, Text, TextInput } from 'react-native';
import { TextViewImproved } from 'react-native-text';

export default function App() {
  return (
    <View>
      <TextViewImproved style={styles.parentText}>
        This is the new text
      </TextViewImproved>
      <Text>This is normal text</Text>
      <TextInput style={styles.input} />
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
    marginVertical: 20,
    backgroundColor: 'red',
  },
  childText: {
    color: 'blue',
  },
  input: {
    borderWidth: 1,
  },
});
