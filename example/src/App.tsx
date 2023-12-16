import * as React from 'react';

import { View, StyleSheet, Text, TextInput } from 'react-native';
import { TextImproved, TextInputImproved } from 'react-native-improved';

export default function App() {
  const email =
    'From vincenzoddragon+five@gmail.com  From vincenzoddrlxagon+five@gmail.com';
  return (
    <View style={{ marginTop: 200 }}>
      <TextInputImproved
        value="Text"
        style={{ height: 50, width: 400 }}
        color="red"
      />
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
