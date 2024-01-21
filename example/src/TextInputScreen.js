import * as React from 'react';
import { View, TextInput, StyleSheet } from 'react-native';

export function TextInputScreen() {
  const [text, setText] = React.useState('');
  return (
    <View style={styles.container}>
      <TextInput
        onChangeText={(text) => {
          console.log('onChangeText text is: ', text);
          setText(text);
        }}
        style={styles.input}
      >
        {text}
      </TextInput>
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
