import * as React from 'react';

import { View, StyleSheet, Text, TextInput } from 'react-native';
import { TextViewImproved } from 'react-native-text';

export default function App() {
  const email =
    'From vincenzoddragon+five@gmail.com  From vincenzoddrlxagon+five@gmail.com';
  return (
    <>
      <View style={styles.container}>
        <View style={styles.flexBrokenStyle}>
          <TextViewImproved
            textBreakStrategy="simple"
            style={styles.parentText}
            numberOfLines={1}
          >
            {email}
          </TextViewImproved>
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
