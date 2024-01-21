import * as React from 'react';
import { View, TextInput, StyleSheet } from 'react-native';

export function TextInputScreen() {
  return (
    <View style={styles.container}>
      <TextInput style={styles.input}>Hello World</TextInput>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    marginTop: 100,
  },
  input: {
    borderWidth: 1,
    height: 100,
    width: 400,
  },
});
