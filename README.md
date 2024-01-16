# react-native-improved

Provides react-native components with different fixes (old architecture). The library patches the original react-native Android implementation of the Text component without building it from source.

Use the `TextImproved` component instead of `Text` to apply the following patches:

- TextImproved: Issue https://github.com/facebook/react-native/issues/39722

## Set-up

In package.json

```diff
 "scripts": {
+  "postinstall": "./node_modules/react-native-improved/src/react_native_renderer_patch.sh"
 }
```

Then

## npm

```sh
npm install react-native-improved
```

## yarn

```sh
yarn add react-native-improved
```

## Usage

```js
import { TextImproved } from 'react-native-improved';

// The TextImproved component includes several react-native fixes

fixes;

function App() {
  return <TextImproved>A new text with additional fixes</TextImproved>;
}
```

## Feature Requests

If you want to ask for additional features in this library, you can open an [issue](https://github.com/fabriziobertoglio1987/react-native-improved/issues). I follow-up with your request.

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
