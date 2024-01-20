import * as React from 'react';

import { View, StyleSheet, Text, TextInput } from 'react-native';
import { TextImproved, TextInputImproved } from 'react-native-improved';

export default function App() {
  const [text, setText] = React.useState('');
  const email =
    'From vincenzoddragon+five@gmail.com  From vincenzoddrlxagon+five@gmail.com';
  console.log('text', text);
  return (
    <View style={{ marginTop: 200 }}>
      <TextInput autoFocus={true}>React Native</TextInput>
      <TextInputImproved style={{ lineHeight: 23 }}>
        Hello World
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
