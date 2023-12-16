import * as React from 'react';

import { View, StyleSheet, Text, TextInput } from 'react-native';
import { TextImproved, TextInputImproved } from 'react-native-improved';

export default function App() {
  const email =
    'From vincenzoddragon+five@gmail.com  From vincenzoddrlxagon+five@gmail.com';
  return (
    <View style={{ marginTop: 200 }}>
      <TextInput autoFocus={true}>React Native</TextInput>
      <TextInputImproved style={{ lineHeight: 24 }} value="समुद्री उल्लू">
        समुद्री उल्लू
      </TextInputImproved>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    padding: 8,
    backgroundColor: 'yellow',
  },
  flexBrokenStyle: {
    flexDirection: 'row',
  },
  parentText: {
    backgroundColor: 'red',
  },
  input: { borderWidth: 1 },
});
