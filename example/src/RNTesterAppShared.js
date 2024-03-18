import * as React from 'react';

import { View, StyleSheet, Text, TextInput } from 'react-native';

export default function App() {
  const email =
    'From vincenzoddragon+five@gmail.com  From vincenzoddrlxagon+five@gmail.com';
  return (
    <>
      <View style={styles.container}>
        <View style={styles.flexBrokenStyle}>
          <Text
            textBreakStrategy="simple"
            style={styles.parentText}
            numberOfLines={1}
          >
            {email}
          </Text>
        </View>
      </View>
    </>
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
});
