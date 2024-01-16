# react-native-improved

Provides react-native components with different fixes (only tested on the old architecture):

- TextImproved includes fixes PR https://github.com/facebook/react-native/issues/39722

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

<TextImproved>A new text with additional fixes</TextImproved>;
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
